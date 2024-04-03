import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which defines a specific unit price in “micro-lamports” to pay a higher transaction fee for higher transaction prioritization.
class SolanaComputeBudgetSetComputeUnitPriceInstruction extends ASolanaInstructionDecoded {
  final int _discriminator;
  final int _microLamports;

  const SolanaComputeBudgetSetComputeUnitPriceInstruction({
    required String programId,
    required int discriminator,
    required int microLamports,
  })  : _discriminator = discriminator,
        _microLamports = microLamports,
        super(programId: programId);

  /// Creates a new instance of [SolanaComputeBudgetSetComputeUnitPriceInstruction] from the serialized data.
  factory SolanaComputeBudgetSetComputeUnitPriceInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int discriminator = byteData.getUint8(0);
    int microLamports = byteData.getUint64(1, Endian.little);

    return SolanaComputeBudgetSetComputeUnitPriceInstruction(
      programId: programId,
      discriminator: discriminator,
      microLamports: microLamports,
    );
  }

  @override
  int? get discriminator => _discriminator;

  @override
  int? get microLamports => _microLamports;

  @override
  List<Object?> get props => <Object?>[programId, _discriminator, _microLamports];
}
