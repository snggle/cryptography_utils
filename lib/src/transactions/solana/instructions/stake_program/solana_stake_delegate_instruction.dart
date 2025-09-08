import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which delegates a stake to a particular vote account.
///
/// Example instruction: https://solscan.io/tx/3nJWhUxPWsEWPDHwcYouu2e5GBRZBBzWS1YS38ENXFY9LL2KHmxWfnfZfTTNZzedZh9HrLPe51rn3h9eTVCAhgpt?cluster=devnet
/// {
///   "info": {
///     "clockSysvar": "SysvarC1ock11111111111111111111111111111111",
///     "stakeAccount": "CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k",
///     "stakeAuthority": "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19",
///     "stakeConfigAccount": "StakeConfig11111111111111111111111111111111",
///     "stakeHistorySysvar": "SysvarStakeHistory1111111111111111111111111",
///     "voteAccount": "FwR3PbjS5iyqzLiLugrBqKSa5EKZ4vK9SKs7eQXtT59f"
///   },
///   "type": "delegate"
/// }
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
