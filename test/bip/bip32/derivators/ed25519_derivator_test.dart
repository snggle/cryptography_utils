import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ED25519Derivator actualED25519Derivator = ED25519Derivator();
  Mnemonic actualMnemonic = Mnemonic.fromString('shift shed release funny grab acquire fish cannon comic proof quantum cabbage');

  group('Tests of ED25519Derivator.derivePath()', () {
    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/)", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('MinQRVP+LSjLX9pmmkDLcm01pJP8IVaKrlVAGlNXUbs=')),
        chainCode: base64Decode('oVTP3c7E2KeoquJttMLqsSV7zyzEbvACvVcFTjW2Cz4='),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/)", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dZiZCf9yd0YSUxbInwyamtkndKTTRj6j+G6xmj928vY=')),
        chainCode: base64Decode('AlYCSjYOCo//7XisF+s9f+4uREPjJlQ3lZVRypceTI0='),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/)", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dnfNSsX9wTWBvMXva/SUqWt3iRaK+oH68fM9Feg/SIs=')),
        chainCode: base64Decode('XJIq3dw+4wLO363ghHmYr8iBf0sSpDC1SsJGbG6BMxM='),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/0'/)", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0'/");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('Dy1S7AO7gPWC+vO7mV/cwTi9sjJ56abeYtD8s3qRTAk=')),
        chainCode: base64Decode('7VKKNJkj9ZEp7SX+GveAvvcZhi+8NJNrSG98+BNgjxY='),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/0'/0')", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0'/0'");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('fbrqtRb364ZjYonX89pDhtlKE+4jFrxmpHGU2kmQaGs=')),
        chainCode: base64Decode('hz6ve3vISMyVDK7ZD0zQoV2v4K1ota1QJ9kY1xakFR4='),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/0'/1')", () async {
      // Act
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0'/1'");
      ED25519PrivateKey actualED25519PrivateKey = await actualED25519Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      ED25519PrivateKey expectedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('AVPH3U7LPhJ6E3PFI9S+Ek+vUM59I5RBk5uRG1nMIBw=')),
        chainCode: base64Decode('l1JlMYKoERbLwsNQIZbHugLvqyxktb1J+O+zU5jue+k='),
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
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('to6LIOQMmlfq/dgQjfIr4CIb77WkealNrGon6wMsYrs=')),
        chainCode: base64Decode('3S5mnCmDWh5+QmP15XLOUYDGkOuxbn1nWXmhnoF0VXc='),
      );

      expect(actualED25519PrivateKey, expectedED25519PrivateKey);
    });
  });

  group('Tests of SubstrateED25519Derivator.deriveChildKey()', () {
    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m -> m/44'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("44'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('to6LIOQMmlfq/dgQjfIr4CIb77WkealNrGon6wMsYrs=')),
        chainCode: base64Decode('3S5mnCmDWh5+QmP15XLOUYDGkOuxbn1nWXmhnoF0VXc='),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('MinQRVP+LSjLX9pmmkDLcm01pJP8IVaKrlVAGlNXUbs=')),
        chainCode: base64Decode('oVTP3c7E2KeoquJttMLqsSV7zyzEbvACvVcFTjW2Cz4='),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m/44'/ -> m/44'/60'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("60'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('MinQRVP+LSjLX9pmmkDLcm01pJP8IVaKrlVAGlNXUbs=')),
        chainCode: base64Decode('oVTP3c7E2KeoquJttMLqsSV7zyzEbvACvVcFTjW2Cz4='),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dZiZCf9yd0YSUxbInwyamtkndKTTRj6j+G6xmj928vY=')),
        chainCode: base64Decode('AlYCSjYOCo//7XisF+s9f+4uREPjJlQ3lZVRypceTI0='),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m/44'/60'/ -> m/44'/60'/0'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("0'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dZiZCf9yd0YSUxbInwyamtkndKTTRj6j+G6xmj928vY=')),
        chainCode: base64Decode('AlYCSjYOCo//7XisF+s9f+4uREPjJlQ3lZVRypceTI0='),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dnfNSsX9wTWBvMXva/SUqWt3iRaK+oH68fM9Feg/SIs=')),
        chainCode: base64Decode('XJIq3dw+4wLO363ghHmYr8iBf0sSpDC1SsJGbG6BMxM='),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m/44'/60'/0'/ -> m/44'/60'/0'/0'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("0'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('dnfNSsX9wTWBvMXva/SUqWt3iRaK+oH68fM9Feg/SIs=')),
        chainCode: base64Decode('XJIq3dw+4wLO363ghHmYr8iBf0sSpDC1SsJGbG6BMxM='),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('Dy1S7AO7gPWC+vO7mV/cwTi9sjJ56abeYtD8s3qRTAk=')),
        chainCode: base64Decode('7VKKNJkj9ZEp7SX+GveAvvcZhi+8NJNrSG98+BNgjxY='),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });

    test("Should [return ED25519PrivateKey] derived from ED25519PrivateKey (m/44'/60'/0'/0'/ -> m/44'/60'/0'/0'/0'/)", () async {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("0'");
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('Dy1S7AO7gPWC+vO7mV/cwTi9sjJ56abeYtD8s3qRTAk=')),
        chainCode: base64Decode('7VKKNJkj9ZEp7SX+GveAvvcZhi+8NJNrSG98+BNgjxY='),
      );

      // Act
      ED25519PrivateKey actualDerivedED25519PrivateKey = actualED25519Derivator.deriveChildKey(actualED25519PrivateKey, actualDerivationPathElement);

      // Assert
      ED25519PrivateKey expectedDerivedED25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('fbrqtRb364ZjYonX89pDhtlKE+4jFrxmpHGU2kmQaGs=')),
        chainCode: base64Decode('hz6ve3vISMyVDK7ZD0zQoV2v4K1ota1QJ9kY1xakFR4='),
      );

      expect(actualDerivedED25519PrivateKey, expectedDerivedED25519PrivateKey);
    });
  });
}
