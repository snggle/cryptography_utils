import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes_engine.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_iv.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/ctr_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_key_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Tests of CTRBlockCipher.process()', () {
    test('Should [return encrypted data] constructed from given data', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]));
      CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

      CTRBlockCipher actualCTRBlockCipher = CTRBlockCipher(
        AESEngine(
          cipherMode: CipherMode.encryption,
          cipherKeyWithIV: actualCipherKeyWithIV,
        ),
      );

      Uint8List actualInputUint8List = Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);

      // Act
      Uint8List actualEncryptedUint8List = actualCTRBlockCipher.process(actualInputUint8List);

      // Assert
      Uint8List expectedEncryptedUint8List = Uint8List.fromList(<int>[32, 168, 251, 145, 176, 73, 93, 239, 12, 22]);

      expect(actualEncryptedUint8List, expectedEncryptedUint8List);
    });

    test('Should [return decrypted data] constructed from encrypted data', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21]));
      CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

      CTRBlockCipher actualCTRBlockCipher = CTRBlockCipher(
        AESEngine(
          cipherMode: CipherMode.decryption,
          cipherKeyWithIV: actualCipherKeyWithIV,
        ),
      );

      Uint8List actualEncryptedUint8List = Uint8List.fromList(<int>[3145, 210, 107, 61, 134, 27, 92, 89, 244, 170]);

      // Act
      Uint8List actualDecryptedUint8List = actualCTRBlockCipher.process(actualEncryptedUint8List);

      // Assert
      Uint8List expectedDecryptedUint8List = Uint8List.fromList(<int>[119, 28, 186, 114, 119, 121, 28, 154, 34, 12]);

      expect(actualDecryptedUint8List, expectedDecryptedUint8List);
    });

    test('Should [return encrypted data] with the same length as input', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[160, 150, 140, 130, 120, 110, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10]));
      CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

      CTRBlockCipher actualCTRBlockCipher = CTRBlockCipher(
        AESEngine(
          cipherMode: CipherMode.encryption,
          cipherKeyWithIV: actualCipherKeyWithIV,
        ),
      );
      Uint8List actualInputUint8List = Uint8List.fromList(<int>[21, 22, 23, 24, 25, 26, 27, 28, 29, 30]);

      // Act
      Uint8List actualOutputUint8List = actualCTRBlockCipher.process(actualInputUint8List);
      int actualLength = actualOutputUint8List.length;

      // Assert
      int expectedLength = 10;
      Uint8List expectedOutputUint8List = Uint8List.fromList(<int>[41, 148, 235, 8, 86, 92, 112, 15, 188, 226]);

      expect(actualLength, expectedLength);
      expect(actualOutputUint8List, expectedOutputUint8List);
    });
  });

  group('Tests of CTRBlockCipher.processBlock()', () {
    test('Should [return encrypted block] with the same length as input block', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[160, 150, 140, 130, 120, 110, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10]));
      CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

      CTRBlockCipher actualCTRBlockCipher = CTRBlockCipher(
        AESEngine(
          cipherMode: CipherMode.encryption,
          cipherKeyWithIV: actualCipherKeyWithIV,
        ),
      );

      Uint8List actualInputUint8List = Uint8List.fromList(<int>[1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31]);

      // Act
      Uint8List actualOutputUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      int actualLength = actualCTRBlockCipher.processBlock(actualInputUint8List, 0, actualOutputUint8List, 0);

      // Assert
      int expectedProcessedLength = 16;
      Uint8List expectedOutputUint8List = Uint8List.fromList(<int>[61, 129, 249, 23, 70, 77, 102, 28, 176, 239, 153, 4, 163, 233, 186, 167]);

      expect(actualLength, expectedProcessedLength);
      expect(actualOutputUint8List, expectedOutputUint8List);
    });

    test('Should [return decrypted block] with the same length as constructed from encrypted block', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[21, 31, 41, 51, 61, 71, 81, 91, 101, 111, 121, 131, 141, 151, 161, 171]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[171, 161, 151, 141, 131, 121, 111, 101, 91, 81, 71, 61, 51, 41, 31, 21]));
      CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

      CTRBlockCipher actualCTRBlockCipher = CTRBlockCipher(
        AESEngine(
          cipherMode: CipherMode.encryption,
          cipherKeyWithIV: actualCipherKeyWithIV,
        ),
      );

      Uint8List actualEncryptedUint8List = Uint8List.fromList(<int>[99, 42, 78, 164, 55, 208, 120, 67, 142, 26, 231, 198, 15, 104, 87, 63]);

      // Act
      Uint8List actualDecryptedUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      int actualLength = actualCTRBlockCipher.processBlock(actualEncryptedUint8List, 0, actualDecryptedUint8List, 0);

      // Assert
      Uint8List expectedEncryptedUint8List = Uint8List.fromList(<int>[120, 50, 101, 88, 208, 103, 214, 40, 31, 95, 29, 8, 176, 252, 21, 105]);
      int expectedProcessedLength = 16;

      expect(actualLength, expectedProcessedLength);
      expect(actualDecryptedUint8List, expectedEncryptedUint8List);
    });
  });
}
