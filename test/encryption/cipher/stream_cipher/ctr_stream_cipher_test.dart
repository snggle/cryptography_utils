import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes_engine.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_iv.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_key_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';
import 'package:cryptography_utils/src/encryption/cipher/stream_cipher/ctr_stream_cipher.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Tests of CTRStreamCipher.processBytes()', () {
    test('Should [return encrypted byte] constructed from given data', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]));
      CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

      AESEngine actualBlockCipher = AESEngine(
        cipherMode: CipherMode.encryption,
        cipherKeyWithIV: actualCipherKeyWithIV,
      );

      Uint8List inputUint8List = Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
      CTRStreamCipher actualCTRStreamCipher = CTRStreamCipher(actualBlockCipher);

      // Act
      Uint8List actualEncryptedUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      actualCTRStreamCipher.processBytes(inputUint8List, 0, inputUint8List.length, actualEncryptedUint8List, 0);

      // Assert
      Uint8List expectedEncryptedUint8List = Uint8List.fromList(<int>[32, 168, 251, 145, 176, 73, 93, 239, 12, 22]);

      expect(actualEncryptedUint8List, expectedEncryptedUint8List);
    });

    test('Should [return decrypted byte] constructed from encrypted data', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[21, 31, 41, 51, 61, 71, 81, 91, 101, 111, 121, 131, 141, 151, 161, 171]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[171, 161, 151, 141, 131, 121, 111, 101, 91, 81, 71, 61, 51, 41, 31, 21]));
      CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

      AESEngine actualBlockCipher = AESEngine(
        cipherMode: CipherMode.encryption,
        cipherKeyWithIV: actualCipherKeyWithIV,
      );

      Uint8List actualEncryptedUint8List = Uint8List.fromList(<int>[222, 109, 178, 62, 17, 88, 139, 243, 15, 200]);
      CTRStreamCipher actualCTRStreamCipher = CTRStreamCipher(actualBlockCipher);

      // Act
      Uint8List actualDecryptedUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      actualCTRStreamCipher.processBytes(actualEncryptedUint8List, 0, actualEncryptedUint8List.length, actualDecryptedUint8List, 0);

      // Assert
      Uint8List expectedDecryptedUint8List = Uint8List.fromList(<int>[197, 117, 153, 194, 246, 239, 37, 152, 158, 141]);

      expect(actualDecryptedUint8List, expectedDecryptedUint8List);
    });

    test('Should [return encrypted byte] constructed from partial bytes stream', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[5, 15, 25, 35, 45, 55, 65, 75, 85, 95, 105, 115, 125, 135, 145, 155]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[155, 145, 135, 125, 115, 105, 95, 85, 75, 65, 55, 45, 35, 25, 15, 5]));
      CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

      AESEngine actualBlockCipher = AESEngine(
        cipherMode: CipherMode.encryption,
        cipherKeyWithIV: actualCipherKeyWithIV,
      );

      Uint8List inputUint8List = Uint8List.fromList(<int>[0xDE, 0xAD, 0xBE]);
      CTRStreamCipher actualCTRStreamCipher = CTRStreamCipher(actualBlockCipher);

      // Act
      Uint8List actualEncryptedUint8List = Uint8List.fromList(<int>[0, 0, 0]);
      actualCTRStreamCipher.processBytes(inputUint8List, 0, 3, actualEncryptedUint8List, 0);

      // Assert
      Uint8List expectedEncryptedUint8List = Uint8List.fromList(<int>[51, 183, 159]);

      expect(actualEncryptedUint8List, expectedEncryptedUint8List);
    });

    test('Should [return decrypted byte] constructed from encrypted partial bytes stream', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[6, 16, 26, 36, 46, 56, 66, 76, 86, 96, 106, 116, 126, 136, 146, 156]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[156, 146, 136, 126, 116, 106, 96, 86, 76, 66, 56, 46, 36, 26, 16, 6]));
      CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

      AESEngine actualBlockCipher = AESEngine(
        cipherMode: CipherMode.decryption,
        cipherKeyWithIV: actualCipherKeyWithIV,
      );

      Uint8List encryptedUint8List = Uint8List.fromList(<int>[211, 49, 27]);
      CTRStreamCipher actualCTRStreamCipher = CTRStreamCipher(actualBlockCipher);

      // Act
      Uint8List actualDecryptedUint8List = Uint8List.fromList(<int>[0, 0, 0]);
      actualCTRStreamCipher.processBytes(encryptedUint8List, 0, 3, actualDecryptedUint8List, 0);

      // Assert
      Uint8List expectedDecryptedUint8List = Uint8List.fromList(<int>[229, 128, 198]);

      expect(actualDecryptedUint8List, expectedDecryptedUint8List);
    });
  });
}
