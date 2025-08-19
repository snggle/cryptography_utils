import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which transfers a token identified as [mint] from a [source] associated account to a [destination] associated account.
class SolanaTokenTransferCheckedInstruction extends ASolanaInstructionDecoded {
  final String _source;
  final String _mint;
  final String _destination;
  final String _authority;
  final int _amount;
  final int _decimals;

  const SolanaTokenTransferCheckedInstruction({
    required String programId,
    required String source,
    required String mint,
    required String destination,
    required String authority,
    required int amount,
    required int decimals,
  })  : _source = source,
        _mint = mint,
        _destination = destination,
        _authority = authority,
        _amount = amount,
        _decimals = decimals,
        super(programId: programId);

  /// Creates a new instance of [SolanaTokenTransferCheckedInstruction] from the serialized data.
  factory SolanaTokenTransferCheckedInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String source = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String mint = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    String destination = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();
    String authority = accountKeys[solanaCompiledInstruction.accounts[3]].toBase58();

    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int amount = byteData.getUint64(1, Endian.little);
    int decimals = byteData.getUint8(9);

    return SolanaTokenTransferCheckedInstruction(
      programId: programId,
      source: source,
      mint: mint,
      destination: destination,
      authority: authority,
      amount: amount,
      decimals: decimals,
    );
  }

  @override
  String? get source => _source;

  @override
  String? get mint => _mint;

  @override
  String? get destination => _destination;

  @override
  String? get authority => _authority;

  @override
  int? get amount => _amount;

  @override
  int? get decimals => _decimals;

  @override
  List<Object?> get props => <Object?>[programId, _source, _mint, _destination, _authority, _amount, _decimals];
}
