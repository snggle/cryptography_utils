import 'package:cryptography_utils/cryptography_utils.dart';

class SubstrateWalletConfig extends AWalletConfig {
  const SubstrateWalletConfig({
    required super.addressEncoder,
    required super.derivator,
  });

  @override
  ISubstrateDerivator get derivator => super.derivator as ISubstrateDerivator;

  @override
  List<Object?> get props => <Object>[addressEncoder, derivator];
}
