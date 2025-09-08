import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which defines a specific unit price in “micro-lamports” to pay a higher transaction fee for higher transaction prioritization.
///
/// Example instruction: https://solscan.io/tx/4uyy2M3xF7swQH6ZFbhxfSFLRARqGQMUi65ikzCzcaGWmKR81vubvPcrEQ4yPhaj7MYw3hBow7w9jnFREMDXyfTs?cluster=devnet
/// {
///     discriminator: {
///         type: "u8",
///         data: 3
///     }
///     microLamports: {
///         type: "u32",
///         data: 20000000
///     }
/// }

class SolanaComputeBudgetUnitPriceInstruction extends ASolanaInstructionDecoded {
  final int _discriminator;
  final int _microLamports;

  const SolanaComputeBudgetUnitPriceInstruction({
    required String programId,
    required int discriminator,
    required int microLamports,
  })  : _discriminator = discriminator,
        _microLamports = microLamports,
        super(programId: programId);

  /// Creates a new instance of [SolanaComputeBudgetUnitPriceInstruction] from the serialized data.
  factory SolanaComputeBudgetUnitPriceInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int discriminator = byteData.getUint8(0);
    int microLamports = byteData.getUint64(1, Endian.little);

    return SolanaComputeBudgetUnitPriceInstruction(
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
