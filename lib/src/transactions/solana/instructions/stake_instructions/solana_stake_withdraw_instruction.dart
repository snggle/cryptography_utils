import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Withdraw unstaked lamports from the stake account
///
/// https://docs.rs/solana-sdk/latest/solana_sdk/stake/instruction/enum.StakeInstruction.html#variant.Withdraw
class SolanaStakeWithdrawInstruction extends ASolanaInstructionDecoded {
  final int _amount;
  final String _recipient;
  final String _sender;

  const SolanaStakeWithdrawInstruction({
    required String programId,
    required int amount,
    required String recipient,
    required String sender,
  })  : _amount = amount,
        _recipient = recipient,
        _sender = sender,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeWithdrawInstruction] from the serialized data.
  static SolanaStakeWithdrawInstruction fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int amount = byteData.getUint64(4, Endian.little);
    String sender = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String recipient = accountKeys[solanaCompiledInstruction.accounts[4]].toBase58();
    return SolanaStakeWithdrawInstruction(
      programId: programId,
      amount: amount,
      recipient: recipient,
      sender: sender,
    );
  }

  @override
  int? get amount => _amount;

  @override
  String? get recipient => _recipient;

  @override
  String? get sender => _sender;

  @override
  List<Object?> get props => <Object?>[programId, amount, recipient, sender];
}
