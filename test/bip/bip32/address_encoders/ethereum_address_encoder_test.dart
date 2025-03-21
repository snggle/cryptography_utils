import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  ECPoint actualPointQ = ECPoint(
    x: BigInt.parse('49844093485842753019501723164709087800134847594852664670182601545797061237061'),
    y: BigInt.parse('102584019795063234624860865414832132871049165551248963828805190591824528686504'),
    z: BigInt.parse('33112508886275853310422687256511308836721055527980470378416551104097868981749'),
    n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
    curve: Curves.secp256k1,
  );

  Secp256k1PublicKey actualPublicKey = Secp256k1PublicKey(
    ecPublicKey: ECPublicKey(CurvePoints.generatorSecp256k1, actualPointQ),
    metadata: Bip32KeyMetadata(
      depth: 5,
      shiftedIndex: 0,
      fingerprint: BigInt.parse('2837893204'),
      parentFingerprint: BigInt.parse('162080603'),
      masterFingerprint: BigInt.parse('83580899'),
      chainCode: base64Decode('YsN74zJ6p9/kjsFCM5UUBq470XR3CEssHXyawdn7xBw='),
    ),
  );

  group('Tests of EthereumAddressEncoder.serializeType()', () {
    test('Should [return "ethereum(true)"] for EthereumAddressEncoder with [skipChecksumBool == TRUE]', () {
      // Arrange
      EthereumAddressEncoder actualEthereumAddressEncoder = EthereumAddressEncoder(skipChecksumBool: true);

      // Act
      String actualSerializedType = actualEthereumAddressEncoder.serializeType();

      // Assert
      String expectedSerializedType = 'ethereum(true)';

      expect(actualSerializedType, expectedSerializedType);
    });

    test('Should [return "ethereum(false)"] for EthereumAddressEncoder with [skipChecksumBool == FALSE]', () {
      // Arrange
      EthereumAddressEncoder actualEthereumAddressEncoder = EthereumAddressEncoder(skipChecksumBool: false);

      // Act
      String actualSerializedType = actualEthereumAddressEncoder.serializeType();

      // Assert
      String expectedSerializedType = 'ethereum(false)';

      expect(actualSerializedType, expectedSerializedType);
    });
  });

  group('Tests of EthereumAddressEncoder.encodePublicKey()', () {
    test('Should [return Etherum address] [WITH checksum] for given public key', () {
      // Arrange
      EthereumAddressEncoder actualEthereumAddressEncoder = EthereumAddressEncoder(skipChecksumBool: false);

      // Act
      String actualAddress = actualEthereumAddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = '0x50e10257924889818aA729c6EDfa02524b32Edb9';

      expect(actualAddress, expectedAddress);
    });

    test('Should [return Etherum address] [WITHOUT checksum] for given public key', () {
      // Arrange
      EthereumAddressEncoder actualEthereumAddressEncoder = EthereumAddressEncoder(skipChecksumBool: true);

      // Act
      String actualAddress = actualEthereumAddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = '0x50e10257924889818aa729c6edfa02524b32edb9';

      expect(actualAddress, expectedAddress);
    });
  });
}
