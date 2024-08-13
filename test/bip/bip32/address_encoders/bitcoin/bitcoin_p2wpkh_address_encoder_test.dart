import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  ECPoint actualPointQ = ECPoint(
    x: BigInt.parse('76703126420722322007634345723463650715654444727861292197619275780698078484198'),
    y: BigInt.parse('74654274679389979607131077993714677055519561275235266585538223878569670773020'),
    z: BigInt.parse('40734431342056095760694605795848451157672234281365399275614292579983211792826'),
    n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
    curve: Curves.secp256k1,
  );

  Secp256k1PublicKey actualPublicKey = Secp256k1PublicKey(
    ecPublicKey: ECPublicKey(CurvePoints.generatorSecp256k1, actualPointQ),
    metadata: Bip32KeyMetadata(
      depth: 5,
      shiftedIndex: 0,
      fingerprint: BigInt.parse('3785737267'),
      parentFingerprint: BigInt.parse('4177480418'),
      masterFingerprint: BigInt.parse('83580899'),
      chainCode: base64Decode('HmhuNs2LO3+/SpMIb4FCOCRlS5Ym+ACIprpAAmG4zMI='),
    ),
  );

  group('Tests of BitcoinP2WPKHAddressEncoder.serializeType()', () {
    test('Should [return "bitcoinP2SH()"] for BitcoinP2WPKHAddressEncoder with "bc" hrp', () {
      // Arrange
      BitcoinP2WPKHAddressEncoder actualBitcoinP2PKHAddressEncoder = BitcoinP2WPKHAddressEncoder(hrp: 'bc');

      // Act
      String actualSerializedType = actualBitcoinP2PKHAddressEncoder.serializeType();

      // Assert
      String expectedSerializedType = 'bitcoinP2WPKH(bc)';

      expect(actualSerializedType, expectedSerializedType);
    });
  });

  group('Tests of BitcoinP2WPKHAddressEncoder.encodePublicKey()', () {
    test('Should [return Bitcoin P2WPKH address] for given public key', () {
      // Arrange
      BitcoinP2WPKHAddressEncoder actualBitcoinP2PKHAddressEncoder = BitcoinP2WPKHAddressEncoder(hrp: 'bc');

      // Act
      String actualAddress = actualBitcoinP2PKHAddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = 'bc1quxjugvagpv4kz5hdkh7x0qklarw5akdk2sg0wp';

      expect(actualAddress, expectedAddress);
    });
  });
}
