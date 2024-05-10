import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of LegacyDerivationPathElement.parse() constructor', () {
    test('Should [return LegacyDerivationPathElement] from [HARDENED path element as String]', () {
      // Act
      LegacyDerivationPathElement actualLegacyDerivationPathElement = LegacyDerivationPathElement.parse("44'");

      // Assert
      LegacyDerivationPathElement expectedLegacyDerivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, rawIndex: 44);

      expect(actualLegacyDerivationPathElement, expectedLegacyDerivationPathElement);
    });

    test('Should [return LegacyDerivationPathElement] from [NOT HARDENED path element as String]', () {
      // Act
      LegacyDerivationPathElement actualLegacyDerivationPathElement = LegacyDerivationPathElement.parse('0');

      // Assert
      LegacyDerivationPathElement expectedLegacyDerivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, rawIndex: 0);

      expect(actualLegacyDerivationPathElement, expectedLegacyDerivationPathElement);
    });

    test('Should [throw FormatException] if provided [path element INVALID]', () {
      // Assert
      expect(() => LegacyDerivationPathElement.parse('0x'), throwsFormatException);
    });
  });

  group('Tests of LegacyDerivationPathElement.fromShiftedIndex() constructor', () {
    test('Should [return LegacyDerivationPathElement] with hardened index', () {
      // Arrange
      int actualShiftedIndex = 2147483692;

      // Act
      LegacyDerivationPathElement actualLegacyDerivationPathElement = LegacyDerivationPathElement.fromShiftedIndex(actualShiftedIndex);

      // Assert
      LegacyDerivationPathElement expectedLegacyDerivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, rawIndex: 44);

      expect(actualLegacyDerivationPathElement, expectedLegacyDerivationPathElement);
    });

    test('Should [return LegacyDerivationPathElement] with soft index', () {
      // Arrange
      int actualShiftedIndex = 44;

      // Act
      LegacyDerivationPathElement actualLegacyDerivationPathElement = LegacyDerivationPathElement.fromShiftedIndex(actualShiftedIndex);

      // Assert
      LegacyDerivationPathElement expectedLegacyDerivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, rawIndex: 44);

      expect(actualLegacyDerivationPathElement, expectedLegacyDerivationPathElement);
    });
  });

  group('Tests of LegacyDerivationPathElement.isHardened getter', () {
    test('Should [return TRUE] if [path element HARDENED]', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, rawIndex: 0);

      // Act
      bool actualHardenedBool = derivationPathElement.isHardened;

      // Assert
      expect(actualHardenedBool, true);
    });

    test('Should [return FALSE] if [path element NOT HARDENED]', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, rawIndex: 0);

      // Act
      bool actualHardenedBool = derivationPathElement.isHardened;

      // Assert
      expect(actualHardenedBool, false);
    });
  });

  group('Tests of LegacyDerivationPathElement.rawIndex getter', () {
    test('Should [return number] identifying index of (HARDENED path element)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, rawIndex: 44);

      // Act
      int actualRawIndex = derivationPathElement.rawIndex;

      // Assert
      int expectedRawIndex = 44;

      expect(actualRawIndex, expectedRawIndex);
    });

    test('Should [return number] identifying index of (NOT HARDENED path element)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, rawIndex: 44);

      // Act
      int actualRawIndex = derivationPathElement.rawIndex;

      // Assert
      int expectedRawIndex = 44;

      expect(actualRawIndex, expectedRawIndex);
    });
  });

  group('Tests of LegacyDerivationPathElement.shiftedIndex getter', () {
    test('Should [return number] identifying index of (HARDENED path element)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, rawIndex: 44);

      // Act
      int actualShiftedIndex = derivationPathElement.shiftedIndex;

      // Assert
      int expectedShiftedIndex = 2147483692;

      expect(actualShiftedIndex, expectedShiftedIndex);
    });

    test('Should [return number] identifying index of (NOT HARDENED path element)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, rawIndex: 44);

      // Act
      int actualShiftedIndex = derivationPathElement.shiftedIndex;

      // Assert
      int expectedShiftedIndex = 44;

      expect(actualShiftedIndex, expectedShiftedIndex);
    });
  });

  group('Tests of LegacyDerivationPathElement.toBytes()', () {
    test('Should [return BYTES] constructed from LegacyDerivationPathElement index (zero value)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, rawIndex: 0);

      // Act
      List<int> actualBytes = derivationPathElement.toBytes();

      // Assert
      List<int> expectedBytes = <int>[0, 0, 0, 0];
      expect(actualBytes, expectedBytes);
    });

    test('Should [return BYTES] constructed from LegacyDerivationPathElement index (non-zero value)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, rawIndex: 44);

      // Act
      List<int> actualBytes = derivationPathElement.toBytes();

      // Assert
      List<int> expectedBytes = <int>[128, 0, 0, 44];
      expect(actualBytes, expectedBytes);
    });
  });

  group('Test of LegacyDerivationPathElement.toString()', () {
    test('Should [return String] identifying (HARDENED path element)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, rawIndex: 44);

      // Act
      String actualString = derivationPathElement.toString();

      // Assert
      String expectedString = "44'";
      expect(actualString, expectedString);
    });

    test('Should [return String] identifying (NOT HARDENED path element)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, rawIndex: 44);

      // Act
      String actualString = derivationPathElement.toString();

      // Assert
      String expectedString = '44';
      expect(actualString, expectedString);
    });
  });
}
