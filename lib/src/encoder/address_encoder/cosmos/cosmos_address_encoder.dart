import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/address_encoder/address_encoder_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/bech32/bech32_pair.dart';

/// The [CosmosAddressEncoder] class is designed for encoding addresses in accordance with the Cosmos network.
/// Cosmos addresses are encoded using the Bech32 algorithm, which is specified in BIP-0173 and BIP-0350:
/// https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki
/// https://github.com/bitcoin/bips/blob/master/bip-0350.mediawiki
class CosmosAddressEncoder extends ABlockchainAddressEncoder<Secp256k1PublicKey> {
  final String hrp;

  CosmosAddressEncoder({required this.hrp});

  @override
  String encodePublicKey(Secp256k1PublicKey publicKey) {
    Uint8List publicKeyFingerprint = Uint8List.fromList(sha256.convert(publicKey.compressed).bytes);
    Uint8List publicKeyHash = Ripemd160().process(publicKeyFingerprint);

    return Bech32Encoder.encode(Bech32Pair(hrp: hrp, data: publicKeyHash));
  }

  @override
  List<String> get args => <String>[hrp];

  @override
  AddressEncoderType get addressEncoderType => AddressEncoderType.cosmos;
}
