import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ECPublicKey.compressed getter', () {
    test('Should [return bytes] representing [COMPRESSED ECPublicKey] (Secp256k1)', () {
      // Arrange
      ECPublicKey ecPublicKey = ECPublicKey(
        CurvePoints.generatorSecp256k1,
        ECPoint(
          curve: Curves.secp256k1,
          n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
          x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
          y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
          z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
        ),
      );

      // Act
      Uint8List actualCompressedPublicKey = ecPublicKey.compressed;

      // Assert
      Uint8List expectedCompressedPublicKey = base64Decode('Ar+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2Yj');

      expect(actualCompressedPublicKey, expectedCompressedPublicKey);
    });

    test('Should [return bytes] representing [UNCOMPRESSED ECPublicKey] (Secp256k1)', () {
      // Assert
      ECPublicKey ecPublicKey = ECPublicKey(
        CurvePoints.generatorSecp256k1,
        ECPoint(
          curve: Curves.secp256k1,
          n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
          x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
          y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
          z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
        ),
      );

      // Act
      Uint8List actualUncompressedPublicKey = ecPublicKey.uncompressed;

      // Assert
      Uint8List expectedUncompressedPublicKey = base64Decode('BL+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2YjRdh4yvIJvEV4shNwcx/bJI+WUme3DGfy1SuRlBmPA4o=');

      expect(actualUncompressedPublicKey, expectedUncompressedPublicKey);
    });
  });
}
