import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of BigIntUtils.changeToBytes()', () {
    test('Should [return Endian.big bytes] constructed from given BigInt', () {
      // Arrange
      BigInt actualBigInt = BigInt.parse('1234567890');

      // Act
      Uint8List actualBytes = BigIntUtils.changeToBytes(actualBigInt);

      // Assert
      Uint8List expectedBytes = base64Decode('SZYC0g==');

      expect(actualBytes, expectedBytes);
    });

    test('Should [return padded Endian.big bytes] constructed from given BigInt and length', () {
      // Arrange
      BigInt actualBigInt = BigInt.parse('1234567890');

      // Act
      Uint8List actualBytes = BigIntUtils.changeToBytes(actualBigInt, length: 20);

      // Assert
      Uint8List expectedBytes = base64Decode('AAAAAAAAAAAAAAAAAAAAAEmWAtI=');

      expect(actualBytes, expectedBytes);
    });

    test('Should [return Endian.little bytes] constructed from given BigInt', () {
      // Arrange
      BigInt actualBigInt = BigInt.parse('1234567890');

      // Act
      Uint8List actualBytes = BigIntUtils.changeToBytes(actualBigInt, order: Endian.little);

      // Assert
      Uint8List expectedBytes = base64Decode('0gKWSQ==');

      expect(actualBytes, expectedBytes);
    });

    test('Should [return padded Endian.little bytes] constructed from given BigInt and length', () {
      // Arrange
      BigInt actualBigInt = BigInt.parse('1234567890');

      // Act
      Uint8List actualBytes = BigIntUtils.changeToBytes(actualBigInt, length: 20, order: Endian.little);

      // Assert
      Uint8List expectedBytes = base64Decode('0gKWSQAAAAAAAAAAAAAAAAAAAAA=');

      expect(actualBytes, expectedBytes);
    });
  });

  group('Tests of BigIntUtils.calculateByteLength()', () {
    test('Should [return number] representing size (in bytes) needed to store given BigInt', () {
      // Arrange
      BigInt actualBigInt = BigInt.parse('111222333444555666777888999000');

      // Act
      int actualByteLength = BigIntUtils.calculateByteLength(actualBigInt);

      // Assert
      int expectedByteLength = 13;

      expect(actualByteLength, expectedByteLength);
    });
  });

  group('Tests of BigIntUtils.computeNAF()', () {
    test('Should [return bytes] representing NAF (Non-adjacent form) for given BigInt', () {
      // Arrange
      BigInt actualBigInt = BigInt.parse('123');

      // Act
      List<BigInt> actualNAFList = BigIntUtils.computeNAF(actualBigInt);

      // Assert
      List<BigInt> expectedNAFList = <BigInt>[
        BigInt.parse('-1'),
        BigInt.parse('0'),
        BigInt.parse('-1'),
        BigInt.parse('0'),
        BigInt.parse('0'),
        BigInt.parse('0'),
        BigInt.parse('0'),
        BigInt.parse('1'),
      ];

      expect(actualNAFList, expectedNAFList);
    });
  });

  group('Tests of BigIntUtils.decodeWithSign()', () {
    test('Should [return signed BigInt] constructed from given bytes (sign POSITIVE)', () {
      // Arrange
      List<int> actualBytes = base64Decode('SZYC0g==');

      // Act
      BigInt actualBigInt = BigIntUtils.decodeWithSign(1, actualBytes);

      // Assert
      BigInt expectedBigInt = BigInt.parse('1234567890');

      expect(actualBigInt, expectedBigInt);
    });

    test('Should [return unsigned BigInt] constructed from given bytes (sign NEGATIVE)', () {
      // Arrange
      List<int> actualBytes = base64Decode('SZYC0g==');

      // Act
      BigInt actualBigInt = BigIntUtils.decodeWithSign(-1, actualBytes);

      // Assert
      BigInt expectedBigInt = BigInt.parse('-912915758');

      expect(actualBigInt, expectedBigInt);
    });

    test('Should [return zero] constructed from given bytes (sign == 0)', () {
      // Arrange
      List<int> actualBytes = base64Decode('SZYC0g==');

      // Act
      BigInt actualBigInt = BigIntUtils.decodeWithSign(0, actualBytes);

      // Assert
      BigInt expectedBigInt = BigInt.zero;

      expect(actualBigInt, expectedBigInt);
    });
  });

  group('Tests of BigIntUtils.decode()', () {
    test('Should [return BigInt] constructed from given [Endian.big bytes]', () {
      // Arrange
      List<int> actualBytes = base64Decode('SZYC0g==');

      // Act
      BigInt actualBigInt = BigIntUtils.decode(actualBytes);

      // Assert
      BigInt expectedBigInt = BigInt.parse('1234567890');

      expect(actualBigInt, expectedBigInt);
    });

    test('Should [return BigInt] constructed from given [Endian.little bytes]', () {
      // Arrange
      List<int> actualBytes = base64Decode('SZYC0g==');

      // Act
      BigInt actualBigInt = BigIntUtils.decode(actualBytes, order: Endian.little);

      // Assert
      BigInt expectedBigInt = BigInt.parse('3523384905');

      expect(actualBigInt, expectedBigInt);
    });
  });

  group('Tests of BigIntUtils.getBit()', () {
    test('Should [return TRUE] if given index has [bit == 1]', () {
      // Arrange
      BigInt actualNumber = BigInt.parse('110010101000100001010111', radix: 2);

      // Act
      bool actualBit = BigIntUtils.getBit(actualNumber, 2);

      // Assert
      expect(actualBit, true);
    });

    test('Should [return FALSE] if given index has [bit == 0]', () {
      // Arrange
      BigInt actualNumber = BigInt.parse('110010101000100001010111', radix: 2);

      // Act
      bool actualBit = BigIntUtils.getBit(actualNumber, 3);

      // Assert
      expect(actualBit, false);
    });
  });
}
