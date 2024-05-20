import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Secp256k1PublicKey.getExtendedPublicKey() getter', () {
    test('Should [return xpub] representing extended public key', () {
      // Arrange
      Secp256k1PublicKey actualSecp256k1PublicKey = Secp256k1PublicKey(
        ecPublicKey: ECPublicKey(
          CurvePoints.generatorSecp256k1,
          ECPoint(
            curve: Curves.secp256k1,
            n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
            x: BigInt.parse('49844093485842753019501723164709087800134847594852664670182601545797061237061'),
            y: BigInt.parse('102584019795063234624860865414832132871049165551248963828805190591824528686504'),
            z: BigInt.parse('33112508886275853310422687256511308836721055527980470378416551104097868981749'),
          ),
        ),
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('YsN74zJ6p9/kjsFCM5UUBq470XR3CEssHXyawdn7xBw='),
        ),
      );

      // Act
      String actualExtendedPublicKey = actualSecp256k1PublicKey.getExtendedPublicKey();

      // Assert
      String expectedExtendedPublicKey = 'xpub6FVA8roHyEdNqCFyPandmu5GchJtGbHAnVzSVGD1VU9iYccPsME9PSrM4Jf2BFkcAkLV5bTyPVjxqZMdQz6tWhq8T1DSj48ADHABqV4n3vL';

      expect(actualExtendedPublicKey, expectedExtendedPublicKey);
    });
  });

  group('Tests of Secp256k1PublicKey.metadata getter', () {
    test('Should [return Bip32KeyMetadata] representing additional info about the public key', () {
      // Arrange
      Secp256k1PublicKey actualSecp256k1PublicKey = Secp256k1PublicKey(
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
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('83580899'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ),
      );

      // Act
      Bip32KeyMetadata actualBip32KeyMetadata = actualSecp256k1PublicKey.metadata;

      // Assert
      Bip32KeyMetadata expectedBip32KeyMetadata = Bip32KeyMetadata(
        depth: 0,
        fingerprint: BigInt.parse('83580899'),
        parentFingerprint: BigInt.parse('0'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
      );

      expect(actualBip32KeyMetadata, expectedBip32KeyMetadata);
    });
  });

  group('Tests of Secp256k1PublicKey.bytes getter', () {
    test('Should [return bytes] representing [Secp256k1PublicKey]', () {
      // Arrange
      Secp256k1PublicKey actualSecp256k1PublicKey = Secp256k1PublicKey(
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
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('83580899'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ),
      );

      // Act
      Uint8List actualCompressedPublicKey = actualSecp256k1PublicKey.compressed;

      // Assert
      Uint8List expectedCompressedPublicKey = base64Decode('Ar+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2Yj');

      expect(actualCompressedPublicKey, expectedCompressedPublicKey);
    });
  });

  group('Tests of Secp256k1PublicKey.compressed getter', () {
    test('Should [return bytes] representing [COMPRESSED Secp256k1PublicKey]', () {
      // Arrange
      Secp256k1PublicKey actualSecp256k1PublicKey = Secp256k1PublicKey(
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
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('83580899'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ),
      );

      // Act
      Uint8List actualCompressedPublicKey = actualSecp256k1PublicKey.compressed;

      // Assert
      Uint8List expectedCompressedPublicKey = base64Decode('Ar+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2Yj');

      expect(actualCompressedPublicKey, expectedCompressedPublicKey);
    });
  });

  group('Tests of Secp256k1PublicKey.uncompressed getter', () {
    test('Should [return bytes] representing [UNCOMPRESSED Secp256k1PublicKey]', () {
      // Arrange
      Secp256k1PublicKey actualSecp256k1PublicKey = Secp256k1PublicKey(
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
        metadata: Bip32KeyMetadata(
          depth: 0,
          fingerprint: BigInt.parse('83580899'),
          parentFingerprint: BigInt.parse('0'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
        ),
      );

      // Act
      Uint8List actualCompressedPublicKey = actualSecp256k1PublicKey.uncompressed;

      // Assert
      Uint8List expectedCompressedPublicKey = base64Decode('BL+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2YjRdh4yvIJvEV4shNwcx/bJI+WUme3DGfy1SuRlBmPA4o=');

      expect(actualCompressedPublicKey, expectedCompressedPublicKey);
    });
  });
}
