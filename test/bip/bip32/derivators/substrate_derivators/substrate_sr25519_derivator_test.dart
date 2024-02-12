import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  SubstrateSR25519Derivator actualSubstrateSR25519Derivator = SubstrateSR25519Derivator();
  String actualMnemonic = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage';

  group('Tests of SubstrateSR25519Derivator.derivePath()', () {
    test('Should [return SR25519PrivateKey] derived from given mnemonic', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      SR25519PrivateKey actualSR25519PrivateKey = await actualSubstrateSR25519Derivator.derivePath(actualDerivationPath);

      // Assert
      SR25519PrivateKey expectedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('1344436917'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('T638LP9QwSABfXnIrVRkHXSCek2xdRS6f1du8wh9Yg4='),
      );

      expect(actualSR25519PrivateKey, expectedSR25519PrivateKey);
    });

    test('Should [return SR25519PrivateKey] derived from given SURI (//Polkadot)', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri('$actualMnemonic//Polkadot');

      // Act
      SR25519PrivateKey actualSR25519PrivateKey = await actualSubstrateSR25519Derivator.derivePath(actualDerivationPath);

      // Assert
      SR25519PrivateKey expectedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 1,
          chainCode: base64Decode('V7gakr8gLxzN9HxJdVQuQ5xvgyfBfnYcS++3MWuJboY='),
          fingerprint: BigInt.parse('408471769'),
          parentFingerprint: BigInt.parse('1344436917'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('FW5K8qc2ZLw9wDeUWvXXwXwIv9J9wTJSOP7J//dNawo='),
      );

      expect(actualSR25519PrivateKey, expectedSR25519PrivateKey);
    });

    test('Should [return SR25519PrivateKey] derived from given SURI (//Polkadot//Alice)', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri('$actualMnemonic//Polkadot//Alice');

      // Act
      SR25519PrivateKey actualSR25519PrivateKey = await actualSubstrateSR25519Derivator.derivePath(actualDerivationPath);

      // Assert
      SR25519PrivateKey expectedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 2,
          chainCode: base64Decode('BSHBoHQpsNHgIUqhViKT6YLmFcOcLuJU/XIhclhu4js='),
          fingerprint: BigInt.parse('3365217831'),
          parentFingerprint: BigInt.parse('408471769'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('CUOclQoGGBpHS9hHrAqVw49XdxmzE101r0k5In3Poww='),
      );

      expect(actualSR25519PrivateKey, expectedSR25519PrivateKey);
    });

    test('Should [return SR25519PrivateKey] derived from given SURI (//Polkadot//Alice/Payments)', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri('$actualMnemonic//Polkadot//Alice/Payments');

      // Act
      SR25519PrivateKey actualSR25519PrivateKey = await actualSubstrateSR25519Derivator.derivePath(actualDerivationPath);

      // Assert
      SR25519PrivateKey expectedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 3,
          chainCode: base64Decode('XKHfZ2dNElCAT3R9+WJE3Mm+VWGwEk1tJmRGSu1m2ww='),
          fingerprint: BigInt.parse('2163564104'),
          parentFingerprint: BigInt.parse('3365217831'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('KeItxE8wTCNc4CLLGCy+J8ISuG24rfDqoPiTsVjhfw8='),
      );

      expect(actualSR25519PrivateKey, expectedSR25519PrivateKey);
    });

    test('Should [return SR25519PrivateKey] derived from given SURI (//Polkadot//Alice/Payments/Work)', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri('$actualMnemonic//Polkadot//Alice/Payments/Work');

      // Act
      SR25519PrivateKey actualSR25519PrivateKey = await actualSubstrateSR25519Derivator.derivePath(actualDerivationPath);

      // Assert
      SR25519PrivateKey expectedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 4,
          chainCode: base64Decode('lrWDYF8CMb3y0FGDgPepOEr3nKkxAgl+XW1zVs9oteM='),
          fingerprint: BigInt.parse('431063032'),
          parentFingerprint: BigInt.parse('2163564104'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('u2tuVmjDuxiSyqiWRYvAsi/rh/QivnO0DHIMzghxOAk='),
      );

      expect(actualSR25519PrivateKey, expectedSR25519PrivateKey);
    });

    test('Should [return SR25519PrivateKey] derived from given SURI (//Polkadot//Alice/Payments///MySecretPassword)', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri('$actualMnemonic//Polkadot//Alice/Payments/Work///MySecretPassword');

      // Act
      SR25519PrivateKey actualSR25519PrivateKey = await actualSubstrateSR25519Derivator.derivePath(actualDerivationPath);

      // Assert
      SR25519PrivateKey expectedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 4,
          chainCode: base64Decode('2Ldu4nHLafp7ILY+5BhXZKvJ/tiwclvGmzPFzK2HmDw='),
          fingerprint: BigInt.parse('1765038091'),
          parentFingerprint: BigInt.parse('450282559'),
          masterFingerprint: BigInt.parse('2165199291'),
        ),
        key: base64Decode('aYexEBBbvsNxMHMiikPXCw7nJErf0l0R2x3wTSBC+AA='),
      );

      expect(actualSR25519PrivateKey, expectedSR25519PrivateKey);
    });
  });

  group('Tests of SubstrateSR25519Derivator.deriveMasterKey()', () {
    test('Should [return SR25519PrivateKey] derived from given mnemonic', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      SR25519PrivateKey actualSR25519PrivateKey = await actualSubstrateSR25519Derivator.derivePath(actualDerivationPath);

      // Assert
      SR25519PrivateKey expectedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('1344436917'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('T638LP9QwSABfXnIrVRkHXSCek2xdRS6f1du8wh9Yg4='),
      );

      expect(actualSR25519PrivateKey, expectedSR25519PrivateKey);
    });
  });

  group('Tests of SubstrateSR25519Derivator.deriveChildKey()', () {
    test('Should [return SR25519PrivateKey] derived from ED25519PrivateKey (master -> //Polkadot)', () async {
      // Arrange
      SubstrateDerivationPathElement actualDerivationPathElement = SubstrateDerivationPathElement.fromString('/Polkadot');

      // Master private key
      SR25519PrivateKey actualSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('1344436917'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('T638LP9QwSABfXnIrVRkHXSCek2xdRS6f1du8wh9Yg4='),
      );

      // Act
      SR25519PrivateKey actualDerivedSR25519PrivateKey = actualSubstrateSR25519Derivator.deriveChildKey(actualSR25519PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and //Polkadot derivation path element
      SR25519PrivateKey expectedDerivedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 1,
          chainCode: base64Decode('V7gakr8gLxzN9HxJdVQuQ5xvgyfBfnYcS++3MWuJboY='),
          fingerprint: BigInt.parse('408471769'),
          parentFingerprint: BigInt.parse('1344436917'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('FW5K8qc2ZLw9wDeUWvXXwXwIv9J9wTJSOP7J//dNawo='),
      );
      expect(actualDerivedSR25519PrivateKey, expectedDerivedSR25519PrivateKey);
    });

    test('Should [return SR25519PrivateKey] derived from ED25519PrivateKey (//Polkadot -> //Polkadot//Alice)', () async {
      // Arrange
      SubstrateDerivationPathElement actualDerivationPathElement = SubstrateDerivationPathElement.fromString('/Alice');

      // Private key derived from master private key and //Polkadot derivation path (value calculated in the previous test)
      SR25519PrivateKey actualSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 1,
          chainCode: base64Decode('V7gakr8gLxzN9HxJdVQuQ5xvgyfBfnYcS++3MWuJboY='),
          fingerprint: BigInt.parse('408471769'),
          parentFingerprint: BigInt.parse('1344436917'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('FW5K8qc2ZLw9wDeUWvXXwXwIv9J9wTJSOP7J//dNawo='),
      );

      // Act
      SR25519PrivateKey actualDerivedSR25519PrivateKey = actualSubstrateSR25519Derivator.deriveChildKey(actualSR25519PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and //Polkadot//Alice derivation path
      SR25519PrivateKey expectedDerivedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 2,
          chainCode: base64Decode('BSHBoHQpsNHgIUqhViKT6YLmFcOcLuJU/XIhclhu4js='),
          fingerprint: BigInt.parse('3365217831'),
          parentFingerprint: BigInt.parse('408471769'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        key: base64Decode('CUOclQoGGBpHS9hHrAqVw49XdxmzE101r0k5In3Poww='),
      );
      expect(actualDerivedSR25519PrivateKey, expectedDerivedSR25519PrivateKey);
    });

    test('Should [return SR25519PrivateKey] derived from ED25519PrivateKey (//Polkadot//Alice -> //Polkadot//Alice/Payments)', () async {
      // Arrange
      SubstrateDerivationPathElement actualDerivationPathElement = SubstrateDerivationPathElement.fromString('Payments');

      // Private key derived from master private key and //Polkadot//Alice derivation path (value calculated in the previous test)
      SR25519PrivateKey actualSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 2,
          chainCode: base64Decode('BSHBoHQpsNHgIUqhViKT6YLmFcOcLuJU/XIhclhu4js='),
          fingerprint: BigInt.parse('2163564104'),
          parentFingerprint: BigInt.parse('424974754'),
          masterFingerprint: BigInt.parse('83580899'),
        ),
        key: base64Decode('CUOclQoGGBpHS9hHrAqVw49XdxmzE101r0k5In3Poww='),
      );

      // Act
      SR25519PrivateKey actualDerivedSR25519PrivateKey = actualSubstrateSR25519Derivator.deriveChildKey(actualSR25519PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and //Polkadot//Alice/Payments derivation path
      SR25519PrivateKey expectedDerivedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 3,
          chainCode: base64Decode('XKHfZ2dNElCAT3R9+WJE3Mm+VWGwEk1tJmRGSu1m2ww='),
          fingerprint: BigInt.parse('2163564104'),
          parentFingerprint: BigInt.parse('2163564104'),
          masterFingerprint: BigInt.parse('83580899'),
        ),
        key: base64Decode('KeItxE8wTCNc4CLLGCy+J8ISuG24rfDqoPiTsVjhfw8='),
      );

      expect(actualDerivedSR25519PrivateKey, expectedDerivedSR25519PrivateKey);
    });

    test('Should [return SR25519PrivateKey] derived from ED25519PrivateKey (//Polkadot//Alice/Payments -> //Polkadot//Alice/Payments/Work)', () async {
      // Arrange
      SubstrateDerivationPathElement actualDerivationPathElement = SubstrateDerivationPathElement.fromString('Work');

      // Private key derived from master private key and //Polkadot//Alice/Payments derivation path (value calculated in the previous test)
      SR25519PrivateKey actualSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 3,
          chainCode: base64Decode('XKHfZ2dNElCAT3R9+WJE3Mm+VWGwEk1tJmRGSu1m2ww='),
          fingerprint: BigInt.parse('2163564104'),
          parentFingerprint: BigInt.parse('2163564104'),
          masterFingerprint: BigInt.parse('83580899'),
        ),
        key: base64Decode('KeItxE8wTCNc4CLLGCy+J8ISuG24rfDqoPiTsVjhfw8='),
      );

      // Act
      SR25519PrivateKey actualDerivedSR25519PrivateKey = actualSubstrateSR25519Derivator.deriveChildKey(actualSR25519PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and //Polkadot//Alice/Payments/Work derivation path
      SR25519PrivateKey expectedDerivedSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 4,
          chainCode: base64Decode('lrWDYF8CMb3y0FGDgPepOEr3nKkxAgl+XW1zVs9oteM='),
          fingerprint: BigInt.parse('431063032'),
          parentFingerprint: BigInt.parse('2163564104'),
          masterFingerprint: BigInt.parse('83580899'),
        ),
        key: base64Decode('u2tuVmjDuxiSyqiWRYvAsi/rh/QivnO0DHIMzghxOAk='),
      );

      expect(actualDerivedSR25519PrivateKey, expectedDerivedSR25519PrivateKey);
    });
  });
}
