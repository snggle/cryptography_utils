import 'package:cryptography_utils/cryptography_utils.dart';

/// Deactivates the stake in the account
///
/// https://docs.rs/solana-sdk/latest/solana_sdk/stake/instruction/enum.StakeInstruction.html#variant.Deactivate
class SolanaStakeDeactivateInstruction extends ASolanaInstructionDecoded {
  final String _recipient;
  final String _sender;

  const SolanaStakeDeactivateInstruction({
    required String programId,
    required String recipient,
    required String sender,
  })  : _recipient = recipient,
        _sender = sender,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeDeactivateInstruction] from the serialized data.
  static SolanaStakeDeactivateInstruction fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String sender = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String recipient = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();
    return SolanaStakeDeactivateInstruction(
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
