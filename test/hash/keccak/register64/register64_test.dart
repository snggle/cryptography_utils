import 'package:cryptography_utils/src/hash/keccak/register64/register64.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Tests for Register64 constructor', () {
    test('Should [return default values] when Register64 created WITHOUT parameters', () {
      // Arrange
      Register64 actualRegister64 = Register64();
      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0;
      int expectedLowerValue = 0;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });

    test('Should [return values] when initialized WITH specific parameters', () {
      // Arrange
      Register64 actualRegister64 = Register64(0x12345678, 0x9ABCDEF0);
      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0x12345678;
      int expectedLowerValue = 0x9ABCDEF0;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
  });

  group('Tests for Register64.setInt()', () {
    test('Should [return values] when set is called WITH one parameter.', () {
      // Arrange
      Register64 actualRegister64 = Register64();

      // Act
      actualRegister64.setInt(0x2A);
      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0x0;
      int expectedLowerValue = 0x2A;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });

    test('Should [return values] when set is called WITH two parameters.', () {
      // Arrange
      Register64 actualRegister64 = Register64();

      // Act
      actualRegister64.setInt(0x12345678, 0x9ABCDEF0);
      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0x12345678;
      int expectedLowerValue = 0x9ABCDEF0;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
  });

  group('Tests for Register64.setRegister64()', () {
    test('Should [return values] when set is called.', () {
      // Arrange
      Register64 actualRegister64 = Register64();
      Register64 actualValueRegister64 = Register64(0xA, 0x14);

      // Act
      actualRegister64.setRegister64(actualValueRegister64);
      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0xA;
      int expectedLowerValue = 0x14;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
  });

  group('Tests for Register64.performAnd()', () {
    test('Should [return result of logical AND operation] when performAnd() called', () {
      // Arrange
      Register64 actual1Register64 = Register64(0xFFFFFFFF, 0x00000000);
      Register64 actual2Register64 = Register64(0x0F0F0F0F, 0xFFFFFFFF);

      // Act
      actual1Register64.performAnd(actual2Register64);

      int actualUpperValue = actual1Register64.upperHalf;
      int actualLowerValue = actual1Register64.lowerHalf;

      // Assert
      int expectedUpperValue = 0x0F0F0F0F;
      int expectedLowerValue = 0x00000000;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
  });

  group('Tests for Register64.performOr()', () {
    test('Should [return result of logical OR operation] when performOr() called', () {
      // Arrange
      Register64 actual1Register64 = Register64(0x12345678, 0x00000000);
      Register64 actual2Register64 = Register64(0x00000000, 0x9ABCDEF0);

      // Act
      actual1Register64.performOr(actual2Register64);

      int actualUpperValue = actual1Register64.upperHalf;
      int actualLowerValue = actual1Register64.lowerHalf;

      // Assert
      int expectedUpperValue = 0x12345678;
      int expectedLowerValue = 0x9ABCDEF0;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
  });

  group('Tests for Register64.performXor()', () {
    test('Should [return result of logical XOR operation] when performXor() called', () {
      // Arrange
      Register64 actual1Register64 = Register64(0x12345678, 0x9ABCDEF0);
      Register64 actual2Register64 = Register64(0xFFFFFFFF, 0xFFFFFFFF);

      // Act
      actual1Register64.performXor(actual2Register64);
      int actualUpperValue = actual1Register64.upperHalf;
      int actualLowerValue = actual1Register64.lowerHalf;

      // Assert
      int expectedUpperValue = 0xEDCBA987;
      int expectedLowerValue = 0x6543210F;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
  });

  group('Tests for Register64.performNot()', () {
    test('Should [return result of logical NOT operation] when performNot() called', () {
      // Arrange
      Register64 actualRegister64 = Register64(0x12345678, 0x9ABCDEF0);

      // Act
      actualRegister64.performNot();

      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0xEDCBA987;
      int expectedLowerValue = 0x6543210F;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
  });

  group('Tests for Register64.shiftLeft()', () {
    test('Should [return default values] when shiftLeft() is called and shiftValue is equal to 0', () {
      // Arrange
      Register64 actualRegister64 = Register64(0x12345678, 0x9ABCDEF0);

      // Act
      actualRegister64.shiftLeft(0);

      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0x12345678;
      int expectedLowerValue = 0x9ABCDEF0;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
    test('Should [return result shifted] when shiftLeft() is called and shiftValue is different than zero', () {
      // Arrange
      Register64 actualRegister64 = Register64(0x00000000, 0x9ABCDEF0);

      // Act
      actualRegister64.shiftLeft(32);

      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0x9ABCDEF0;
      int expectedLowerValue = 0x00000000;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
  });

  group('Test for Register64.shiftRight', () {
    test('Should [return default values] when shiftRight() is called and shiftValue is equal to 0', () {
      // Arrange
      Register64 actualRegister64 = Register64(0x12345678, 0x9ABCDEF0);

      // Act
      actualRegister64.shiftRight(0);

      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0x12345678;
      int expectedLowerValue = 0x9ABCDEF0;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
    test('Should [return result shifted by the shiftedValue] when shiftRight() is called and shiftValue is different than zero', () {
      // Arrange
      Register64 actualRegister64 = Register64(0x80000000, 0x00000000);

      // Act
      actualRegister64.shiftRight(31);

      int actualUpperValue = actualRegister64.upperHalf;
      int actualLowerValue = actualRegister64.lowerHalf;

      // Assert
      int expectedUpperValue = 0x00000001;
      int expectedLowerValue = 0x00000000;

      expect(actualUpperValue, expectedUpperValue);
      expect(actualLowerValue, expectedLowerValue);
    });
  });
}
