import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of LegacyDerivationPath.parse() constructor', () {
    test('Should [return LegacyDerivationPath] object parsed from [VALID derivation path] (WITHOUT trailing slash)', () {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0/0");

      // Assert
      LegacyDerivationPath expectedLegacyDerivationPath = LegacyDerivationPath(pathElements: const <LegacyDerivationPathElement>[
        LegacyDerivationPathElement(hardenedBool: true, index: 2147483692, value: "44'"),
        LegacyDerivationPathElement(hardenedBool: true, index: 2147483708, value: "60'"),
        LegacyDerivationPathElement(hardenedBool: true, index: 2147483648, value: "0'"),
        LegacyDerivationPathElement(hardenedBool: false, index: 0, value: '0'),
        LegacyDerivationPathElement(hardenedBool: false, index: 0, value: '0'),
      ]);

      expect(actualLegacyDerivationPath, expectedLegacyDerivationPath);
    });

    test('Should [return LegacyDerivationPath] object parsed from [VALID derivation path] (WITH trailing slash)', () {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0/0/");

      // Assert
      LegacyDerivationPath expectedLegacyDerivationPath = LegacyDerivationPath(pathElements: const <LegacyDerivationPathElement>[
        LegacyDerivationPathElement(hardenedBool: true, index: 2147483692, value: "44'"),
        LegacyDerivationPathElement(hardenedBool: true, index: 2147483708, value: "60'"),
        LegacyDerivationPathElement(hardenedBool: true, index: 2147483648, value: "0'"),
        LegacyDerivationPathElement(hardenedBool: false, index: 0, value: '0'),
        LegacyDerivationPathElement(hardenedBool: false, index: 0, value: '0'),
      ]);

      expect(actualLegacyDerivationPath, expectedLegacyDerivationPath);
    });

    test('Should [throw FormatException] if derivation path contains invalid element', () {
      // Act
      void actualLegacyDerivationPath() => LegacyDerivationPath.parse("44'/60'/invalid_element'/0/0");

      // Assert
      expect(actualLegacyDerivationPath, throwsFormatException);
    });

    test('Should [throw FormatException] if derivation path does not contain master element ("m/" prefix)', () {
      // Act
      void actualLegacyDerivationPath() => LegacyDerivationPath.parse("44'/60'/0'/0/0");

      // Assert
      expect(actualLegacyDerivationPath, throwsFormatException);
    });

    test('Should [throw FormatException] if derivation path is empty', () {
      // Act
      void actualLegacyDerivationPath() => LegacyDerivationPath.parse('');

      // Assert
      expect(actualLegacyDerivationPath, throwsFormatException);
    });
  });

  group('Tests of LegacyDerivationPath.toString()', () {
    test('Should [return LegacyDerivationPath] as String', () {
      // Arrange
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath(pathElements: const <LegacyDerivationPathElement>[
        LegacyDerivationPathElement(hardenedBool: true, index: 2147483692, value: "44'"),
        LegacyDerivationPathElement(hardenedBool: true, index: 2147483708, value: "60'"),
        LegacyDerivationPathElement(hardenedBool: true, index: 2147483648, value: "0'"),
        LegacyDerivationPathElement(hardenedBool: false, index: 0, value: '0'),
        LegacyDerivationPathElement(hardenedBool: false, index: 0, value: '0'),
      ]);

      // Act
      String actualLegacyDerivationPathString = actualLegacyDerivationPath.toString();

      // Assert
      String expectedLegacyDerivationPathString = "m/44'/60'/0'/0/0";

      expect(actualLegacyDerivationPathString, expectedLegacyDerivationPathString);
    });
  });
}
