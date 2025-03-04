import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The [CosmosAddressEncoder] class is designed for encoding addresses in accordance with the Cosmos network.
/// Cosmos addresses are encoded using the Bech32 algorithm, which is specified in BIP-0173 and BIP-0350:
/// https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki
/// https://github.com/bitcoin/bips/blob/master/bip-0350.mediawiki
class CosmosAddressEncoder extends ABlockchainAddressEncoder<Secp256k1PublicKey> {
  final String hrp;

  CosmosAddressEncoder({required this.hrp});

  @override
  AddressEncoderType get addressEncoderType => AddressEncoderType.cosmos;

  @override
  List<String> get args => <String>[hrp];

  @override
  String encodePublicKey(Secp256k1PublicKey publicKey) {
    Uint8List publicKeyFingerprint = Sha256().convert(publicKey.compressed).byteList;
    Uint8List publicKeyHash = Ripemd160().process(publicKeyFingerprint);

    return Bech32Codec.encode(Bech32Pair(hrp: hrp, data: publicKeyHash));
  }
}
