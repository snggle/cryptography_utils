import 'package:cryptography_utils/cryptography_utils.dart';

class SubstrateWalletConfig extends AWalletConfig {
  const SubstrateWalletConfig({
    required ASubstrateDerivator<ABip32PrivateKey> super.derivator,
    required super.addressEncoder,
  });

  @override
  ASubstrateDerivator<ABip32PrivateKey> get derivator => super.derivator as ASubstrateDerivator<ABip32PrivateKey>;

  @override
  List<Object?> get props => <Object>[addressEncoder, derivator];
}
