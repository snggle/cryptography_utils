import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which associates a main [wallet] with an [account] which will be used to hold a specific token.
class SolanaCreateIdempotentInstruction extends ASolanaInstructionDecoded {
  final String _systemProgram;
  final String _wallet;
  final String _tokenProgram;
  final String _account;
  final String _source;

  const SolanaCreateIdempotentInstruction({
    required String programId,
    required String systemProgram,
    required String wallet,
    required String tokenProgram,
    required String account,
    required String source,
  })  : _systemProgram = systemProgram,
        _wallet = wallet,
        _tokenProgram = tokenProgram,
        _account = account,
        _source = source,
        super(programId: programId);

  /// Creates a new instance of [SolanaCreateIdempotentInstruction] from the serialized data.
  factory SolanaCreateIdempotentInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String source = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String account = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    String wallet = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();
    String systemProgram = accountKeys[solanaCompiledInstruction.accounts[4]].toBase58();
    String tokenProgram = accountKeys[solanaCompiledInstruction.accounts[5]].toBase58();
    return SolanaCreateIdempotentInstruction(
      systemProgram: systemProgram,
      programId: programId,
      wallet: wallet,
      tokenProgram: tokenProgram,
      account: account,
      source: source,
    );
  }

  @override
  String? get systemProgram => _systemProgram;

  @override
  String? get account => _account;

  @override
  String? get source => _source;

  @override
  String? get wallet => _wallet;

  @override
  String? get tokenProgram => _tokenProgram;

  @override
  List<Object?> get props => <Object?>[
        systemProgram,
        programId,
        account,
        source,
        wallet,
        tokenProgram,
      ];
}
