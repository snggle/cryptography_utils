import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Secp256k1PrivateKey.bytes getter', () {
    test('Should [return bytes] representing Secp256k1PrivateKey', () {
      // Arrange
      Secp256k1PrivateKey actualSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
        ),
      );

      // Act
      Uint8List actualPrivateKeyBytes = actualSecp256k1PrivateKey.bytes;

      // Assert
      Uint8List expectedPrivateKeyBytes = base64Decode('IxMiv7h+lmU8ouyK8Ds+wP5EL/n1Kv0TKJft3E0Kf8M=');

      expect(actualPrivateKeyBytes, expectedPrivateKeyBytes);
    });
  });

  group('Tests of Secp256k1PrivateKey.chainCode getter', () {
    test('Should [return bytes] representing Secp256k1PrivateKey chain code', () {
      // Arrange
      Secp256k1PrivateKey actualSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
        ),
      );

      // Act
      Uint8List actualChainCode = actualSecp256k1PrivateKey.chainCode;

      // Assert
      Uint8List expectedChainCode = base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk=');

      expect(actualChainCode, expectedChainCode);
    });
  });

  group('Tests of Secp256k1PrivateKey.length getter', () {
    test('Should [return length] of Secp256k1PrivateKey', () {
      // Arrange
      Secp256k1PrivateKey actualSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
        ),
      );

      // Act
      int actualPrivateKeyLength = actualSecp256k1PrivateKey.length;

      // Assert
      int expectedPrivateKeyLength = 32;

      expect(actualPrivateKeyLength, expectedPrivateKeyLength);
    });
  });

  group('Tests of Secp256k1PrivateKey.publicKey getter', () {
    test('Should [return Secp256k1PublicKey] constructed from Secp256k1PrivateKey', () {
      // Arrange
      Secp256k1PrivateKey actualSecp256k1PrivateKey = Secp256k1PrivateKey(
        chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ecPrivateKey: ECPrivateKey(
          CurvePoints.generatorSecp256k1,
          BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
        ),
      );

      // Act
      Secp256k1PublicKey actualSecp256k1PublicKey = actualSecp256k1PrivateKey.publicKey;

      // Assert
      Secp256k1PublicKey expectedSecp256k1PublicKey = Secp256k1PublicKey(
        ecPublicKey: ECPublicKey(
          CurvePoints.generatorSecp256k1,
          ECPoint(
            curve: Curves.secp256k1,
            n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
            x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
            y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
            z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
          ),
        ),
      );

      expect(actualSecp256k1PublicKey, expectedSecp256k1PublicKey);
    });
  });
}
