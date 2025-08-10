import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';

/// Set a specific compute unit limit that the transaction is allowed to consume.
///
/// https://docs.rs/solana-sdk/latest/solana_sdk/compute_budget/enum.ComputeBudgetInstruction.html#variant.SetComputeUnitLimit
class SolanaComputeBudgetUnitLimitInstruction extends ASolanaInstructionDecoded {
  final int _unitLimit;

  const SolanaComputeBudgetUnitLimitInstruction({
    required String programId,
    required int unitLimit,
  })  : _unitLimit = unitLimit,
        super(programId: programId);

  /// Creates a new instance of [SolanaComputeBudgetUnitLimitInstruction] from the serialized data.
  static SolanaComputeBudgetUnitLimitInstruction fromSerializedData(
    SolanaCompiledInstruction solanaCompiledInstruction,
    String programId,
  ) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int unitLimit = byteData.getUint32(1, Endian.little);
    return SolanaComputeBudgetUnitLimitInstruction(
      programId: programId,
      unitLimit: unitLimit,
    );
  }

  @override
  int? get unitLimit => _unitLimit;

  @override
  List<Object?> get props => <Object?>[programId, unitLimit];
}
