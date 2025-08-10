import 'package:cryptography_utils/cryptography_utils.dart';

/// Initialize a stake with lockup and authorization information
///
/// https://docs.rs/solana-sdk/latest/solana_sdk/stake/instruction/enum.StakeInstruction.html#variant.Initialize
class SolanaStakeInitializeInstruction extends ASolanaInstructionDecoded {
  final String _recipient;

  const SolanaStakeInitializeInstruction({
    required String programId,
    required String recipient,
  })  : _recipient = recipient,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeInitializeInstruction] from the serialized data.
  static SolanaStakeInitializeInstruction fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String recipient = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String programId = accountKeys[solanaCompiledInstruction.programIdIndex].toBase58();
    return SolanaStakeInitializeInstruction(
      programId: programId,
      recipient: recipient,
    );
  }

  @override
  String? get recipient => _recipient;

  @override
  List<Object?> get props => <Object?>[programId, recipient];
}
