import 'package:cryptography_utils/cryptography_utils.dart';

class UnknownInstruction extends ASolanaInstructionDecoded {
  final String programIdString;

  const UnknownInstruction({
    required this.programIdString,
  });

  static UnknownInstruction fromSerializedData(String programId) {
    return UnknownInstruction(programIdString: programId);
  }

  @override
  String get programId {
    return programIdString;
  }

  @override
  List<Object?> get props => <Object?>[programId];
}
