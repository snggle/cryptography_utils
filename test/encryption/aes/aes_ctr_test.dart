import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes_ctr.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_iv.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_text.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of AESctr.encrypt()', () {
    test('Should [return encrypted byte] constructed from given String', () {
      // Arrange
      Uint8List actualInputUint8List = Uint8List.fromList(utf8.encode('abcTest123!'));
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]));

      // Act
      CipherText actualCipherText = AESctr.encrypt(actualInputUint8List, actualAESKey, actualAESIV);

      // Assert
      CipherText expectedCipherText =
          CipherText(Uint8List.fromList(<int>[65, 203, 154, 198, 209, 63, 47, 217, 54, 44, 221, 217, 105, 171, 156, 111]));

      expect(actualCipherText, expectedCipherText);
    });
  });

  group('Tests of AESctr.decrypt()', () {
    test('Should [return decrypted String] constructed from encrypted data', () {
      // Arrange
      AESKey actualAESKey = AESKey(Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));
      AESIV actualAESIV = AESIV(Uint8List.fromList(<int>[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]));

      // Act
      CipherText actualCipherText = CipherText(Uint8List.fromList(<int>[65, 203, 154, 198, 209, 63, 47, 217, 54, 44, 221, 217, 105, 171, 156, 111]));
      Uint8List actualDecryptedUint8List = AESctr.decrypt(actualCipherText, actualAESKey, actualAESIV);

      // Assert
      Uint8List expectedDecryptedUint8List = Uint8List.fromList(utf8.encode('abcTest123!'));

      expect(actualDecryptedUint8List, expectedDecryptedUint8List);
    });
  });
}
