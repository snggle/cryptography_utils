import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class SystemAssignInstruction extends ASolanaInstructionDecoded {
  final String programIdString;
  final String? recipientString;
  final String? signerString;

  const SystemAssignInstruction({
    required this.programIdString,
    this.recipientString,
    this.signerString,
  });

  static SystemAssignInstruction fromSerializedData(SolanaInstructionRaw solanaInstructionRaw, List<Uint8List> accountKeys, String programId) {
    String signer = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[0]]);
    Uint8List recipientBytes = solanaInstructionRaw.data.sublist(4, 36);
    String recipient = Base58Codec.encode(recipientBytes);
    return SystemAssignInstruction(
      programIdString: programId,
      recipientString: recipient,
      signerString: signer,
    );
  }

  @override
  String? get programId => programIdString;

  @override
  String? get recipient => recipientString;

  @override
  String? get signer => signerString;

  @override
  List<Object?> get props => <Object?>[programId, recipient, signer];
}
