import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:encrypt/encrypt.dart' as ext;

/// The AESDHKE class is a cryptographic implementation combining AES (Advanced Encryption Standard)
/// for symmetric data encryption and DHKE (Diffie-Hellman Key Exchange) for secure key establishment.
/// This class enables secure data transmission over insecure channels by first establishing
/// a shared secret key through DHKE and then using AES for data encryption and decryption.
class AESDHKEV1 implements IEncryptionAlgorithm {
  @override
  Ciphertext encrypt(String password, String plaintext) {
    List<int> randomBytes = ext.SecureRandom(16).bytes;

    List<int> hashedPasswordBytes = sha256.convert(utf8.encode(password)).bytes;
    List<int> securePasswordBytes = sha256.convert(randomBytes + hashedPasswordBytes).bytes;

    ext.Key key = ext.Key.fromBase64(base64Encode(hashedPasswordBytes));
    ext.Encrypter encrypter = ext.Encrypter(ext.AES(key));

    Uint8List initializationVectorBytes = Uint8List.fromList(securePasswordBytes.getRange(0, 16).toList());
    ext.IV initializationVector = ext.IV(initializationVectorBytes);
    List<int> encryptedDataBytes = encrypter.encrypt(plaintext, iv: initializationVector).bytes;

    List<int> checksumBytes = securePasswordBytes.getRange(securePasswordBytes.length - 4, securePasswordBytes.length).toList();
    List<int> encryptedStringBytes = randomBytes + encryptedDataBytes + checksumBytes;

    return Ciphertext(
      encryptionAlgorithmType: EncryptionAlgorithmType.aesdhke,
      bytes: encryptedStringBytes,
    );
  }

  @override
  String decrypt(String password, Ciphertext ciphertext) {
    List<int> hashedPasswordBytes = sha256.convert(utf8.encode(password)).bytes;

    List<int> encryptedStringBytes = ciphertext.bytes;
    List<int> randomBytes = encryptedStringBytes.getRange(0, 16).toList();
    List<int> encryptedDataBytes = encryptedStringBytes.getRange(16, encryptedStringBytes.length - 4).toList();
    List<int> securePasswordBytes = sha256.convert(randomBytes + hashedPasswordBytes).bytes;

    ext.Key key = ext.Key.fromBase64(base64Encode(hashedPasswordBytes));
    ext.Encrypter encrypter = ext.Encrypter(ext.AES(key));

    Uint8List initializationVectorBytes = Uint8List.fromList(securePasswordBytes.getRange(0, 16).toList());
    ext.IV initializationVector = ext.IV(initializationVectorBytes);

    String plaintext = encrypter.decrypt(ext.Encrypted(Uint8List.fromList(encryptedDataBytes)), iv: initializationVector);
    return plaintext;
  }

  @override
  bool isPasswordValid(String password, Ciphertext ciphertext) {
    List<int> hashedPasswordBytes = sha256.convert(utf8.encode(password)).bytes;

    List<int> encryptedStringBytes = base64Decode(ciphertext.base64);
    List<int> randomBytes = encryptedStringBytes.getRange(0, 16).toList();
    List<int> expectedChecksumBytes = encryptedStringBytes.getRange(encryptedStringBytes.length - 4, encryptedStringBytes.length).toList();

    List<int> securePasswordBytes = sha256.convert(randomBytes + hashedPasswordBytes).bytes;
    List<int> actualChecksumBytes = securePasswordBytes.getRange(securePasswordBytes.length - 4, securePasswordBytes.length).toList();

    return actualChecksumBytes.toString() == expectedChecksumBytes.toString();
  }
}
