import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  ECPoint actualPointQ = ECPoint(
    x: BigInt.parse('103541830980023606809613093633067363502594290705821036222890728111110906420509'),
    y: BigInt.parse('75808906644622006047938879719654783679105512040910575915102508326553703647166'),
    z: BigInt.parse('3190226348536498292494465017020441737630476122313049345633869118655223224149'),
    n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
    curve: Curves.secp256k1,
  );

  Secp256k1PublicKey actualPublicKey = Secp256k1PublicKey(
    ecPublicKey: ECPublicKey(CurvePoints.generatorSecp256k1, actualPointQ),
    metadata: Bip32KeyMetadata(
      depth: 5,
      shiftedIndex: 0,
      fingerprint: BigInt.parse('2889905688'),
      parentFingerprint: BigInt.parse('58474422'),
      masterFingerprint: BigInt.parse('83580899'),
      chainCode: base64Decode('atgf2JWMxW014Hby5ccSn5NlRKQvIV2jvsdtcN3Eb8I='),
    ),
  );

  group('Tests of CosmosAddressEncoder.serializeType()', () {
    test('Should [return "cosmos(cosmos)"] for CosmosAddressEncoder with "cosmos" hrp', () {
      // Arrange
      CosmosAddressEncoder actualCosmosAddressEncoder = CosmosAddressEncoder(hrp: 'cosmos');

      // Act
      String actualSerializedType = actualCosmosAddressEncoder.serializeType();

      // Assert
      String expectedSerializedType = 'cosmos(cosmos)';

      expect(actualSerializedType, expectedSerializedType);
    });
  });

  group('Tests of CosmosAddressEncoder.encodePublicKey()', () {
    test('Should [return Cosmos address] for given public key (cosmos)', () {
      // Arrange
      CosmosAddressEncoder actualCosmosAddressEncoder = CosmosAddressEncoder(hrp: 'cosmos');

      // Act
      String actualAddress = actualCosmosAddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = 'cosmos143q8vxpvuykt9pq50e6hng9s38vmy844rgut0t';

      expect(actualAddress, expectedAddress);
    });

    test('Should [return Cosmos address] for given public key (kira)', () {
      // Arrange
      CosmosAddressEncoder actualCosmosAddressEncoder = CosmosAddressEncoder(hrp: 'kira');

      // Act
      String actualAddress = actualCosmosAddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

      expect(actualAddress, expectedAddress);
    });
  });
}
