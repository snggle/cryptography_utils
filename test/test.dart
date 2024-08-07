import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

// ignore_for_file: avoid_print
// ignore_for_file: non_constant_identifier_names
void main() async {
  Secp256k1Derivator secp256k1Derivator = Secp256k1Derivator();
  EthereumAddressEncoder ethereumAddressEncoder = EthereumAddressEncoder();

  // Compressed public key for [m/44'/60'/0']
  Uint8List compressedPublicKeyFromSnggle = HexEncoder.decode('0x032465e114058d4edd33f8628b3ece1a27706ed7ef9cb24798e74ac0688adef7f0');
  Uint8List chainCode = HexEncoder.decode('0xf4c6cdf485d6fb64d3863f845e764f815b565caa8395a225db5589bbf966f20c');

  Secp256k1PublicKey publicKey_m_44_60_0 = Secp256k1PublicKey.fromCompressedBytes(
    compressedPublicKeyFromSnggle,
    metadata: Bip32KeyMetadata(chainCode: chainCode),
  );

  Secp256k1PublicKey publicKey_m_44_60_0_0 = secp256k1Derivator.derivePublicKey(publicKey_m_44_60_0, LegacyDerivationPathElement.parse('0'));
  Secp256k1PublicKey publicKey_m_44_60_0_0_0 = secp256k1Derivator.derivePublicKey(publicKey_m_44_60_0_0, LegacyDerivationPathElement.parse('0'));

  String address = ethereumAddressEncoder.encodePublicKey(publicKey_m_44_60_0_0_0);
  print(address);
  print(publicKey_m_44_60_0_0_0.metadata?.chainCode);
  print(publicKey_m_44_60_0_0_0.metadata?.parentFingerprint);
  print(publicKey_m_44_60_0_0_0.metadata?.fingerprint);
}
