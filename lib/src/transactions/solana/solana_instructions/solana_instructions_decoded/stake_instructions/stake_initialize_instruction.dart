import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class StakeInitializeInstruction extends ASolanaInstructionDecoded {
  final String programIdString;
  final String? recipientString;

  const StakeInitializeInstruction({
    required this.programIdString,
    this.recipientString,
  });

  static StakeInitializeInstruction fromSerializedData(SolanaInstructionRaw solanaInstructionRaw, List<Uint8List> accountKeys, String programId) {
    String recipient = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[0]]);
    String programId = Base58Codec.encode(accountKeys[solanaInstructionRaw.programIdIndex]);
    return StakeInitializeInstruction(
      programIdString: programId,
      recipientString: recipient,
    );
  }

  @override
  String? get programId => programIdString;

  @override
  String? get recipient => recipientString;

  @override
  List<Object?> get props => <Object?>[programId, recipient];
}
