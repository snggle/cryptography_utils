import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class StakeDeactivateInstruction extends ASolanaInstructionDecoded {
  final String programIdString;
  final String? recipientString;
  final String? senderString;

  const StakeDeactivateInstruction({
    required this.programIdString,
    this.recipientString,
    this.senderString,
  });

  static StakeDeactivateInstruction fromSerializedData(SolanaInstructionRaw solanaInstructionRaw, List<Uint8List> accountKeys, String programId) {
    String sender = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[0]]);
    String recipient = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[2]]);
    return StakeDeactivateInstruction(
      programIdString: programId,
      recipientString: recipient,
      senderString: sender,
    );
  }

  @override
  String? get programId => programIdString;

  @override
  String? get recipient => recipientString;

  @override
  String? get sender => senderString;

  @override
  List<Object?> get props => <Object?>[programId, recipient, sender];
}
