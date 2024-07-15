import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/ecdsa/signer/ecdsa_verifier.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ECDSAVerifier.isSignatureValid()', () {
    test('Should [return TRUE] if [signature VALID] for given private key (Secp256k1)', () {
      // Arrange
      Uint8List actualMessage = Uint8List.fromList('Hello world'.codeUnits);
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('21165175836978812381665558937913198224702266563755240335786634922159270665737'),
        s: BigInt.parse('67243574932862348866046687334828474181280536427312945072404625477687067369325'),
        ecCurve: Curves.secp256k1,
      );
      ECPublicKey actualECPublicKey = ECPublicKey(
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
      bool actualSignatureValidBool = ECDSAVerifier(
        hashFunction: sha256,
        ecPublicKey: actualECPublicKey,
      ).isSignatureValid(actualMessage, actualECSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return FALSE] if [signature INVALID] for given private key (Secp256k1)', () {
      // Arrange
      Uint8List actualMessage = Uint8List.fromList('Hello world'.codeUnits);
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('102978385277191726159329221235853931845740505117174969823872713913281673197520'),
        s: BigInt.parse('473230762751246026821318165514853945171650154379161213745716102690305699328'),
        ecCurve: Curves.secp256k1,
      );
      ECPublicKey actualECPublicKey = ECPublicKey(
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
      bool actualSignatureValidBool = ECDSAVerifier(
        hashFunction: sha256,
        ecPublicKey: actualECPublicKey,
      ).isSignatureValid(actualMessage, actualECSignature);

      // Assert
      expect(actualSignatureValidBool, false);
    });
  });
}
