import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which deactivates the [stakeAccount] belonging to a [stakeAuthority].
class SolanaStakeDeactivateInstruction extends ASolanaInstructionDecoded {
  final String _stakeAccount;
  final String _stakeAuthority;

  const SolanaStakeDeactivateInstruction({
    required String programId,
    required String stakeAuthority,
    required String stakeAccount,
  })  : _stakeAuthority = stakeAuthority,
        _stakeAccount = stakeAccount,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeDeactivateInstruction] from the serialized data.
  factory SolanaStakeDeactivateInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String stakeAccount = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String stakeAuthority = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();
    return SolanaStakeDeactivateInstruction(
      programId: programId,
      stakeAuthority: stakeAuthority,
      stakeAccount: stakeAccount,
    );
  }

  @override
  String? get stakeAuthority => _stakeAuthority;

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  List<Object?> get props => <Object?>[programId, stakeAuthority, stakeAccount];
}
