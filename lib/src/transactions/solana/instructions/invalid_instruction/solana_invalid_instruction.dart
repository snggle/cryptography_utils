import 'package:cryptography_utils/cryptography_utils.dart';

/// An invalid instruction, created when programId cannot be defined
class SolanaInvalidInstruction extends ASolanaInstructionDecoded {
  const SolanaInvalidInstruction({
    String programId = '',
  }) : super(programId: programId);

  @override
  List<Object?> get props => <Object?>[programId];
}
