import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class TokenTransferInstruction extends ASolanaInstructionDecoded {
  final String programIdString;
  final int? amountInt;
  final String? mintString;
  final String? recipientString;
  final String? senderString;
  final String? signerString;
  final int? tokenDecimalPrecisionInt;

  const TokenTransferInstruction({
    required this.programIdString,
    this.amountInt,
    this.mintString,
    this.recipientString,
    this.senderString,
    this.signerString,
    this.tokenDecimalPrecisionInt,
  });

  static TokenTransferInstruction fromSerializedData(SolanaInstructionRaw solanaInstructionRaw, List<Uint8List> accountKeys, String programId) {
    ByteData byteData = solanaInstructionRaw.data.buffer.asByteData();
    int amount = byteData.getUint64(1, Endian.little);
    int decimals = byteData.getUint8(9);
    String from = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[0]]);
    String mint = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[1]]);
    String to = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[2]]);
    String signer = Base58Codec.encode(accountKeys[solanaInstructionRaw.accountIndices[3]]);
    return TokenTransferInstruction(
      programIdString: programId,
      senderString: from,
      recipientString: to,
      signerString: signer,
      mintString: mint,
      amountInt: amount,
      tokenDecimalPrecisionInt: decimals,
    );
  }

  @override
  String get programId {
    return programIdString;
  }

  @override
  int? get amount {
    return amountInt;
  }

  @override
  String? get mint {
    return mintString;
  }

  @override
  String? get recipient {
    return recipientString;
  }

  @override
  String? get sender {
    return senderString;
  }

  @override
  String? get signer {
    return signerString;
  }

  @override
  int? get tokenDecimalPrecision {
    return tokenDecimalPrecisionInt;
  }

  @override
  List<Object?> get props => <Object?>[programId, amount, tokenDecimalPrecision, recipient, sender, signer, mint];
}
