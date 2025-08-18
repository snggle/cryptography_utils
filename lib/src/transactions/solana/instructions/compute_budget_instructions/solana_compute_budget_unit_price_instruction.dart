import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which defines a specific unit price in “micro-lamports” to pay a higher transaction fee for higher transaction prioritization.
class SolanaComputeBudgetUnitPriceInstruction extends ASolanaInstructionDecoded {
  final int _microLamports;

  const SolanaComputeBudgetUnitPriceInstruction({
    required String programId,
    required int microLamports,
  })  : _microLamports = microLamports,
        super(programId: programId);

  /// Creates a new instance of [SolanaComputeBudgetUnitPriceInstruction] from the serialized data.
  factory SolanaComputeBudgetUnitPriceInstruction.fromSerializedData(SolanaCompiledInstruction solanaCompiledInstruction, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int microLamports = byteData.getUint64(1, Endian.little);
    return SolanaComputeBudgetUnitPriceInstruction(
      programId: programId,
      microLamports: microLamports,
    );
  }

  @override
  int? get microLamports => _microLamports;

  @override
  List<Object?> get props => <Object?>[programId, _microLamports];
}
