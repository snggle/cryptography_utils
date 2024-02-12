import 'package:cryptography_utils/cryptography_utils.dart';

/// Hierarchical Deterministic Wallet for substrate coins (Polkadot, Kusama, Substrate, etc.)
class SubstrateHDWallet extends AHDWallet {
  final EDAlgorithmType algorithmType;

  const SubstrateHDWallet({
    required super.address,
    required super.walletConfig,
    required super.privateKey,
    required super.publicKey,
    required this.algorithmType,
  });

  static Future<SubstrateHDWallet> fromUri({
    required String secretUri,
    required SubstrateWalletConfig walletConfig,
    EDAlgorithmType algorithmType = EDAlgorithmType.sr25519,
  }) async {
    SubstrateDerivationPath substrateDerivationPath = SubstrateDerivationPath.fromUri(secretUri);

    ABip32PrivateKey privateKey = await walletConfig.derivator.derivePath(substrateDerivationPath);
    ABip32PublicKey publicKey = privateKey.publicKey;

    String address = walletConfig.addressEncoder.encodePublicKey(publicKey);

    return SubstrateHDWallet(
      address: address,
      walletConfig: walletConfig,
      privateKey: privateKey,
      publicKey: publicKey,
      algorithmType: algorithmType,
    );
  }
}
