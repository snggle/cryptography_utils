import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/bip/bip32/derivators/derivator_type.dart';
import 'package:test/test.dart';

void main() {
  ED25519Derivator actualED25519Derivator = ED25519Derivator();
  Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('shift shed release funny grab acquire fish cannon comic proof quantum cabbage');

  group('Tests of ED25519Derivator.derivatorType getter', () {
    test('Should [return DerivatorType.ed25519] for ED25519Derivator', () {
      // Act
      DerivatorType actualDerivatorType = actualED25519Derivator.derivatorType;

      // Assert
      DerivatorType expectedDerivatorType = DerivatorType.ed25519;

      expect(actualDerivatorType, expectedDerivatorType);
    });
  });

  group('Tests of ED25519Derivator.serializeType()', () {
    test('Should [return "ed25519"] for ED25519Derivator', () {
      // Act
      String actualType = actualED25519Derivator.serializeType();

      // Assert
      String expectedType = 'ed25519';

      expect(actualType, expectedType);
    });
  });

  group('Tests of ED25519Derivator.derivePath()', () {
    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/)", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 1,
          shiftedIndex: 2147483692,
          chainCode: base64Decode('oVTP3c7E2KeoquJttMLqsSV7zyzEbvACvVcFTjW2Cz4='),
          fingerprint: BigInt.parse('2330465125'),
          parentFingerprint: BigInt.parse('3578578273'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('MinQRVP+LSjLX9pmmkDLcm01pJP8IVaKrlVAGlNXUbs=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/)", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 2,
          shiftedIndex: 2147483708,
          chainCode: base64Decode('AlYCSjYOCo//7XisF+s9f+4uREPjJlQ3lZVRypceTI0='),
          fingerprint: BigInt.parse('4278372777'),
          parentFingerprint: BigInt.parse('2330465125'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dZiZCf9yd0YSUxbInwyamtkndKTTRj6j+G6xmj928vY=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/)", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 3,
          shiftedIndex: 2147483648,
          chainCode: base64Decode('XJIq3dw+4wLO363ghHmYr8iBf0sSpDC1SsJGbG6BMxM='),
          fingerprint: BigInt.parse('4237045580'),
          parentFingerprint: BigInt.parse('4278372777'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dnfNSsX9wTWBvMXva/SUqWt3iRaK+oH68fM9Feg/SIs=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/0'/)", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0'/");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 4,
          shiftedIndex: 2147483648,
          chainCode: base64Decode('7VKKNJkj9ZEp7SX+GveAvvcZhi+8NJNrSG98+BNgjxY='),
          fingerprint: BigInt.parse('2130523803'),
          parentFingerprint: BigInt.parse('4237045580'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('Dy1S7AO7gPWC+vO7mV/cwTi9sjJ56abeYtD8s3qRTAk=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/0'/0')", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0'/0'");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 2147483648,
          chainCode: base64Decode('hz6ve3vISMyVDK7ZD0zQoV2v4K1ota1QJ9kY1xakFR4='),
          fingerprint: BigInt.parse('3808761756'),
          parentFingerprint: BigInt.parse('2130523803'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('fbrqtRb364ZjYonX89pDhtlKE+4jFrxmpHGU2kmQaGs=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/0'/1')", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0'/1'");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 2147483649,
          chainCode: base64Decode('l1JlMYKoERbLwsNQIZbHugLvqyxktb1J+O+zU5jue+k='),
          fingerprint: BigInt.parse('2573384385'),
          parentFingerprint: BigInt.parse('2130523803'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('AVPH3U7LPhJ6E3PFI9S+Ek+vUM59I5RBk5uRG1nMIBw=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });
  });

  group('Tests of ED25519Derivator.deriveMasterKey()', () {
    test('Should [return ED25519PrivateKey] constructed from mnemonic', () async {
      // Act
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.deriveMasterKey(actualMnemonic);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 0,
          chainCode: base64Decode('3S5mnCmDWh5+QmP15XLOUYDGkOuxbn1nWXmhnoF0VXc='),
          fingerprint: BigInt.parse('3578578273'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('to6LIOQMmlfq/dgQjfIr4CIb77WkealNrGon6wMsYrs=')),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });
  });

  group('Tests of SubstrateED25519Derivator.deriveChildKey()', () {
    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m -> m/44'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("44'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 0,
          chainCode: base64Decode('3S5mnCmDWh5+QmP15XLOUYDGkOuxbn1nWXmhnoF0VXc='),
          fingerprint: BigInt.parse('3578578273'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('to6LIOQMmlfq/dgQjfIr4CIb77WkealNrGon6wMsYrs=')),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 1,
          shiftedIndex: 2147483692,
          chainCode: base64Decode('oVTP3c7E2KeoquJttMLqsSV7zyzEbvACvVcFTjW2Cz4='),
          fingerprint: BigInt.parse('2330465125'),
          parentFingerprint: BigInt.parse('3578578273'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('MinQRVP+LSjLX9pmmkDLcm01pJP8IVaKrlVAGlNXUbs=')),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m/44'/ -> m/44'/60'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("60'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 1,
          shiftedIndex: 2147483692,
          chainCode: base64Decode('oVTP3c7E2KeoquJttMLqsSV7zyzEbvACvVcFTjW2Cz4='),
          fingerprint: BigInt.parse('2330465125'),
          parentFingerprint: BigInt.parse('3578578273'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('MinQRVP+LSjLX9pmmkDLcm01pJP8IVaKrlVAGlNXUbs=')),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 2,
          shiftedIndex: 2147483708,
          chainCode: base64Decode('AlYCSjYOCo//7XisF+s9f+4uREPjJlQ3lZVRypceTI0='),
          fingerprint: BigInt.parse('4278372777'),
          parentFingerprint: BigInt.parse('2330465125'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dZiZCf9yd0YSUxbInwyamtkndKTTRj6j+G6xmj928vY=')),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m/44'/60'/ -> m/44'/60'/0'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("0'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 2,
          shiftedIndex: 2147483708,
          chainCode: base64Decode('AlYCSjYOCo//7XisF+s9f+4uREPjJlQ3lZVRypceTI0='),
          fingerprint: BigInt.parse('4278372777'),
          parentFingerprint: BigInt.parse('2330465125'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dZiZCf9yd0YSUxbInwyamtkndKTTRj6j+G6xmj928vY=')),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 3,
          shiftedIndex: 2147483648,
          chainCode: base64Decode('XJIq3dw+4wLO363ghHmYr8iBf0sSpDC1SsJGbG6BMxM='),
          fingerprint: BigInt.parse('4237045580'),
          parentFingerprint: BigInt.parse('4278372777'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dnfNSsX9wTWBvMXva/SUqWt3iRaK+oH68fM9Feg/SIs=')),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m/44'/60'/0'/ -> m/44'/60'/0'/0'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("0'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 3,
          shiftedIndex: 2147483648,
          chainCode: base64Decode('XJIq3dw+4wLO363ghHmYr8iBf0sSpDC1SsJGbG6BMxM='),
          fingerprint: BigInt.parse('4237045580'),
          parentFingerprint: BigInt.parse('4278372777'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dnfNSsX9wTWBvMXva/SUqWt3iRaK+oH68fM9Feg/SIs=')),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 4,
          shiftedIndex: 2147483648,
          chainCode: base64Decode('7VKKNJkj9ZEp7SX+GveAvvcZhi+8NJNrSG98+BNgjxY='),
          fingerprint: BigInt.parse('2130523803'),
          parentFingerprint: BigInt.parse('4237045580'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('Dy1S7AO7gPWC+vO7mV/cwTi9sjJ56abeYtD8s3qRTAk=')),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m/44'/60'/0'/0'/ -> m/44'/60'/0'/0'/0'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("0'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 4,
          shiftedIndex: 2147483648,
          chainCode: base64Decode('7VKKNJkj9ZEp7SX+GveAvvcZhi+8NJNrSG98+BNgjxY='),
          fingerprint: BigInt.parse('2130523803'),
          parentFingerprint: BigInt.parse('4237045580'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('Dy1S7AO7gPWC+vO7mV/cwTi9sjJ56abeYtD8s3qRTAk=')),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 2147483648,
          chainCode: base64Decode('hz6ve3vISMyVDK7ZD0zQoV2v4K1ota1QJ9kY1xakFR4='),
          fingerprint: BigInt.parse('3808761756'),
          parentFingerprint: BigInt.parse('2130523803'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('fbrqtRb364ZjYonX89pDhtlKE+4jFrxmpHGU2kmQaGs=')),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test('Should [throw Exception] if Bip32KeyMetadata does not contain chain code', () {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("0'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 4,
          shiftedIndex: 2147483648,
          fingerprint: BigInt.parse('2130523803'),
          parentFingerprint: BigInt.parse('4237045580'),
          masterFingerprint: BigInt.parse('3578578273'),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('Dy1S7AO7gPWC+vO7mV/cwTi9sjJ56abeYtD8s3qRTAk=')),
      );

      // Act + Assert
      expect(() => actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement), throwsException);
    });
  });
}
