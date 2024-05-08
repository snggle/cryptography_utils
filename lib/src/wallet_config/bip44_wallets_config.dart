import 'package:cryptography_utils/cryptography_utils.dart';

/// [Bip44WalletsConfig] class provides configurations for creating wallets adhering to BIP-44 standards.
/// Configurations include:
///   - `addressEncoder`: Algorithm used for address encoding
///   - `derivator`: Algorithm used for key derivation
///   - `coinIndex`: Index of the coin as per the SLIP44 standard
///   - `curveType`: Type of the elliptic curve used for key generation
///   - `purpose`: Type of the BIP proposal
class Bip44WalletsConfig {
  static LegacyWalletConfig<Secp256k1PrivateKey> bitcoin = LegacyWalletConfig<Secp256k1PrivateKey>(
    addressEncoder: BitcoinP2PKHAddressEncoder(),
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.bitcoin,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip44,
  );

  static LegacyWalletConfig<Secp256k1PrivateKey> cosmos = LegacyWalletConfig<Secp256k1PrivateKey>(
    addressEncoder: CosmosAddressEncoder(hrp: Slip173.cosmos),
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.cosmos,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip44,
  );

  static LegacyWalletConfig<Secp256k1PrivateKey> ethereum = LegacyWalletConfig<Secp256k1PrivateKey>(
    addressEncoder: EthereumAddressEncoder(),
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.ethereum,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip44,
  );

  static LegacyWalletConfig<Secp256k1PrivateKey> kira = LegacyWalletConfig<Secp256k1PrivateKey>(
    addressEncoder: CosmosAddressEncoder(hrp: Slip173.kira),
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.kira,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip44,
  );
}
