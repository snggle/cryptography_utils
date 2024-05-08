import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ECPrivateKey.fromBytes() constructor', () {
    test('Should [return ECPrivateKey] constructed from given bytes (Secp256k1)', () {
      // Act
      ECPrivateKey actualECPrivateKey = ECPrivateKey.fromBytes(
        base64Decode('IxMiv7h+lmU8ouyK8Ds+wP5EL/n1Kv0TKJft3E0Kf8M='),
        CurvePoints.generatorSecp256k1,
      );

      // Assert
      ECPrivateKey expectedECPrivateKey = ECPrivateKey(
        CurvePoints.generatorSecp256k1,
        BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
      );

      expect(actualECPrivateKey, expectedECPrivateKey);
    });
  });

  group('Tests of ECPrivateKey.bytes getter', () {
    test('Should [return key bytes] from ECPrivateKey (Secp256k1)', () {
      // Arrange
      ECPrivateKey actualECPrivateKey = ECPrivateKey(
        CurvePoints.generatorSecp256k1,
        BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
      );

      // Act
      Uint8List actualPrivateKeyBytes = actualECPrivateKey.bytes;

      // Assert
      Uint8List expectedPrivateKeyBytes = base64Decode('IxMiv7h+lmU8ouyK8Ds+wP5EL/n1Kv0TKJft3E0Kf8M=');

      expect(actualPrivateKeyBytes, expectedPrivateKeyBytes);
    });
  });

  group('Tests of ECPrivateKey.ecPublicKey getter', () {
    test('Should [return ECPublicKey] from ECPrivateKey (Secp256k1)', () {
      // Arrange
      ECPrivateKey actualECPrivateKey = ECPrivateKey(
        CurvePoints.generatorSecp256k1,
        BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
      );

      // Act
      ECPublicKey actualECPublicKey = actualECPrivateKey.ecPublicKey;

      // Assert
      ECPublicKey expectedECPublicKey = ECPublicKey(
        CurvePoints.generatorSecp256k1,
        ECPoint(
          curve: CurvePoints.generatorSecp256k1.curve,
          n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
          x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
          y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
          z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
        ),
      );

      expect(actualECPublicKey, expectedECPublicKey);
    });
  });
}
