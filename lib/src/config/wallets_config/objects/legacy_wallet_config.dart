import 'package:cryptography_utils/cryptography_utils.dart';

class LegacyWalletConfig extends AWalletConfig {
  final int coinIndex;
  final CurveType curveType;
  final BipProposalType purpose;

  const LegacyWalletConfig({
    required ILegacyDerivator derivator,
    required this.coinIndex,
    required this.curveType,
    required this.purpose,
  }) : super(derivator: derivator);

  @override
  ILegacyDerivator get derivator => super.derivator as ILegacyDerivator;

  String get baseDerivationPath => "m/${purpose.proposalNumber}'/$coinIndex'";

  @override
  List<Object?> get props => <Object>[derivator, coinIndex, curveType, purpose];
}
