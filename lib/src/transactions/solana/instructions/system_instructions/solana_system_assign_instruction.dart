import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// Assign account to a program
///
/// https://docs.rs/solana-sdk/latest/solana_sdk/system_instruction/enum.SystemInstruction.html#variant.Assign
class SolanaSystemAssignInstruction extends ASolanaInstructionDecoded {
  final String _recipient;
  final String _signer;

  const SolanaSystemAssignInstruction({
    required String programId,
    required String recipient,
    required String signer,
  })  : _recipient = recipient,
        _signer = signer,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemAssignInstruction] from the serialized data.
  static SolanaSystemAssignInstruction fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    Uint8List recipientBytes = solanaCompiledInstruction.data.sublist(4, 36);
    String recipient = Base58Codec.encode(recipientBytes);
    return SolanaSystemAssignInstruction(
      programId: programId,
      recipient: recipient,
      signer: signer,
    );
  }

  @override
  String? get recipient => _recipient;

  @override
  String? get signer => _signer;

  @override
  List<Object?> get props => <Object?>[programId, recipient, signer];
}
