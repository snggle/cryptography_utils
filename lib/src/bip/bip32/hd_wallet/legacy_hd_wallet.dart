import 'package:cryptography_utils/cryptography_utils.dart';

/// Hierarchical Deterministic Wallet for legacy coins (Bitcoin, Ethereum, Cosmos etc.).
/// https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki
class LegacyHDWallet extends AHDWallet {
  final LegacyDerivationPath? derivationPath;

  const LegacyHDWallet({
    required super.address,
    required super.walletConfig,
    required super.privateKey,
    required super.publicKey,
    this.derivationPath,
  });

  /// Creates a new [LegacyHDWallet] from a mnemonic and a derivation path.
  static Future<LegacyHDWallet> fromMnemonic({
    required String derivationPathString,
    required Mnemonic mnemonic,
    required LegacyWalletConfig<IBip32PrivateKey> walletConfig,
  }) async {
    LegacyDerivationPath derivationPath = LegacyDerivationPath.parse(derivationPathString);

    IBip32PrivateKey bip32PrivateKey = await walletConfig.derivator.derivePath(mnemonic, derivationPath);
    IBip32PublicKey bip32PublicKey = bip32PrivateKey.publicKey;

    String address = walletConfig.addressEncoder.encodePublicKey(bip32PublicKey);

    return LegacyHDWallet(
      address: address,
      walletConfig: walletConfig,
      privateKey: bip32PrivateKey,
      publicKey: bip32PublicKey,
      derivationPath: derivationPath,
    );
  }

  @override
  List<Object?> get props => <Object?>[address, walletConfig, privateKey, publicKey, derivationPath];
}
