import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which transfers a token identified as [mint] from a [source] associated account to a [destination] associated account.
class SolanaTransferCheckedInstruction extends ASolanaInstructionDecoded {
  final int _amount;
  final String _mint;
  final String _destination;
  final String _source;
  final String _authority;
  final int _decimals;

  const SolanaTransferCheckedInstruction({
    required String programId,
    required int amount,
    required String mint,
    required String destination,
    required String source,
    required String authority,
    required int decimals,
  })  : _amount = amount,
        _mint = mint,
        _destination = destination,
        _source = source,
        _authority = authority,
        _decimals = decimals,
        super(programId: programId);

  /// Creates a new instance of [SolanaTransferCheckedInstruction] from the serialized data.
  factory SolanaTransferCheckedInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int amount = byteData.getUint64(1, Endian.little);
    int decimals = byteData.getUint8(9);
    String source = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String mint = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    String destination = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();
    String authority = accountKeys[solanaCompiledInstruction.accounts[3]].toBase58();
    return SolanaTransferCheckedInstruction(
      programId: programId,
      source: source,
      destination: destination,
      authority: authority,
      mint: mint,
      amount: amount,
      decimals: decimals,
    );
  }

  @override
  int? get amount => _amount;

  @override
  String? get mint => _mint;

  @override
  String? get destination => _destination;

  @override
  String? get source => _source;

  @override
  String? get authority => _authority;

  @override
  int? get decimals => _decimals;

  @override
  List<Object?> get props => <Object?>[programId, amount, decimals, destination, source, authority, mint];
}
