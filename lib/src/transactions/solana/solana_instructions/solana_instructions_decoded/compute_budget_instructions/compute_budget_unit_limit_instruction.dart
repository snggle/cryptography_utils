import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

class ComputeBudgetUnitLimitInstruction extends ASolanaInstructionDecoded {
  final String programIdString;
  final int? unitLimitInt;

  const ComputeBudgetUnitLimitInstruction({
    required this.programIdString,
    this.unitLimitInt,
  });

  static ComputeBudgetUnitLimitInstruction fromSerializedData(SolanaInstructionRaw solanaInstructionRaw, String programId) {
    ByteData byteData = solanaInstructionRaw.data.buffer.asByteData();
    int unitLimit = byteData.getUint32(1, Endian.little);
    return ComputeBudgetUnitLimitInstruction(
      unitLimitInt: unitLimit,
      programIdString: programId,
    );
  }

  @override
  String? get programId => programIdString;

  @override
  int? get unitLimit => unitLimitInt;

  @override
  List<Object?> get props => <Object?>[unitLimit, programId];
}
