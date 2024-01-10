import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The [CosmosAddressEncoder] class is designed for encoding addresses in accordance with the Cosmos network.
/// Cosmos addresses are encoded using the Bech32 algorithm, which is specified in BIP-0173 and BIP-0350:
/// https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki
/// https://github.com/bitcoin/bips/blob/master/bip-0350.mediawiki
class CosmosAddressEncoder implements IBlockchainAddressEncoder<Secp256k1PublicKey> {
  final String hrp;

  CosmosAddressEncoder({required this.hrp});

  @override
  String encodePublicKey(Secp256k1PublicKey publicKey) {
    Uint8List publicKeyFingerprint = Uint8List.fromList(sha256.convert(publicKey.compressed).bytes);
    Uint8List publicKeyHash = Ripemd160().process(publicKeyFingerprint);

    return Bech32Encoder.encode(hrp, publicKeyHash);
  }
}
