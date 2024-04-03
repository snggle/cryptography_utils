import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which defines a specific compute unit limit that the transaction is allowed to consume.
class SolanaComputeBudgetSetComputeUnitLimitInstruction extends ASolanaInstructionDecoded {
  final int _discriminator;
  final int _units;

  const SolanaComputeBudgetSetComputeUnitLimitInstruction({
    required String programId,
    required int discriminator,
    required int units,
  })  : _discriminator = discriminator,
        _units = units,
        super(programId: programId);

  /// Creates a new instance of [SolanaComputeBudgetSetComputeUnitLimitInstruction] from the serialized data.
  factory SolanaComputeBudgetSetComputeUnitLimitInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int discriminator = byteData.getUint8(0);
    int units = byteData.getUint32(1, Endian.little);

    return SolanaComputeBudgetSetComputeUnitLimitInstruction(
      programId: programId,
      discriminator: discriminator,
      units: units,
    );
  }

  @override
  int? get discriminator => _discriminator;

  @override
  int? get units => _units;

  @override
  List<Object?> get props => <Object?>[programId, _discriminator, _units];
}
