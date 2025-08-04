import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class SwapInstruction extends ASolanaInstructionDecoded {
  final String programIdString;
  final String? associatedProgramString;
  final String? signerString;
  final String? tokenProgramString;
  final String? recipientString;
  final String? senderString;

  const SwapInstruction({
    required this.programIdString,
    this.associatedProgramString,
    this.signerString,
    this.tokenProgramString,
    this.recipientString,
    this.senderString,
  });

  static SwapInstruction fromSerializedData(SolanaInstructionRaw solanaInstructionRaw, List<Uint8List> accountKeys, String programId) {
    String sender = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[0]]);
    String recipient = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[1]]);
    String signer = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[2]]);
    String associatedProgram = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[4]]);
    String tokenProgram = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[5]]);
    return SwapInstruction(
      associatedProgramString: associatedProgram,
      programIdString: programId,
      signerString: signer,
      tokenProgramString: tokenProgram,
      recipientString: recipient,
      senderString: sender,
    );
  }

  @override
  String? get associatedProgram => associatedProgramString;

  @override
  String? get programId => programIdString;

  @override
  String? get recipient => recipientString;

  @override
  String? get sender => senderString;

  @override
  String? get signer => signerString;

  String? get tokenProgram => tokenProgramString;

  @override
  List<Object?> get props => <Object?>[
        associatedProgram,
        programId,
        recipient,
        sender,
        signer,
        tokenProgram,
      ];
}
