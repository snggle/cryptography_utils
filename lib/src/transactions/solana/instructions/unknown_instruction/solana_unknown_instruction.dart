import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction of an unknown type which cannot be decoded
class SolanaUnknownInstruction extends ASolanaInstructionDecoded {
  const SolanaUnknownInstruction({
    required String programId,
  }) : super(programId: programId);

  /// Creates a new instance of [SolanaUnknownInstruction] from the serialized data with the unknown [programId].
  factory SolanaUnknownInstruction.fromSerializedData(String programId) {
    return SolanaUnknownInstruction(programId: programId);
  }

  @override
  List<Object?> get props => <Object?>[programId];
}
