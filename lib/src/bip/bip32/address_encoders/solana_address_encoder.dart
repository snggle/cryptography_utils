import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The [SolanaAddressEncoder] class is designed for encoding addresses in accordance with the Solana network.
/// Solana uses the Base58 encoding to generate addresses from public keys
class SolanaAddressEncoder extends ABlockchainAddressEncoder<ED25519PublicKey> {
  @override
  AddressEncoderType get addressEncoderType => AddressEncoderType.solana;

  @override
  List<String> get args => <String>[];

  @override
  String encodePublicKey(ED25519PublicKey publicKey) {
    return Base58Codec.encode(publicKey.bytes);
  }
}
