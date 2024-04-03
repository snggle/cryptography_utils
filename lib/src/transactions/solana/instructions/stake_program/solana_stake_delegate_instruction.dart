import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which delegates a stake to a particular vote account.
class SolanaStakeDelegateInstruction extends ASolanaInstructionDecoded {
  final String _stakeAccount;
  final String _voteAccount;
  final String _clockSysvar;
  final String _stakeHistorySysvar;
  final String _stakeConfigAccount;
  final String _stakeAuthority;

  const SolanaStakeDelegateInstruction({
    required String programId,
    required String stakeAccount,
    required String voteAccount,
    required String clockSysvar,
    required String stakeHistorySysvar,
    required String stakeConfigAccount,
    required String stakeAuthority,
  })  : _stakeAccount = stakeAccount,
        _voteAccount = voteAccount,
        _clockSysvar = clockSysvar,
        _stakeHistorySysvar = stakeHistorySysvar,
        _stakeConfigAccount = stakeConfigAccount,
        _stakeAuthority = stakeAuthority,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeDelegateInstruction] from the serialized data.
  factory SolanaStakeDelegateInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String stakeAccount = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String voteAccount = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    String clockSysvar = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();
    String stakeHistorySysvar = accountKeys[solanaCompiledInstruction.accounts[3]].toBase58();
    String stakeConfigAccount = accountKeys[solanaCompiledInstruction.accounts[4]].toBase58();
    String stakeAuthority = accountKeys[solanaCompiledInstruction.accounts[5]].toBase58();

    return SolanaStakeDelegateInstruction(
      programId: programId,
      clockSysvar: clockSysvar,
      stakeAccount: stakeAccount,
      stakeAuthority: stakeAuthority,
      stakeConfigAccount: stakeConfigAccount,
      stakeHistorySysvar: stakeHistorySysvar,
      voteAccount: voteAccount,
    );
  }

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  String? get voteAccount => _voteAccount;

  @override
  String? get clockSysvar => _clockSysvar;

  @override
  String? get stakeHistorySysvar => _stakeHistorySysvar;

  @override
  String? get stakeConfigAccount => _stakeConfigAccount;

  @override
  String? get stakeAuthority => _stakeAuthority;

  @override
  List<Object?> get props =>
      <Object?>[programId, _stakeAccount, _voteAccount, _clockSysvar, _stakeHistorySysvar, _stakeConfigAccount, _stakeAuthority];
}
