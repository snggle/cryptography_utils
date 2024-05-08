import 'package:cryptography_utils/cryptography_utils.dart';

class LegacyWalletConfig<T extends IBip32PrivateKey> extends AWalletConfig {
  final int coinIndex;
  final CurveType curveType;
  final BipProposalType purpose;

  const LegacyWalletConfig({
    required ILegacyDerivator<T> derivator,
    required super.addressEncoder,
    required this.coinIndex,
    required this.curveType,
    required this.purpose,
  }) : super(derivator: derivator);

  @override
  ILegacyDerivator<T> get derivator => super.derivator as ILegacyDerivator<T>;

  String get baseDerivationPath => "m/${purpose.proposalNumber}'/$coinIndex'";

  @override
  List<Object?> get props => <Object>[derivator, coinIndex, curveType, purpose];
}
