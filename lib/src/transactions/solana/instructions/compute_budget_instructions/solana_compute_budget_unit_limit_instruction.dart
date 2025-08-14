import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which defines a specific compute unit limit that the transaction is allowed to consume.
class SolanaComputeBudgetUnitLimitInstruction extends ASolanaInstructionDecoded {
  final int _units;

  const SolanaComputeBudgetUnitLimitInstruction({
    required String programId,
    required int units,
  })  : _units = units,
        super(programId: programId);

  /// Creates a new instance of [SolanaComputeBudgetUnitLimitInstruction] from the serialized data.
  factory SolanaComputeBudgetUnitLimitInstruction.fromSerializedData(SolanaCompiledInstruction solanaCompiledInstruction, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int units = byteData.getUint32(1, Endian.little);
    return SolanaComputeBudgetUnitLimitInstruction(
      programId: programId,
      units: units,
    );
  }

  @override
  int? get units => _units;

  @override
  List<Object?> get props => <Object?>[programId, units];
}
