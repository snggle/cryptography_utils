import 'package:cryptography_utils/cryptography_utils.dart';

/// [Bip84WalletsConfig] class provides configurations for creating wallets in accordance with Substrate standards.
///   - `addressEncoder`: Algorithm used for address encoding
///   - `derivator`: Algorithm used for key derivation
class SubstrateWalletsConfig {
  static SubstrateWalletConfig polkadotSr25519 = SubstrateWalletConfig(
    addressEncoder: SubstrateSR25519AddressEncoder(ss58Format: 0),
    derivator: SubstrateSR25519Derivator(),
  );

  static SubstrateWalletConfig polkadotEd25519 = SubstrateWalletConfig(
    addressEncoder: SubstrateED25519AddressEncoder(ss58Format: 0),
    derivator: SubstrateED25519Derivator(),
  );

  static SubstrateWalletConfig kusamaSr25519 = SubstrateWalletConfig(
    addressEncoder: SubstrateSR25519AddressEncoder(ss58Format: 2),
    derivator: SubstrateSR25519Derivator(),
  );

  static SubstrateWalletConfig kusamaEd25519 = SubstrateWalletConfig(
    addressEncoder: SubstrateED25519AddressEncoder(ss58Format: 2),
    derivator: SubstrateED25519Derivator(),
  );

  static SubstrateWalletConfig substrateSr25519 = SubstrateWalletConfig(
    addressEncoder: SubstrateSR25519AddressEncoder(ss58Format: 42),
    derivator: SubstrateSR25519Derivator(),
  );

  static SubstrateWalletConfig substrateEd25519 = SubstrateWalletConfig(
    addressEncoder: SubstrateED25519AddressEncoder(ss58Format: 42),
    derivator: SubstrateED25519Derivator(),
  );
}
