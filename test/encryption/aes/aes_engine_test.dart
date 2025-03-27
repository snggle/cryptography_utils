import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes_engine.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Arrange
  late AesEngine aesEngine;
  final Uint8List actualKeyUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  final AesKey actualAesKey = AesKey(actualKeyUint8List);

  setUp(() {
    aesEngine = AesEngine();
  });

  group('Tests of AesEngine.init()', () {
    test('Should initialize for decryption without exception', () {
      // Arrange
      Uint8List actualKeyUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      AesKey aesKey = AesKey(actualKeyUint8List);

      // Act
      aesEngine.init(aesKey);
      int actualBlockSize = aesEngine.blockSize;

      // Assert
      int expectedBlockSize = 16;
      expect(actualBlockSize, expectedBlockSize);
    });
  });

  group('Tests of AesEngine.processBlock()', () {
    test('Should [return encrypts data] constructed from given data', () {
      // Arrange
      Uint8List inputUint8List = Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      Uint8List actualLengthOutputUint8List = Uint8List(16);

      // Act
      aesEngine.init(actualAesKey);
      int actualLength = aesEngine.processBlock(inputUint8List, 0, actualLengthOutputUint8List, 0);

      // Assert
      int expectedLength = 16;
      expect(actualLength, expectedLength);
    });

    test('Should [return decrypted data] constructed from encrypted data', () {
      // Arrange
      aesEngine.init(actualAesKey);
      Uint8List plaintextUint8List = Uint8List.fromList(<int>[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
      Uint8List encryptedUint8List = Uint8List(16);
      Uint8List actualLengthDecryptedUint8List = Uint8List(16);

      // Act
      aesEngine
        ..processBlock(plaintextUint8List, 0, encryptedUint8List, 0)
        ..init(actualAesKey);
      int actualLength = aesEngine.processBlock(encryptedUint8List, 0, actualLengthDecryptedUint8List, 0);

      // Assert
      int expectedLength = 16;
      expect(actualLength, expectedLength);
    });
  });

  group('Tests of AesEngine.process()', () {
    test('Should [return output length] constructed from given data', () {
      // Arrange
      Uint8List actualLengthInputUint8List = Uint8List.fromList(List<int>.filled(16, 0xAB));
      aesEngine.init(actualAesKey);

      // Act
      Uint8List actualOutputUint8List = aesEngine.process(actualLengthInputUint8List);
      int actualOutputLength = actualOutputUint8List.length;

      // Assert
      int expectedOutputLength = 16;
      expect(actualOutputLength, expectedOutputLength);
    });
  });
}
