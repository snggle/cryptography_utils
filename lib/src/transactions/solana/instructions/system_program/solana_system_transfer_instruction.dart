import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which transfers [lamports] (SOL) from [source] to [destination].
class SolanaSystemTransferInstruction extends ASolanaInstructionDecoded {
  final String _source;
  final String _destination;
  final BigInt _lamports;

  const SolanaSystemTransferInstruction({
    required String programId,
    required String source,
    required String destination,
    required BigInt lamports,
  })  : _source = source,
        _destination = destination,
        _lamports = lamports,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSystemTransferInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String source = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String destination = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();

    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    BigInt lamports = BigInt.from(byteData.getUint64(4, Endian.little));

    return SolanaSystemTransferInstruction(
      programId: programId,
      source: source,
      destination: destination,
      lamports: lamports,
    );
  }

  @override
  String? get source => _source;

  @override
  String? get destination => _destination;

  @override
  BigInt? get lamports => _lamports;

  @override
  List<Object?> get props => <Object?>[programId, _source, _destination, _lamports];
}
