import 'package:cryptography_utils/cryptography_utils.dart';

/// [Bip49WalletsConfig] class provides configurations for creating wallets adhering to BIP-49 standards.
/// Configurations include:
///   - `addressEncoder`: Algorithm used for address encoding
///   - `derivator`: Algorithm used for key derivation
///   - `coinIndex`: Index of the coin as per the SLIP44 standard
///   - `curveType`: Type of the elliptic curve used for key generation
///   - `purpose`: Type of the BIP proposal
// TODO(dominik): This class is likely unnecessary for the SNGGLE application. After full integration of SNGGLE with the cryptography_utils, review whether this class should be removed.
class Bip49WalletsConfig {
  static LegacyWalletConfig<Secp256k1PrivateKey> bitcoin = LegacyWalletConfig<Secp256k1PrivateKey>(
    addressEncoder: BitcoinP2SHAddressEncoder(),
    derivator: Secp256k1Derivator(),
    curveType: CurveType.secp256k1,
  );
}
