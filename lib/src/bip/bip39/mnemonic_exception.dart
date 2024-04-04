import 'package:cryptography_utils/src/bip/bip39/mnemonic_exception_type.dart';
import 'package:equatable/equatable.dart';

class MnemonicException extends Equatable implements Exception {
  final MnemonicExceptionType mnemonicExceptionType;

  const MnemonicException(this.mnemonicExceptionType);

  @override
  List<Object?> get props => <Object?>[mnemonicExceptionType];
}
