import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class AWalletConfig extends Equatable {
  final ABlockchainAddressEncoder<dynamic> addressEncoder;
  final ADerivator derivator;

  const AWalletConfig({
    required this.addressEncoder,
    required this.derivator,
  });

  @override
  List<Object?> get props => <Object>[addressEncoder, derivator];
}
