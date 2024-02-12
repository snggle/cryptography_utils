import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  SubstrateED25519Derivator actualSubstrateED25519Derivator = SubstrateED25519Derivator();
  String actualMnemonic = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage';

  group('Tests of SubstrateED25519Derivator.derivePath()', () {
    test('Should [return ED25519PrivateKey] derived from given mnemonic', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      ED25519PrivateKey actualED25519PrivateKey = await actualSubstrateED25519Derivator.derivePath(actualDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('1344436917'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('SNUP4gf+pH4VRSXDVkpWpEifS3zz0eXKiQD1NTvZUJM=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test('Should [return ED25519PrivateKey] derived from given SURI (//Polkadot)', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri('$actualMnemonic//Polkadot');

      // Act
      ED25519PrivateKey actualED25519PrivateKey = await actualSubstrateED25519Derivator.derivePath(actualDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 1,
          fingerprint: BigInt.parse('2431168781'),
          parentFingerprint: BigInt.parse('1344436917'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('4K19lXuD3fiRWvVpORJ1JK551osLASk8t3dBUGydoTg=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test('Should [return ED25519PrivateKey] derived from given SURI (//Polkadot//Alice)', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri('$actualMnemonic//Polkadot//Alice');

      // Act
      ED25519PrivateKey actualED25519PrivateKey = await actualSubstrateED25519Derivator.derivePath(actualDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 2,
          fingerprint: BigInt.parse('754739125'),
          parentFingerprint: BigInt.parse('2431168781'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('DgM57l3kwJoczETSy92wCHyCzCyDqbVi0gPk76Z4pIc=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });
  });

  group('Tests of SubstrateED25519Derivator.deriveMasterKey()', () {
    test('Should [return ED25519PrivateKey] derived from given mnemonic', () async {
      // Arrange
      SubstrateDerivationPath actualDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      ED25519PrivateKey actualED25519PrivateKey = await actualSubstrateED25519Derivator.derivePath(actualDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('1344436917'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('SNUP4gf+pH4VRSXDVkpWpEifS3zz0eXKiQD1NTvZUJM=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });
  });

  group('Tests of SubstrateED25519Derivator.deriveChildKey()', () {
    test('Should [return ED25519PrivateKey] derived from ED25519PrivateKey (master -> //Polkadot)', () async {
      // Arrange
      SubstrateDerivationPathElement actualDerivationPathElement = SubstrateDerivationPathElement.fromString('/Polkadot');

      // Master private key
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('1344436917'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('SNUP4gf+pH4VRSXDVkpWpEifS3zz0eXKiQD1NTvZUJM=')),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualSubstrateED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and //Polkadot derivation path element
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 1,
          fingerprint: BigInt.parse('2431168781'),
          parentFingerprint: BigInt.parse('1344436917'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('4K19lXuD3fiRWvVpORJ1JK551osLASk8t3dBUGydoTg=')),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test('Should [return ED25519PrivateKey] derived from ED25519PrivateKey (//Polkadot -> //Polkadot//Alice)', () async {
      // Arrange
      SubstrateDerivationPathElement actualDerivationPathElement = SubstrateDerivationPathElement.fromString('/Alice');

      // Private key derived from master private key and //Polkadot derivation path (value calculated in the previous test)
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 1,
          fingerprint: BigInt.parse('2431168781'),
          parentFingerprint: BigInt.parse('1344436917'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('4K19lXuD3fiRWvVpORJ1JK551osLASk8t3dBUGydoTg=')),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualSubstrateED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and //Polkadot//Alice derivation path
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 2,
          fingerprint: BigInt.parse('754739125'),
          parentFingerprint: BigInt.parse('2431168781'),
          masterFingerprint: BigInt.parse('1344436917'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('DgM57l3kwJoczETSy92wCHyCzCyDqbVi0gPk76Z4pIc=')),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });
  });
}
