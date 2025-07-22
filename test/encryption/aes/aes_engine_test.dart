import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes_engine.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_iv.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_key_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of AesEngine.process()', () {
    test('Should [return encrypted bytes] constructed from given data', () {
      // Arrange
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));

      AESEngine actualAESEngine =
          AESEngine(cipherMode: CipherMode.encryption, cipherKeyWithIV: CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List));
      Uint8List actualInputUint8Lis = Uint8List.fromList(<int>[171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171]);

      // Act
      Uint8List actualUint8List = actualAESEngine.process(actualInputUint8Lis);

      // Assert
      Uint8List expectedUint8List = Uint8List.fromList(<int>[72, 77, 234, 245, 115, 247, 44, 82, 70, 226, 70, 8, 248, 231, 87, 199]);

      expect(actualUint8List, expectedUint8List);
    });
  });

  group('Tests of AesEngine.processBlock()', () {
    test('Should [return encrypted bytes] based on given data', () {
      // Arrange
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160]));
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[160, 150, 140, 130, 120, 110, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10]));

      AESEngine actualAESEngine =
          AESEngine(cipherMode: CipherMode.encryption, cipherKeyWithIV: CipherKeyWithIV<AESKey>(actualAESKey, actualAESIV.uint8List));
      Uint8List actualInputUint8Lis = Uint8List.fromList(<int>[1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31]);

      // Act
      Uint8List actualUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      actualAESEngine.processBlock(actualInputUint8Lis, 0, actualUint8List, 0);

      // Assert
      Uint8List expectedUint8List = Uint8List.fromList(<int>[180, 192, 253, 203, 105, 158, 34, 129, 232, 178, 157, 100, 108, 54, 160, 241]);

      expect(actualUint8List, expectedUint8List);
    });
  });
}
