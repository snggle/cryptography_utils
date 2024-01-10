import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Secp256k1Derivator actualSecp256k1Derivator = Secp256k1Derivator();
  Mnemonic actualMnemonic = Mnemonic.fromString(
      'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');

  group('Secp256k1Derivator.derivePath()', () {
    test("Should [return Secp256k1PrivateKey] constructed from mnemonic and derivation path (m/44'/)", () async {
      // Arrange
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/");

      // Act
      Secp256k1PrivateKey actualSecp256k1PrivateKey = await actualSecp256k1Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      Secp256k1PrivateKey expectedSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('bBRorINnDOQdK1WZf79vroWQHTPqtzASttTKd9zj8DQ='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('79831946198650946731958597072964003247551220898694366462475661038263959258621'),
        ),
      );

      expect(actualSecp256k1PrivateKey, expectedSecp256k1PrivateKey);
    });

    test("Should [return Secp256k1PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/)", () async {
      // Arrange
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/");

      // Act
      Secp256k1PrivateKey actualSecp256k1PrivateKey = await actualSecp256k1Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      Secp256k1PrivateKey expectedSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('qEamIw6rnFvaXJCnzkIP7knN1l+8jTwYrrUWH78PRvs='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('33468663939336344008642663460868643449058067978731001309522127228111822578589'),
        ),
      );

      expect(actualSecp256k1PrivateKey, expectedSecp256k1PrivateKey);
    });

    test("Should [return Secp256k1PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/)", () async {
      // Arrange
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/");

      // Act
      Secp256k1PrivateKey actualSecp256k1PrivateKey = await actualSecp256k1Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      Secp256k1PrivateKey expectedSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('5gvokyLRAipECLgT5AnkPLX6thREo+E27t5wUBpna9w='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('34110929557805538687207758350694761629513303450048015188759646123112870087187'),
        ),
      );

      expect(actualSecp256k1PrivateKey, expectedSecp256k1PrivateKey);
    });

    test("Should [return Secp256k1PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/0/)", () async {
      // Arrange
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0/");

      // Act
      Secp256k1PrivateKey actualSecp256k1PrivateKey = await actualSecp256k1Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      Secp256k1PrivateKey expectedSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('FK0bd1Z1KEZpXlZ45+GufE0HsweNVoh7EkZndgnxmVA='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('105108244234952036067739519086050878250157101554789072999465154826127982006038'),
        ),
      );

      expect(actualSecp256k1PrivateKey, expectedSecp256k1PrivateKey);
    });

    test("Should [return Secp256k1PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/0/0)", () async {
      // Arrange
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0/0");

      // Act
      Secp256k1PrivateKey actualSecp256k1PrivateKey = await actualSecp256k1Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      Secp256k1PrivateKey expectedSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('YsN74zJ6p9/kjsFCM5UUBq470XR3CEssHXyawdn7xBw='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('91850346642365090382529827989594437164777469345439968194889143349494450093883'),
        ),
      );

      expect(actualSecp256k1PrivateKey, expectedSecp256k1PrivateKey);
    });

    test("Should [return Secp256k1PrivateKey] constructed from mnemonic and derivation path (m/44'/60'/0'/0/1)", () async {
      // Arrange
      LegacyDerivationPath actualLegacyDerivationPath = LegacyDerivationPath.parse("m/44'/60'/0'/0/1");

      // Act
      Secp256k1PrivateKey actualSecp256k1PrivateKey = await actualSecp256k1Derivator.derivePath(actualMnemonic, actualLegacyDerivationPath);

      // Assert
      Secp256k1PrivateKey expectedSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('3VL5eTTh8pFkN3ItX3mfcHrTbdRoGjyc7g2xVqBE20I='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('48321682786873812630811942224115257386621604474116153286196688270143935383344'),
        ),
      );

      expect(actualSecp256k1PrivateKey, expectedSecp256k1PrivateKey);
    });
  });

  group('Secp256k1Derivator.deriveMasterKey()', () {
    test('Should [return Secp256k1PrivateKey] constructed from mnemonic', () async {
      // Act
      Secp256k1PrivateKey actualSecp256k1PrivateKey = await actualSecp256k1Derivator.deriveMasterKey(actualMnemonic);

      // Assert
      Secp256k1PrivateKey expectedSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
        ),
      );

      expect(actualSecp256k1PrivateKey, expectedSecp256k1PrivateKey);
    });
  });

  group('Secp256k1Derivator.deriveChildKey()', () {
    test("Should [return Secp256k1PrivateKey] constructed from Secp256k1PrivateKey and DerivationPathElement (m/ -> m/44'/)", () {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("44'");

      // Master private key
      Secp256k1PrivateKey actualSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
        ),
      );

      // Act
      Secp256k1PrivateKey actualChildSecp256k1PrivateKey = actualSecp256k1Derivator.deriveChildKey(actualSecp256k1PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and 44' derivation path element
      Secp256k1PrivateKey expectedChildSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('bBRorINnDOQdK1WZf79vroWQHTPqtzASttTKd9zj8DQ='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('79831946198650946731958597072964003247551220898694366462475661038263959258621'),
        ),
      );

      expect(actualChildSecp256k1PrivateKey, expectedChildSecp256k1PrivateKey);
    });

    test("Should [return Secp256k1PrivateKey] constructed from Secp256k1PrivateKey and DerivationPathElement (m/44'/ -> m/44'/60'/)", () {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("60'");

      // Private key derived from master private key and m/44' derivation path (value calculated in the previous test)
      Secp256k1PrivateKey actualSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('bBRorINnDOQdK1WZf79vroWQHTPqtzASttTKd9zj8DQ='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('79831946198650946731958597072964003247551220898694366462475661038263959258621'),
        ),
      );

      // Act
      Secp256k1PrivateKey actualChildSecp256k1PrivateKey = actualSecp256k1Derivator.deriveChildKey(actualSecp256k1PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and m/44'/60' derivation path
      Secp256k1PrivateKey expectedChildSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('qEamIw6rnFvaXJCnzkIP7knN1l+8jTwYrrUWH78PRvs='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('33468663939336344008642663460868643449058067978731001309522127228111822578589'),
        ),
      );

      expect(actualChildSecp256k1PrivateKey, expectedChildSecp256k1PrivateKey);
    });

    test("Should [return Secp256k1PrivateKey] constructed from Secp256k1PrivateKey and DerivationPathElement (m/44'/60'/ -> m/44'/60'/0'/)", () {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse("0'");

      // Private key derived from master private key and m/44'/60' derivation path (value calculated in the previous test)
      Secp256k1PrivateKey actualSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('qEamIw6rnFvaXJCnzkIP7knN1l+8jTwYrrUWH78PRvs='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('33468663939336344008642663460868643449058067978731001309522127228111822578589'),
        ),
      );

      // Act
      Secp256k1PrivateKey actualChildSecp256k1PrivateKey = actualSecp256k1Derivator.deriveChildKey(actualSecp256k1PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and m/44'/60'/0' derivation path
      Secp256k1PrivateKey expectedChildSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('5gvokyLRAipECLgT5AnkPLX6thREo+E27t5wUBpna9w='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('34110929557805538687207758350694761629513303450048015188759646123112870087187'),
        ),
      );

      expect(actualChildSecp256k1PrivateKey, expectedChildSecp256k1PrivateKey);
    });

    test("Should [return Secp256k1PrivateKey] constructed from Secp256k1PrivateKey and DerivationPathElement (m/44'/60'/0'/ -> m/44'/60'/0'/0/)", () {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse('0');

      // Private key derived from master private key and m/44'/60'/0' derivation path (value calculated in the previous test)
      Secp256k1PrivateKey actualSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('5gvokyLRAipECLgT5AnkPLX6thREo+E27t5wUBpna9w='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('34110929557805538687207758350694761629513303450048015188759646123112870087187'),
        ),
      );

      // Act
      Secp256k1PrivateKey actualChildSecp256k1PrivateKey = actualSecp256k1Derivator.deriveChildKey(actualSecp256k1PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and m/44'/60'/0'/0 derivation path
      Secp256k1PrivateKey expectedChildSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('FK0bd1Z1KEZpXlZ45+GufE0HsweNVoh7EkZndgnxmVA='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('105108244234952036067739519086050878250157101554789072999465154826127982006038'),
        ),
      );

      expect(actualChildSecp256k1PrivateKey, expectedChildSecp256k1PrivateKey);
    });

    test("Should [return Secp256k1PrivateKey] constructed from Secp256k1PrivateKey and DerivationPathElement (m/44'/60'/0'/0/ -> m/44'/60'/0'/0/0)", () {
      // Arrange
      LegacyDerivationPathElement actualDerivationPathElement = LegacyDerivationPathElement.parse('0');

      // Private key derived from master private key and m/44'/60'/0'/0 derivation path (value calculated in the previous test)
      Secp256k1PrivateKey actualSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('FK0bd1Z1KEZpXlZ45+GufE0HsweNVoh7EkZndgnxmVA='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('105108244234952036067739519086050878250157101554789072999465154826127982006038'),
        ),
      );

      // Act
      Secp256k1PrivateKey actualChildSecp256k1PrivateKey = actualSecp256k1Derivator.deriveChildKey(actualSecp256k1PrivateKey, actualDerivationPathElement);

      // Assert
      // Private key derived from master private key and m/44'/60'/0'/0/0 derivation path
      Secp256k1PrivateKey expectedChildSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('YsN74zJ6p9/kjsFCM5UUBq470XR3CEssHXyawdn7xBw='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('91850346642365090382529827989594437164777469345439968194889143349494450093883'),
        ),
      );

      expect(actualChildSecp256k1PrivateKey, expectedChildSecp256k1PrivateKey);
    });
  });
}
