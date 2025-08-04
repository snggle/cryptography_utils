import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class SystemTransferInstruction extends ASolanaInstructionDecoded {
  final String programIdString;
  final int? amountInt;
  final String? recipientString;
  final String? senderString;

  const SystemTransferInstruction({
    required this.programIdString,
    this.amountInt,
    this.recipientString,
    this.senderString,
  });

  static SystemTransferInstruction fromSerializedData(SolanaInstructionRaw solanaInstructionRaw, List<Uint8List> accountKeys, String programId) {
    ByteData byteData = solanaInstructionRaw.data.buffer.asByteData();
    int amount = byteData.getUint64(4, Endian.little);
    String sender = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[0]]);
    String recipient = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[1]]);
    return SystemTransferInstruction(
      amountInt: amount,
      programIdString: programId,
      recipientString: recipient,
      senderString: sender,
    );
  }

  @override
  int? get amount => amountInt;

  @override
  String? get programId => programIdString;

  @override
  String? get recipient => recipientString;

  @override
  String? get sender => senderString;

  @override
  List<Object?> get props => <Object?>[programId, amount, sender, recipient];
}
