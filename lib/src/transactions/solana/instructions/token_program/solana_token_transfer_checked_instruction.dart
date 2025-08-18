import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which transfers a token identified as [mint] from a [source] associated account to a [destination] associated account.
class SolanaTokenTransferCheckedInstruction extends ASolanaInstructionDecoded {
  final int _amount;
  final String _authority;
  final int _decimals;
  final String _destination;
  final String _mint;
  final String _source;

  const SolanaTokenTransferCheckedInstruction({
    required int amount,
    required String authority,
    required int decimals,
    required String destination,
    required String mint,
    required String programId,
    required String source,
  })  : _amount = amount,
        _authority = authority,
        _decimals = decimals,
        _destination = destination,
        _mint = mint,
        _source = source,
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
      amount: amount,
      authority: authority,
      decimals: decimals,
      destination: destination,
      mint: mint,
      programId: programId,
      source: source,
    );
  }

  @override
  int? get amount => _amount;

  @override
  String? get authority => _authority;

  @override
  int? get decimals => _decimals;

  @override
  String? get destination => _destination;

  @override
  String? get mint => _mint;

  @override
  String? get source => _source;

  @override
  List<Object?> get props => <Object?>[programId, _amount, _authority, _decimals, _destination, _source, _mint];
}
