import 'package:cryptography_utils/cryptography_utils.dart';

/// Delegate a stake to a particular vote account
///
/// https://docs.rs/solana-sdk/latest/solana_sdk/stake/instruction/enum.StakeInstruction.html#variant.DelegateStake
class SolanaStakeDelegateInstruction extends ASolanaInstructionDecoded {
  final String _recipient;
  final String _sender;

  const SolanaStakeDelegateInstruction({
    required String programId,
    required String recipient,
    required String sender,
  })  : _recipient = recipient,
        _sender = sender,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeDelegateInstruction] from the serialized data.
  static SolanaStakeDelegateInstruction fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String recipient = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String sender = accountKeys[solanaCompiledInstruction.accounts[5]].toBase58();
    return SolanaStakeDelegateInstruction(
      programId: programId,
      recipient: recipient,
      sender: sender,
    );
  }

  @override
  String? get recipient => _recipient;

  @override
  String? get sender => _sender;

  @override
  List<Object?> get props => <Object?>[programId, recipient, sender];
}
