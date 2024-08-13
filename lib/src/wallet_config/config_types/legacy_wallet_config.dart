import 'package:cryptography_utils/cryptography_utils.dart';

class LegacyWalletConfig<T extends ABip32PrivateKey> extends AWalletConfig {
  final CurveType curveType;

  const LegacyWalletConfig({
    required ALegacyDerivator<T> derivator,
    required super.addressEncoder,
    required this.curveType,
  }) : super(derivator: derivator);

  @override
  ALegacyDerivator<T> get derivator => super.derivator as ALegacyDerivator<T>;

  @override
  List<Object?> get props => <Object>[derivator.serializeType(), addressEncoder.serializeType(), curveType];
}
