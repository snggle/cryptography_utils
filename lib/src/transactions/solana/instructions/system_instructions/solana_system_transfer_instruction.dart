import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which transfers [lamports] (SOL) from [source] to [destination].
class SolanaSystemTransferInstruction extends ASolanaInstructionDecoded {
  final String _destination;
  final String _source;
  final int? _lamports;

  const SolanaSystemTransferInstruction({
    required String programId,
    required String destination,
    required String source,
    int? lamports,
  })  : _lamports = lamports,
        _destination = destination,
        _source = source,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSystemTransferInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int lamports = byteData.getUint64(4, Endian.little);
    String source = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String destination = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    return SolanaSystemTransferInstruction(
      lamports: lamports,
      programId: programId,
      destination: destination,
      source: source,
    );
  }

  @override
  int? get lamports => _lamports;

  @override
  String? get destination => _destination;

  @override
  String? get source => _source;

  @override
  List<Object?> get props => <Object?>[programId, _lamports, _source, _destination];
}
