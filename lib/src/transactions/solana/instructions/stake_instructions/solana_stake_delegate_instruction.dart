import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which delegates a stake to a particular vote account.
class SolanaStakeDelegateInstruction extends ASolanaInstructionDecoded {
  final String _stakeAccount;
  final String _stakeAuthority;

  const SolanaStakeDelegateInstruction({
    required String programId,
    required String stakeAccount,
    required String stakeAuthority,
  })  : _stakeAccount = stakeAccount,
        _stakeAuthority = stakeAuthority,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeDelegateInstruction] from the serialized data.
  factory SolanaStakeDelegateInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String stakeAccount = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String stakeAuthority = accountKeys[solanaCompiledInstruction.accounts[5]].toBase58();
    return SolanaStakeDelegateInstruction(
      programId: programId,
      stakeAccount: stakeAccount,
      stakeAuthority: stakeAuthority,
    );
  }

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  String? get stakeAuthority => _stakeAuthority;

  @override
  List<Object?> get props => <Object?>[programId, _stakeAccount, _stakeAuthority];
}
