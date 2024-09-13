import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  ECPoint actualPointQ = ECPoint(
    x: BigInt.parse('38336877429777144060267786813855742566762755003810222330370030177500553175552'),
    y: BigInt.parse('43563831752869961512099662435070760564842488811079803779798870455459619618648'),
    z: BigInt.parse('84221606303351351252384011276733806130312533127115701665238461934963837834470'),
    n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
    curve: Curves.secp256k1,
  );

  Secp256k1PublicKey actualPublicKey = Secp256k1PublicKey(
    ecPublicKey: ECPublicKey(CurvePoints.generatorSecp256k1, actualPointQ),
    metadata: Bip32KeyMetadata(
      depth: 5,
      shiftedIndex: 0,
      fingerprint: BigInt.parse('220462739'),
      parentFingerprint: BigInt.parse('541880847'),
      masterFingerprint: BigInt.parse('83580899'),
      chainCode: base64Decode('rEcUq915xZMcSVN9UIfhWIf7c+cb9fURwnXSJ59fbhs='),
    ),
  );

  group('Tests of BitcoinP2PKHAddressEncoder.encodePublicKey()', () {
    test('Should [return Bitcoin P2PKH address] for given public key (public key COMPRESSED)', () {
      // Arrange
      BitcoinP2PKHAddressEncoder actualBitcoinP2PKHAddressEncoder = BitcoinP2PKHAddressEncoder(publicKeyMode: PublicKeyMode.compressed);

      // Act
      String actualAddress = actualBitcoinP2PKHAddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = '12CUuS1w48dmLqug3sQeZGXhM6ziyLdDFR';

      expect(actualAddress, expectedAddress);
    });

    test('Should [return Bitcoin P2PKH address] for given public key (public key UNCOMPRESSED)', () {
      // Arrange
      BitcoinP2PKHAddressEncoder actualBitcoinP2PKHAddressEncoder = BitcoinP2PKHAddressEncoder(publicKeyMode: PublicKeyMode.uncompressed);

      // Act
      String actualAddress = actualBitcoinP2PKHAddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = '1PkHDRGVzHNc3dSnBEZ8MzULiyTKEibk7c';

      expect(actualAddress, expectedAddress);
    });
  });
}
