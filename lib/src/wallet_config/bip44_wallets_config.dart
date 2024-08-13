import 'package:cryptography_utils/cryptography_utils.dart';

/// [Bip44WalletsConfig] class provides configurations for creating wallets adhering to BIP-44 standards.
/// Configurations include:
///   - `addressEncoder`: Algorithm used for address encoding
///   - `derivator`: Algorithm used for key derivation
///   - `curveType`: Type of the elliptic curve used for key generation
// TODO(dominik): This class is likely unnecessary for the SNGGLE application. After full integration of SNGGLE with the cryptography_utils, review whether this class should be removed.
class Bip44WalletsConfig {
  static LegacyWalletConfig<Secp256k1PrivateKey> bitcoin = LegacyWalletConfig<Secp256k1PrivateKey>(
    addressEncoder: BitcoinP2PKHAddressEncoder(),
    derivator: Secp256k1Derivator(),
    curveType: CurveType.secp256k1,
  );

  static LegacyWalletConfig<Secp256k1PrivateKey> cosmos = LegacyWalletConfig<Secp256k1PrivateKey>(
    addressEncoder: CosmosAddressEncoder(hrp: Slip173.cosmos),
    derivator: Secp256k1Derivator(),
    curveType: CurveType.secp256k1,
  );

  static LegacyWalletConfig<Secp256k1PrivateKey> ethereum = LegacyWalletConfig<Secp256k1PrivateKey>(
    addressEncoder: EthereumAddressEncoder(),
    derivator: Secp256k1Derivator(),
    curveType: CurveType.secp256k1,
  );

  static LegacyWalletConfig<Secp256k1PrivateKey> kira = LegacyWalletConfig<Secp256k1PrivateKey>(
    addressEncoder: CosmosAddressEncoder(hrp: Slip173.kira),
    derivator: Secp256k1Derivator(),
    curveType: CurveType.secp256k1,
  );
}
