import 'package:cryptography_utils/cryptography_utils.dart';

/// [Bip49WalletsConfig] class provides configurations for creating wallets adhering to BIP-49 standards.
/// Configurations include:
///   - `derivator`: Algorithm used for key derivation
///   - `coinIndex`: Index of the coin as per the SLIP44 standard
///   - `curveType`: Type of the elliptic curve used for key generation
///   - `purpose`: Type of the BIP proposal
class Bip49WalletsConfig {
  static LegacyWalletConfig bitcoin = LegacyWalletConfig(
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.bitcoin,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip49,
  );
}
