import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SubstrateDerivationPath.fromUri() constructor', () {
    group('Test for simple SURI formats', () {
      test('Should [return SubstrateDerivationPath] from secret uri (mnemonic sentence only)', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage';

        // Act
        SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualSURI);

        // Assert
        SubstrateDerivationPath expectedDerivationPath = SubstrateDerivationPath(
          secretUri: actualSURI,
          pharse: 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage',
          derivationPath: '',
          derivationPathElements: const <SubstrateDerivationPathElement>[],
          password: null,
        );

        expect(actualDerivationPath, expectedDerivationPath);
      });

      test('Should [return SubstrateDerivationPath] from secret uri (soft key)', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1';

        // Act
        SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualSURI);

        // Assert
        SubstrateDerivationPath expectedDerivationPath = SubstrateDerivationPath(
          secretUri: actualSURI,
          pharse: 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage',
          derivationPath: '/soft-key-1',
          derivationPathElements: <SubstrateDerivationPathElement>[
            SubstrateDerivationPathElement.fromString('soft-key-1'),
          ],
          password: null,
        );

        expect(actualDerivationPath, expectedDerivationPath);
      });

      test('Should [return SubstrateDerivationPath] from secret uri (multiple soft keys)', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1/soft-key-2';

        // Act
        SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualSURI);

        // Assert
        SubstrateDerivationPath expectedDerivationPath = SubstrateDerivationPath(
          secretUri: actualSURI,
          pharse: 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage',
          derivationPath: '/soft-key-1/soft-key-2',
          derivationPathElements: <SubstrateDerivationPathElement>[
            SubstrateDerivationPathElement.fromString('soft-key-1'),
            SubstrateDerivationPathElement.fromString('soft-key-2'),
          ],
          password: null,
        );

        expect(actualDerivationPath, expectedDerivationPath);
      });

      test('Should [return SubstrateDerivationPath] from secret uri (soft key combined with hard key)', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1//hard-key-1';

        // Act
        SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualSURI);

        // Assert
        SubstrateDerivationPath expectedDerivationPath = SubstrateDerivationPath(
          secretUri: actualSURI,
          pharse: 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage',
          derivationPath: '/soft-key-1//hard-key-1',
          derivationPathElements: <SubstrateDerivationPathElement>[
            SubstrateDerivationPathElement.fromString('soft-key-1'),
            SubstrateDerivationPathElement.fromString('/hard-key-1'),
          ],
          password: null,
        );

        expect(actualDerivationPath, expectedDerivationPath);
      });

      test('Should [return SubstrateDerivationPath] from secret uri (multiple soft keys combined with multiple hard keys)', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1/soft-key-2//hard-key-1/hard-key-2';

        // Act
        SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualSURI);

        // Assert
        SubstrateDerivationPath expectedDerivationPath = SubstrateDerivationPath(
          secretUri: actualSURI,
          pharse: 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage',
          derivationPath: '/soft-key-1/soft-key-2//hard-key-1/hard-key-2',
          derivationPathElements: <SubstrateDerivationPathElement>[
            SubstrateDerivationPathElement.fromString('soft-key-1'),
            SubstrateDerivationPathElement.fromString('soft-key-2'),
            SubstrateDerivationPathElement.fromString('/hard-key-1'),
            SubstrateDerivationPathElement.fromString('/hard-key-2'),
          ],
          password: null,
        );

        expect(actualDerivationPath, expectedDerivationPath);
      });
    });

    group('Tests for SURI with password', () {
      test('Should [return SubstrateDerivationPath] from secret uri (soft key with password)', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1///password';

        // Act
        SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualSURI);

        // Assert
        SubstrateDerivationPath expectedDerivationPath = SubstrateDerivationPath(
          secretUri: actualSURI,
          pharse: 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage',
          derivationPath: '/soft-key-1',
          derivationPathElements: <SubstrateDerivationPathElement>[
            SubstrateDerivationPathElement.fromString('soft-key-1'),
          ],
          password: 'password',
        );

        expect(actualDerivationPath, expectedDerivationPath);
      });

      test('Should [return SubstrateDerivationPath] from secret uri (multiple soft keys and password)', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1/soft-key-2///password';

        // Act
        SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualSURI);

        // Assert
        SubstrateDerivationPath expectedDerivationPath = SubstrateDerivationPath(
          secretUri: actualSURI,
          pharse: 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage',
          derivationPath: '/soft-key-1/soft-key-2',
          derivationPathElements: <SubstrateDerivationPathElement>[
            SubstrateDerivationPathElement.fromString('soft-key-1'),
            SubstrateDerivationPathElement.fromString('soft-key-2'),
          ],
          password: 'password',
        );

        expect(actualDerivationPath, expectedDerivationPath);
      });

      test('Should [return SubstrateDerivationPath] from secret uri (soft key combined with hard key and password)', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1//hard-key-1///password';

        // Act
        SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualSURI);

        // Assert
        SubstrateDerivationPath expectedDerivationPath = SubstrateDerivationPath(
          secretUri: actualSURI,
          pharse: 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage',
          derivationPath: '/soft-key-1//hard-key-1',
          derivationPathElements: <SubstrateDerivationPathElement>[
            SubstrateDerivationPathElement.fromString('soft-key-1'),
            SubstrateDerivationPathElement.fromString('/hard-key-1'),
          ],
          password: 'password',
        );

        expect(actualDerivationPath, expectedDerivationPath);
      });
    });

    group('Tests for invalid SURI formats', () {
      test('Should [throw FormatException] if secret uri has missing secret', () {
        // Arrange
        String actualSURI = '/soft-key-1';

        // Assert
        expect(() => SubstrateDerivationPath.fromUri(actualSURI), throwsFormatException);
      });

      test('Should [throw Exception] if secret uri has missing soft key after seperator', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1/';

        // Assert
        expect(() => SubstrateDerivationPath.fromUri(actualSURI), throwsException);
      });

      test('Should [throw Exception] if secret uri has missing hard key after seperator', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1//';

        // Assert
        expect(() => SubstrateDerivationPath.fromUri(actualSURI), throwsException);
      });

      test('Should [throw Exception] if secret uri has missing password after seperator', () {
        // Arrange
        String actualSURI = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage/soft-key-1//';

        // Assert
        expect(() => SubstrateDerivationPath.fromUri(actualSURI), throwsException);
      });
    });
  });
}
