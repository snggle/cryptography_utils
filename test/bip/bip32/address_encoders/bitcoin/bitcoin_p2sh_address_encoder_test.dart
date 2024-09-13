import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  ECPoint actualPointQ = ECPoint(
    x: BigInt.parse('45598833024007063412331531275003851810927383922680420932075021036000176892257'),
    y: BigInt.parse('52075805451846365275495005964097842681620553159632658097877797800509943385562'),
    z: BigInt.parse('11902898874332229604673834019199903475888972972060602920606280067238874780442'),
    n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
    curve: Curves.secp256k1,
  );

  Secp256k1PublicKey actualPublicKey = Secp256k1PublicKey(
    ecPublicKey: ECPublicKey(CurvePoints.generatorSecp256k1, actualPointQ),
    metadata: Bip32KeyMetadata(
      depth: 5,
      shiftedIndex: 0,
      fingerprint: BigInt.parse('2009194743'),
      parentFingerprint: BigInt.parse('3366442085'),
      masterFingerprint: BigInt.parse('83580899'),
      chainCode: base64Decode('dD+m4pyYe3edlY9ZDNDpe370dwMmGNF2ihkMDXjYSpY='),
    ),
  );

  group('Tests of BitcoinP2SHAddressEncoder.encodePublicKey()', () {
    test('Should [return Bitcoin P2SH address] for given public key', () {
      // Arrange
      BitcoinP2SHAddressEncoder actualBitcoinP2SHAddressEncoder = BitcoinP2SHAddressEncoder();

      // Act
      String actualAddress = actualBitcoinP2SHAddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = '38BaaMYeUR32tptWPcfLiuZwdkq1iHy7mW';

      expect(actualAddress, expectedAddress);
    });
  });
}
