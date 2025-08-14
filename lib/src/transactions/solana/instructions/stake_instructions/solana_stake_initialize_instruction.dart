import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which initializes a [stakeAccount].
class SolanaStakeInitializeInstruction extends ASolanaInstructionDecoded {
  final String _stakeAccount;

  const SolanaStakeInitializeInstruction({
    required String programId,
    required String stakeAccount,
  })  : _stakeAccount = stakeAccount,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeInitializeInstruction] from the serialized data.
  factory SolanaStakeInitializeInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String stakeAccount = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    return SolanaStakeInitializeInstruction(
      programId: programId,
      stakeAccount: stakeAccount,
    );
  }

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  List<Object?> get props => <Object?>[programId, stakeAccount];
}
