import 'package:cryptography_utils/cryptography_utils.dart';

/// The [SolanaAddressEncoder] class is designed for encoding addresses in accordance with the Solana network.
/// Solana uses the Base58 encoding to generate addresses from public keys
class SolanaAddressEncoder implements IBlockchainAddressEncoder<ED25519PublicKey> {
  const SolanaAddressEncoder();

  @override
  String encodePublicKey(ED25519PublicKey publicKey) {
    return Base58Encoder.encode(publicKey.bytes);
  }
}
