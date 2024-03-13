import 'package:cryptography_utils/cryptography_utils.dart';

/// [Bip44WalletsConfig] class provides configurations for creating wallets adhering to BIP-44 standards.
/// Configurations include:
///   - `derivator`: Algorithm used for key derivation
///   - `coinIndex`: Index of the coin as per the SLIP44 standard
///   - `curveType`: Type of the elliptic curve used for key generation
///   - `purpose`: Type of the BIP proposal
class Bip44WalletsConfig {
  static LegacyWalletConfig bitcoin = LegacyWalletConfig(
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.bitcoin,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip44,
  );

  static LegacyWalletConfig ethereum = LegacyWalletConfig(
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.ethereum,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip44,
  );

  static LegacyWalletConfig cosmos = LegacyWalletConfig(
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.cosmos,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip44,
  );

  static LegacyWalletConfig kira = LegacyWalletConfig(
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.kira,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip44,
  );
}
