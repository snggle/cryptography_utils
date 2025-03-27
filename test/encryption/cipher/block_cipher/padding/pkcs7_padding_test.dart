import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/cipher/block_cipher/invalid_length_exception.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/invalid_padding_value_exception.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/padding/pkcs7_padding.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of Pkcs7Padding.addPadding()', () {
    test('Should [return  number of bytes added and padding] constructed from given data', () {
      // Arrange
      Uint8List actualPaddedUint8List = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0]);

      // Act
      int actualPaddedCode = Pkcs7Padding().addPadding(actualPaddedUint8List, 8);

      // Assert
      int expectedPaddedCode = 8;
      Uint8List expectedPaddedUint8List = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8]);

      expect(actualPaddedCode, expectedPaddedCode);
      expect(actualPaddedUint8List, expectedPaddedUint8List);
    });
  });

  group('Tests of Pkcs7Padding.countPadding()', () {
    test('Should [return counted padding] constructed from given data', () {
      // Arrange
      Uint8List actualPaddedUint8List = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8]);

      // Act
      int actualCount = Pkcs7Padding().countPadding(actualPaddedUint8List);

      // Assert
      int expectedCount = 8;

      expect(actualCount, expectedCount);
    });

    test('Should [return padding count] when last 7 bytes match', () {
      // Arrange
      Uint8List actualPadded = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 7, 7, 7, 7, 7, 7]);

      // Act
      int actualPaddedCounted = Pkcs7Padding().countPadding(actualPadded);

      // Assert
      int expectedPaddedCounted = 7;

      expect(actualPaddedCounted, expectedPaddedCounted);
    });

    test('Should [throw InvalidLengthException] when trying to DECRYPT invalid ciphertext', () {
      // Arrange
      Uint8List actualUint8List = Uint8List.fromList(<int>[1, 2, 3, 5]);

      // Assert
      expect(() => Pkcs7Padding().countPadding(actualUint8List), throwsA(isA<InvalidLengthException>()));
    });

    test('Should [throw InvalidPaddingValueException] when trying to DECRYPT invalid ciphertext', () {
      // Arrange
      Uint8List actualUint8List = Uint8List.fromList(<int>[1, 2, 3, 3, 2, 3]);

      // Assert
      expect(() => Pkcs7Padding().countPadding(actualUint8List), throwsA(isA<InvalidPaddingValueException>()));
    });
  });
}
