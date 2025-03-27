import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes_engine.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_iv.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/ctr_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/invalid_length_exception.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/padded_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/padding/pkcs7_padding.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_key_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  // Arrange
  AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));
  AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]));

  CipherKeyWithIV<AESKey> actualCipherKeyWithIV = CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List);

  group('Tests of PaddedBlockCipher.process()', () {
    test('Should [return encrypted bytes] constructed from given data', () {
      // Arrange
      PaddedBlockCipher actualPaddedBlockCipher = PaddedBlockCipher(
        blockCipher: CTRBlockCipher(AESEngine(
          cipherMode: CipherMode.encryption,
          cipherKeyWithIV: actualCipherKeyWithIV,
        )),
        cipherPadding: Pkcs7Padding(),
      );

      // Act
      Uint8List actualInputUint8List = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      Uint8List actualEncryptedUint8List = actualPaddedBlockCipher.process(actualInputUint8List);

      // Assert
      Uint8List expectedEncryptedUint8List = Uint8List.fromList(<int>[33, 171, 250, 150, 177, 74, 92, 224, 13, 21, 250, 218, 106, 168, 159, 108]);

      expect(actualEncryptedUint8List, expectedEncryptedUint8List);
    });

    test('Should [return decrypted bytes] constructed from encrypted data', () {
      // Arrange
      PaddedBlockCipher actualPaddedBlockCipher = PaddedBlockCipher(
        blockCipher: CTRBlockCipher(
          AESEngine(
            cipherMode: CipherMode.decryption,
            cipherKeyWithIV: actualCipherKeyWithIV,
          ),
        ),
        cipherPadding: Pkcs7Padding(),
      );

      // Act
      Uint8List actualEncryptedUint8List = Uint8List.fromList(<int>[33, 171, 250, 150, 177, 74, 92, 224, 13, 21, 250, 218, 106, 168, 159, 108]);
      Uint8List actualDecryptedUint8List = actualPaddedBlockCipher.process(actualEncryptedUint8List);

      // Assert
      Uint8List expectedDecryptedUint8List = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

      expect(actualDecryptedUint8List, expectedDecryptedUint8List);
    });

    test('Should [throw InvalidLengthException] when trying to DECRYPT invalid data', () {
      // Arrange
      PaddedBlockCipher actualPaddedBlockCipher = PaddedBlockCipher(
        blockCipher: CTRBlockCipher(
          AESEngine(
            cipherMode: CipherMode.decryption,
            cipherKeyWithIV: actualCipherKeyWithIV,
          ),
        ),
        cipherPadding: Pkcs7Padding(),
      );

      Uint8List actualInput = Uint8List(30);

      // Assert
      expect(() => actualPaddedBlockCipher.process(actualInput), throwsA(isA<InvalidLengthException>()));
    });
  });

  group('Tests of PaddedBlockCipher.processBlock()', () {
    test('Should [return encrypted bytes] constructed from given data', () {
      // Arrange
      PaddedBlockCipher actualPaddedBlockCipher = PaddedBlockCipher(
        blockCipher: CTRBlockCipher(
          AESEngine(
            cipherMode: CipherMode.encryption,
            cipherKeyWithIV: actualCipherKeyWithIV,
          ),
        ),
        cipherPadding: Pkcs7Padding(),
      );
      Uint8List actualInputUint8List = Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);

      // Act
      Uint8List actualOutputUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      actualPaddedBlockCipher.processBlock(actualInputUint8List, 0, actualOutputUint8List, 0);

      // Assert
      Uint8List expectedOutputUint8List = Uint8List.fromList(<int>[32, 168, 251, 145, 176, 73, 93, 239, 12, 22, 246, 215, 96, 163, 151, 101]);

      expect(actualOutputUint8List, expectedOutputUint8List);
    });

    test('Should [return decrypted bytes] constructed from encrypted data', () {
      // Arrange
      PaddedBlockCipher actualPaddedBlockCipher = PaddedBlockCipher(
        blockCipher: CTRBlockCipher(
          AESEngine(
            cipherMode: CipherMode.decryption,
            cipherKeyWithIV: actualCipherKeyWithIV,
          ),
        ),
        cipherPadding: Pkcs7Padding(),
      );

      Uint8List actualEncryptedBlock = Uint8List.fromList(<int>[32, 168, 251, 145, 176, 73, 93, 239, 12, 22, 246, 215, 96, 163, 151, 101]);

      // Act
      Uint8List actualDecryptedUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      actualPaddedBlockCipher.processBlock(actualEncryptedBlock, 0, actualDecryptedUint8List, 0);

      // Assert
      Uint8List expectedDecryptedUint8List = Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);

      expect(actualDecryptedUint8List, expectedDecryptedUint8List);
    });
  });
}
