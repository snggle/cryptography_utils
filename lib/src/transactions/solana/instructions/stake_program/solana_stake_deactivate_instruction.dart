import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which deactivates the [stakeAccount] belonging to a [stakeAuthority].
///
/// Example instruction: https://solscan.io/tx/4DB2rzhh2KMuRqDu54iW1YWhVMi29cfWnPCXUwWheUbnzaTnyxfHPAyn7jafsFYFPtBpcsFi87ivXcF6LUk8wFJp?cluster=devnet
/// {
///   "info": {
///     "clockSysvar": "SysvarC1ock11111111111111111111111111111111",
///     "stakeAccount": "CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k",
///     "stakeAuthority": "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19"
///   },
///   "type": "deactivate"
/// }
class SolanaStakeDeactivateInstruction extends ASolanaInstructionDecoded {
  final String _stakeAccount;
  final String _clockSysvar;
  final String _stakeAuthority;

  const SolanaStakeDeactivateInstruction({
    required String programId,
    required String stakeAccount,
    required String clockSysvar,
    required String stakeAuthority,
  })  : _stakeAccount = stakeAccount,
        _clockSysvar = clockSysvar,
        _stakeAuthority = stakeAuthority,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeDeactivateInstruction] from the serialized data.
  factory SolanaStakeDeactivateInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String stakeAccount = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String clockSysvar = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    String stakeAuthority = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();

    return SolanaStakeDeactivateInstruction(
      programId: programId,
      stakeAccount: stakeAccount,
      clockSysvar: clockSysvar,
      stakeAuthority: stakeAuthority,
    );
  }

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  String? get clockSysvar => _clockSysvar;

  @override
  String? get stakeAuthority => _stakeAuthority;

  @override
  List<Object?> get props => <Object?>[programId, _stakeAccount, _clockSysvar, _stakeAuthority];
}
