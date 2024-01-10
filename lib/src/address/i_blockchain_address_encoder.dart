import 'package:cryptography_utils/cryptography_utils.dart';

/// The [IBlockchainAddressEncoder] interface is designed for encode addresses in accordance with the specific blockchain network.
abstract interface class IBlockchainAddressEncoder<T extends IBip32PublicKey> {
  String encodePublicKey(T publicKey);
}
