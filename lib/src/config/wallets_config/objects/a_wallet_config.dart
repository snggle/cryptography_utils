import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class AWalletConfig extends Equatable {
  final IDerivator derivator;

  const AWalletConfig({
    required this.derivator,
  });

  @override
  List<Object?> get props => <Object>[derivator];
}
