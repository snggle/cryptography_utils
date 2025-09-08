import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which defines a specific compute unit limit that the transaction is allowed to consume.
///
/// Example instruction: https://solscan.io/tx/4uyy2M3xF7swQH6ZFbhxfSFLRARqGQMUi65ikzCzcaGWmKR81vubvPcrEQ4yPhaj7MYw3hBow7w9jnFREMDXyfTs?cluster=devnet
/// {
///     discriminator: {
///         type: "u8",
///         data: 2
///     }
///     units: {
///         type: "u32",
///         data: 495
///     }
/// }
class SolanaComputeBudgetUnitLimitInstruction extends ASolanaInstructionDecoded {
  final int _discriminator;
  final int _units;

  const SolanaComputeBudgetUnitLimitInstruction({
    required String programId,
    required int discriminator,
    required int units,
  })  : _discriminator = discriminator,
        _units = units,
        super(programId: programId);

  /// Creates a new instance of [SolanaComputeBudgetUnitLimitInstruction] from the serialized data.
  factory SolanaComputeBudgetUnitLimitInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int discriminator = byteData.getUint8(0);
    int units = byteData.getUint32(1, Endian.little);

    return SolanaComputeBudgetUnitLimitInstruction(
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
