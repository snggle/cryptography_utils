import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

class ComputeBudgetUnitPriceInstruction extends ASolanaInstructionDecoded {
  final String programIdString;
  final int? unitPriceInt;

  const ComputeBudgetUnitPriceInstruction({
    required this.programIdString,
    this.unitPriceInt,
  });

  static ComputeBudgetUnitPriceInstruction fromSerializedData(SolanaInstructionRaw solanaInstructionRaw, String programId) {
    ByteData byteData = solanaInstructionRaw.data.buffer.asByteData();
    int unitPrice = byteData.getUint64(1, Endian.little);
    return ComputeBudgetUnitPriceInstruction(
      unitPriceInt: unitPrice,
      programIdString: programId,
    );
  }

  @override
  String? get programId => programIdString;

  @override
  int? get unitPrice => unitPriceInt;

  @override
  List<Object?> get props => <Object?>[unitPrice, programId];
}
