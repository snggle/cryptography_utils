import 'dart:typed_data';

import 'package:cryptography_utils/src/utils/int32_utils.dart';
import 'package:cryptography_utils/src/utils/register64/register64.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests for Register64.packInput32()', () {
    test('Should [return value in big Endian] constructed from given data', () {
      // Arrange
      Uint8List buffer = Uint8List(8);

      // Act
      Int32Utils().pack(0xAABBCCDD, buffer, 4, Endian.big);
      Uint8List actualUint8List = buffer.sublist(4, 8);

      // Assert
      Uint8List expectedUint8List = Uint8List.fromList(<int>[0xAA, 0xBB, 0xCC, 0xDD]);
      expect(actualUint8List, expectedUint8List);
    });

    test('Should [return value in little Endian] constructed from given data', () {
      // Arrange
      Uint8List buffer = Uint8List(4);

      // Act
      Int32Utils().pack(0x12345678, buffer, 0, Endian.little);
      Uint8List actualUint8List = buffer.sublist(0, 4);

      // Assert
      Uint8List expectedUint8List = Uint8List.fromList(<int>[0x78, 0x56, 0x34, 0x12]);
      expect(actualUint8List, expectedUint8List);
    });
  });

  group('Tests for Register64.rotateRight32Bits()', () {
    test('Should [return value] when rotateRight32Bits() is called and offset is different than 0', () {
      // Act
      int actualValue = Int32Utils.rotateRight(0x12345678, 8);

      // Assert
      int expectedValue = 0x78123456;
      expect(actualValue, expectedValue);
    });

    test('Should [return value] when rotateRight32Bits() is called and offset is equal to 0', () {
      // Act
      int actualValue = Int32Utils.rotateRight(0x12345678, 0);

      // Assert
      int expectedValue = 0x12345678;
      expect(actualValue, expectedValue);
    });
  });

  group('Tests for Register64.shiftRight32Bits()', () {
    test('Should [return value] when shiftRight32Bits() is called and shiftValue is different than zero', () {
      // Act
      int actualValue = Int32Utils.shiftRight(0x80000000, 1);

      // Assert
      int expectedValue = 0x40000000;
      expect(actualValue, expectedValue);
    });

    test('Should [return value] when shiftRight32Bits() is called and shiftValue is equal to zero', () {
      // Act
      int actualValue = Int32Utils.shiftRight(0x80000000, 0);

      // Assert
      int expectedValue = 0x80000000;
      expect(actualValue, expectedValue);
    });
  });

  group('Tests for Register64.unpackInput32Bits()', () {
    test('Should [return value in little Endian] constructed from given data', () {
      // Arrange
      Uint8List inputBytes = Uint8List.fromList(<int>[0x78, 0x56, 0x34, 0x12]);

      // Act
      int actualValue = Int32Utils.unpack(inputBytes, 0, Endian.little);

      // Assert
      int expectedValue = 0x12345678;
      expect(actualValue, expectedValue);
    });

    test('Should [return value in bIG Endian] constructed from given data', () {
      // Arrange
      Uint8List inputBytes = Uint8List.fromList(<int>[0x12, 0x34, 0x56, 0x78]);

      // Act
      int actualValue = Int32Utils.unpack(inputBytes, 0, Endian.big);

      // Assert
      int expectedValue = 0x12345678;
      expect(actualValue, expectedValue);
    });
  });

  group('Tests for Register64.rotateLeft32Bits()', () {
    test('Should [return value] when rotateLeft32Bits() is called and offset is equal to 0', () {
      // Arrange
      Register64 actualRegister64 = Register64(0x00000000, 0x12345678);

      // Act
      int actualValue = Int32Utils.rotateLeft(actualRegister64.lowerHalf, 0);

      // Assert
      int expectedValue = 0x12345678;

      expect(actualValue, expectedValue);
    });

    test('Should [return value] when rotateLeft32Bits() is called and offset is different than 0', () {
      // Arrange
      Register64 actualRegister64 = Register64(0x00000000, 0x12345678);

      // Act
      int actualValue = Int32Utils.rotateLeft(actualRegister64.lowerHalf, 40);

      // Assert
      int expectedValue = 0x34567812;

      expect(actualValue, expectedValue);
    });
  });
}
