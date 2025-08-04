import 'package:cryptography_utils/cryptography_utils.dart';

class InvalidInstruction extends ASolanaInstructionDecoded {
  final String programIdString;

  const InvalidInstruction({this.programIdString = ''});

  @override
  String get programId {
    return programIdString;
  }

  @override
  List<Object?> get props => <Object?>[programId];
}
