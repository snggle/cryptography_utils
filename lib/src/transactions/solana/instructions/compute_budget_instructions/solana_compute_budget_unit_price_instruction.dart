import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Set a compute unit price in “micro-lamports” to pay a higher transaction fee for higher transaction prioritization.
///
/// https://docs.rs/solana-sdk/latest/solana_sdk/compute_budget/enum.ComputeBudgetInstruction.html#variant.SetComputeUnitPrice
class SolanaComputeBudgetUnitPriceInstruction extends ASolanaInstructionDecoded {
  final int _unitPrice;

  const SolanaComputeBudgetUnitPriceInstruction({
    required String programId,
    required int unitPrice,
  })  : _unitPrice = unitPrice,
        super(programId: programId);

  /// Creates a new instance of [SolanaComputeBudgetUnitPriceInstruction] from the serialized data.
  static SolanaComputeBudgetUnitPriceInstruction fromSerializedData(SolanaCompiledInstruction solanaCompiledInstruction, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int unitPrice = byteData.getUint64(1, Endian.little);
    return SolanaComputeBudgetUnitPriceInstruction(
      programId: programId,
      unitPrice: unitPrice,
    );
  }

  @override
  int? get unitPrice => _unitPrice;

  @override
  List<Object?> get props => <Object?>[unitPrice, programId];
}
