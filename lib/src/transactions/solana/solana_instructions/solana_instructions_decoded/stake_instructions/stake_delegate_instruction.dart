import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class StakeDelegateInstruction extends ASolanaInstructionDecoded {
  final String programIdString;
  final String? recipientString;
  final String? senderString;

  const StakeDelegateInstruction({
    required this.programIdString,
    this.recipientString,
    this.senderString,
  });

  static StakeDelegateInstruction fromSerializedData(SolanaInstructionRaw solanaInstructionRaw, List<Uint8List> accountKeys, String programId) {
    String recipient = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[0]]);
    String sender = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[5]]);
    return StakeDelegateInstruction(
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
