import 'package:cryptography_utils/cryptography_utils.dart';

/// [Bip84WalletsConfig] class provides configurations for creating wallets adhering to BIP-84 standards.
/// Configurations include:
///   - `addressEncoder`: Algorithm used for address encoding
///   - `derivator`: Algorithm used for key derivation
///   - `coinIndex`: Index of the coin as per the SLIP44 standard
///   - `curveType`: Type of the elliptic curve used for key generation
///   - `purpose`: Type of the BIP proposal
class Bip84WalletsConfig {
  static LegacyWalletConfig bitcoin = LegacyWalletConfig(
    addressEncoder: BitcoinP2WPKHAddressEncoder(hrp: Slip173.bitcoin),
    derivator: Secp256k1Derivator(),
    coinIndex: Slip44.bitcoin,
    curveType: CurveType.secp256k1,
    purpose: BipProposalType.bip84,
  );
}
