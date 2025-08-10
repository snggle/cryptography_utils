import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Transfer lamports
///
/// https://docs.rs/solana-sdk/latest/solana_sdk/system_instruction/enum.SystemInstruction.html#variant.Transfer
class SolanaSystemTransferInstruction extends ASolanaInstructionDecoded {
  final String _recipient;
  final String _sender;
  final int? _amount;

  const SolanaSystemTransferInstruction({
    required String programId,
    required String recipient,
    required String sender,
    int? amount,
  })  : _amount = amount,
        _recipient = recipient,
        _sender = sender,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  static SolanaSystemTransferInstruction fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int amount = byteData.getUint64(4, Endian.little);
    String sender = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String recipient = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    return SolanaSystemTransferInstruction(
      amount: amount,
      programId: programId,
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
  List<Object?> get props => <Object?>[programId, amount, sender, recipient];
}
