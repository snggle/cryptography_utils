import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The [BitcoinP2WPKHAddressEncoder] class is designed for encoding P2WPKH (Pay-to-Witness-Public-Key-Hash) addresses in accordance with Bitcoin.
/// P2SH addresses utilize the RIPEMD-160 and SHA-256 hash functions to generate addresses from a script's hash.
/// P2WPKH addresses are encoded using the Bech32 (Segwit) algorithm, which is specified in BIP-0173 and BIP-0350:
/// https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki
/// https://github.com/bitcoin/bips/blob/master/bip-0350.mediawiki
class BitcoinP2WPKHAddressEncoder extends ABlockchainAddressEncoder<Secp256k1PublicKey> {
  static const int _witnessVersion = 0;

  final String hrp;

  BitcoinP2WPKHAddressEncoder({required this.hrp});

  @override
  AddressEncoderType get addressEncoderType => AddressEncoderType.bitcoinP2WPKH;

  @override
  List<String> get args => <String>[hrp];

  @override
  String encodePublicKey(Secp256k1PublicKey publicKey) {
    Uint8List publicKeyFingerprint = Uint8List.fromList(sha256.convert(publicKey.compressed).bytes);
    Uint8List publicKeyHash = Ripemd160().process(publicKeyFingerprint);

    return SegwitBech32Codec.encode(hrp, _witnessVersion, publicKeyHash);
  }
}
