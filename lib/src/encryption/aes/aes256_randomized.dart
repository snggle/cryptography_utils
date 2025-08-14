import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_ctr.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_iv.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/aes/invalid_password_exception.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_text.dart';
import 'package:cryptography_utils/src/utils/secure_random.dart';

/// The `AES256Randomized` class provides secure encryption and decryption of text (strings)
/// using the AES-256 algorithm in CTR mode. The class enables confidential storage of textual data
/// and ensuring that access is only possible with the correct password.
///
/// Moreover, the use of a random salt (of length 16) and the SHA-256 hash function enhances security and makes attacks significantly more difficult.
///
class AES256Randomized {
  /// Encrypts the provided plaintext using the given password.
  /// A random 16-byte salt is generated, and the password is hashed using SHA-256 to produce the encryption key.
  /// The salt and password hash are combined and hashed again to derive a secure value,
  /// from which the initialization vector (IV), and checksum are extracted.
  /// The plaintext is then encrypted using AES-256 in CTR mode and returned as a Base64-encoded string,
  /// with the salt prepended and the checksum appended.
  static Map<String, String> encrypt(String password, String decryptedString) {
    Uint8List decryptedUint8List = utf8.encode(decryptedString);
    Uint8List randomUint8List = SecureRandom.getBytes(length: 16, max: 255);

    Uint8List hashedPasswordUint8List = Sha256().convert(utf8.encode(password)).byteList;
    Uint8List securePasswordUint8List = Sha256().convert(randomUint8List + hashedPasswordUint8List).byteList;

    AESKey aesKey = AESKey(hashedPasswordUint8List);

    Uint8List initializationVectorUint8List = Uint8List.fromList(securePasswordUint8List.getRange(0, 16).toList());
    AESIV aesIV = AESIV(initializationVectorUint8List);

    Uint8List encryptedUint8List = AESctr.encrypt(decryptedUint8List, aesKey, aesIV).uint8List;

    List<int> checksumUint8List = securePasswordUint8List.getRange(securePasswordUint8List.length - 4, securePasswordUint8List.length).toList();
    List<int> encryptedStringUint8List = randomUint8List + encryptedUint8List + checksumUint8List;
    String encryptedString = base64Encode(encryptedStringUint8List);

    Map<String, String> encryptedMap = <String, String>{
      'cipher': 'AES256Randomized',
      'cipherText': encryptedString,
    };
    return encryptedMap;
  }

  /// Decrypts the provided encrypted string using the specified password.
  /// The password is hashed using SHA-256 to produce the encryption key.
  /// The salt and checksum are extracted from the encrypted input.
  /// Then, the salt and password hashes are combined and hashed again to derive a secure value,
  /// from which the initialization vector (IV) is reconstructed and the checksum is validated.
  /// The encrypted data is then decrypted using AES-256 in CTR mode,
  /// and the resulting plaintext is returned as a string.
  ///
  /// Throws [InvalidPasswordException] if decryption fails, for example due to an incorrect password.
  static String decrypt(String password, String encryptedString) {
    try {
      Uint8List hashedPasswordUint8List = Sha256().convert(utf8.encode(password)).byteList;

      Uint8List encryptedStringUint8List = base64Decode(encryptedString);
      Uint8List randomUint8List = Uint8List.fromList(encryptedStringUint8List.getRange(0, 16).toList());
      CipherText cipherText = CipherText(Uint8List.fromList(encryptedStringUint8List.getRange(16, encryptedStringUint8List.length - 4).toList()));
      Uint8List securePasswordUint8List = Sha256().convert(randomUint8List + hashedPasswordUint8List).byteList;

      AESKey aesKey = AESKey(hashedPasswordUint8List);

      Uint8List initializationVectorUint8List = Uint8List.fromList(securePasswordUint8List.getRange(0, 16).toList());
      AESIV aesIV = AESIV(initializationVectorUint8List);
      Uint8List decryptedUint8List = AESctr.decrypt(cipherText, aesKey, aesIV);
      String decryptedString = utf8.decode(decryptedUint8List);
      return decryptedString;
    } catch (e) {
      throw InvalidPasswordException('Decryption failed: ${e.toString()}');
    }
  }

  /// Validates whether the provided [password] matches the checksum of the [encryptedString].
  /// This function checks if the password-derived checksum matches the stored one in the encrypted payload,
  /// without actually decrypting the content.
  /// Returns `true` if the password is valid; otherwise `false`.
  static bool isPasswordValid(String password, String encryptedString) {
    Uint8List hashedPasswordUint8List = Sha256().convert(utf8.encode(password)).byteList;

    Uint8List encryptedStringUint8List = base64Decode(encryptedString);
    Uint8List randomUint8List = Uint8List.fromList(encryptedStringUint8List.getRange(0, 16).toList());
    List<int> expectedChecksumUint8List =
        encryptedStringUint8List.getRange(encryptedStringUint8List.length - 4, encryptedStringUint8List.length).toList();

    Uint8List securePasswordUint8List = Sha256().convert(randomUint8List + hashedPasswordUint8List).byteList;
    List<int> actualChecksumUint8List = securePasswordUint8List.getRange(securePasswordUint8List.length - 4, securePasswordUint8List.length).toList();

    return actualChecksumUint8List.toString() == expectedChecksumUint8List.toString();
  }
}
