import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of LegacyDerivationPathElement.parse() constructor', () {
    test('Should [return LegacyDerivationPathElement] from [HARDENED path element as String]', () {
      // Act
      LegacyDerivationPathElement actualLegacyDerivationPathElement = LegacyDerivationPathElement.parse("44'");

      // Assert
      LegacyDerivationPathElement expectedLegacyDerivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, index: 2147483692, value: "44'");

      expect(actualLegacyDerivationPathElement, expectedLegacyDerivationPathElement);
    });

    test('Should [return LegacyDerivationPathElement] from [NOT HARDENED path element as String]', () {
      // Act
      LegacyDerivationPathElement actualLegacyDerivationPathElement = LegacyDerivationPathElement.parse('0');

      // Assert
      LegacyDerivationPathElement expectedLegacyDerivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, index: 0, value: '0');

      expect(actualLegacyDerivationPathElement, expectedLegacyDerivationPathElement);
    });

    test('Should [throw FormatException] if provided [path element INVALID]', () {
      // Assert
      expect(() => LegacyDerivationPathElement.parse('0x'), throwsFormatException);
    });
  });

  group('Tests of LegacyDerivationPathElement.isHardened getter', () {
    test('Should [return TRUE] if [path element HARDENED]', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, index: 0, value: "0'");

      // Act
      bool actualHardenedBool = derivationPathElement.isHardened;

      // Assert
      expect(actualHardenedBool, true);
    });

    test('Should [return FALSE] if [path element NOT HARDENED]', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, index: 0, value: '0');

      // Act
      bool actualHardenedBool = derivationPathElement.isHardened;

      // Assert
      expect(actualHardenedBool, false);
    });
  });

  group('Tests of LegacyDerivationPathElement.toBytes()', () {
    test('Should [return BYTES] constructed from LegacyDerivationPathElement index (zero value)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, index: 0, value: '0');

      // Act
      List<int> actualBytes = derivationPathElement.toBytes();

      // Assert
      List<int> expectedBytes = <int>[0, 0, 0, 0];
      expect(actualBytes, expectedBytes);
    });

    test('Should [return BYTES] constructed from LegacyDerivationPathElement index (non-zero value)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, index: 2147483692, value: '44');

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
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: true, index: 2147483692, value: "44'");

      // Act
      String actualString = derivationPathElement.toString();

      // Assert
      String expectedString = "44'";
      expect(actualString, expectedString);
    });

    test('Should [return String] identifying (NOT HARDENED path element)', () {
      // Arrange
      LegacyDerivationPathElement derivationPathElement = const LegacyDerivationPathElement(hardenedBool: false, index: 44, value: '44');

      // Act
      String actualString = derivationPathElement.toString();

      // Assert
      String expectedString = '44';
      expect(actualString, expectedString);
    });
  });
}
