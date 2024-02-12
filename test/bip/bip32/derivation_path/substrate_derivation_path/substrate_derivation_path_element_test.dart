import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SubstrateDerivationPathElement.fromString() constructor', () {
    test('Should [return soft SubstrateDerivationPathElement] from given String', () {
      // Arrange
      String actualElement = 'Alice';

      // Act
      SubstrateDerivationPathElement actualSubstrateDerivationPathElement = SubstrateDerivationPathElement.fromString(actualElement);

      // Assert
      SubstrateDerivationPathElement expectedSubstrateDerivationPathElement = SubstrateDerivationPathElement(
        hardenedBool: false,
        id: base64Decode('FEFsaWNlAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='),
      );

      expect(actualSubstrateDerivationPathElement, expectedSubstrateDerivationPathElement);
    });

    test('Should [return hard SubstrateDerivationPathElement] from given String', () {
      // Arrange
      String actualElement = '/Alice';

      // Act
      SubstrateDerivationPathElement actualSubstrateDerivationPathElement = SubstrateDerivationPathElement.fromString(actualElement);

      // Assert
      SubstrateDerivationPathElement expectedSubstrateDerivationPathElement = SubstrateDerivationPathElement(
        hardenedBool: true,
        id: base64Decode('FEFsaWNlAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='),
      );

      expect(actualSubstrateDerivationPathElement, expectedSubstrateDerivationPathElement);
    });

    test('Should [return soft SubstrateDerivationPathElement] from given String (String is number < 18446744073709551616)', () {
      // Arrange
      String actualElement = '18446744073709551615';

      // Act
      SubstrateDerivationPathElement actualSubstrateDerivationPathElement = SubstrateDerivationPathElement.fromString(actualElement);

      // Assert
      SubstrateDerivationPathElement expectedSubstrateDerivationPathElement = SubstrateDerivationPathElement(
        hardenedBool: false,
        id: base64Decode('//////////8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='),
      );

      expect(actualSubstrateDerivationPathElement, expectedSubstrateDerivationPathElement);
    });

    test('Should [return hard SubstrateDerivationPathElement] from given String (String is number < 18446744073709551616)', () {
      // Arrange
      String actualElement = '/18446744073709551615';

      // Act
      SubstrateDerivationPathElement actualSubstrateDerivationPathElement = SubstrateDerivationPathElement.fromString(actualElement);

      // Assert
      SubstrateDerivationPathElement expectedSubstrateDerivationPathElement = SubstrateDerivationPathElement(
        hardenedBool: true,
        id: base64Decode('//////////8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='),
      );

      expect(actualSubstrateDerivationPathElement, expectedSubstrateDerivationPathElement);
    });
  });

  group('Tests of SubstrateDerivationPathElement.fromBytes() constructor', () {
    test('Should [return soft SubstrateDerivationPathElement] with given bytes if [length <= 32]', () {
      // Arrange
      Uint8List actualBytes = base64Decode('FEFsaWNlAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=');

      // Act
      SubstrateDerivationPathElement actualSubstrateDerivationPathElement = SubstrateDerivationPathElement.fromBytes(
        hardenedBool: false,
        bytes: actualBytes,
      );

      // Assert
      SubstrateDerivationPathElement expectedSubstrateDerivationPathElement = SubstrateDerivationPathElement(
        hardenedBool: false,
        id: base64Decode('FEFsaWNlAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='),
      );

      expect(actualSubstrateDerivationPathElement, expectedSubstrateDerivationPathElement);
    });

    test('Should [return soft SubstrateDerivationPathElement] with hashed bytes if [length > 32]', () {
      // Arrange
      Uint8List actualBytes = base64Decode('AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1Njc4OTo7PD0+Pw==');

      // Act
      SubstrateDerivationPathElement actualSubstrateDerivationPathElement = SubstrateDerivationPathElement.fromBytes(
        hardenedBool: false,
        bytes: actualBytes,
      );

      // Assert
      SubstrateDerivationPathElement expectedSubstrateDerivationPathElement = SubstrateDerivationPathElement(
        hardenedBool: false,
        id: base64Decode('ENjm1TSwCTmEP+ncxNrkjN8Aj2uLK4KxVvVATYdIh/U='),
      );

      expect(actualSubstrateDerivationPathElement, expectedSubstrateDerivationPathElement);
    });

    test('Should [return hard SubstrateDerivationPathElement] with given bytes if [length <= 32]', () {
      // Arrange
      Uint8List actualBytes = base64Decode('FEFsaWNlAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=');

      // Act
      SubstrateDerivationPathElement actualSubstrateDerivationPathElement = SubstrateDerivationPathElement.fromBytes(
        hardenedBool: true,
        bytes: actualBytes,
      );

      // Assert
      SubstrateDerivationPathElement expectedSubstrateDerivationPathElement = SubstrateDerivationPathElement(
        hardenedBool: true,
        id: base64Decode('FEFsaWNlAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='),
      );

      expect(actualSubstrateDerivationPathElement, expectedSubstrateDerivationPathElement);
    });

    test('Should [return hard SubstrateDerivationPathElement] with hashed bytes if [length > 32]', () {
      // Arrange
      Uint8List actualBytes = base64Decode('AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1Njc4OTo7PD0+Pw==');

      // Act
      SubstrateDerivationPathElement actualSubstrateDerivationPathElement = SubstrateDerivationPathElement.fromBytes(
        hardenedBool: true,
        bytes: actualBytes,
      );

      // Assert
      SubstrateDerivationPathElement expectedSubstrateDerivationPathElement = SubstrateDerivationPathElement(
        hardenedBool: true,
        id: base64Decode('ENjm1TSwCTmEP+ncxNrkjN8Aj2uLK4KxVvVATYdIh/U='),
      );

      expect(actualSubstrateDerivationPathElement, expectedSubstrateDerivationPathElement);
    });
  });
}
