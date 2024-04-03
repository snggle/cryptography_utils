import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// [AHDWallet] is an abstract class representing the foundation of a Hierarchical Deterministic (HD) Wallet,
/// HD Wallets store private keys, public keys and addresses generated from a single master seed.
/// https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki
abstract class AHDWallet extends Equatable {
  final String address;
  final AWalletConfig walletConfig;
  final IBip32PrivateKey privateKey;
  final IBip32PublicKey publicKey;

  const AHDWallet({
    required this.address,
    required this.walletConfig,
    required this.privateKey,
    required this.publicKey,
  });

  @override
  List<Object?> get props => <Object>[address, walletConfig, privateKey, publicKey];
}
