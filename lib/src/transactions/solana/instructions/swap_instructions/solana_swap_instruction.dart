import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction representing a token swap
class SolanaSwapInstruction extends ASolanaInstructionDecoded {
  final String _associatedProgram;
  final String _signer;
  final String _tokenProgram;
  final String _recipient;
  final String _sender;

  const SolanaSwapInstruction({
    required String programId,
    required String associatedProgram,
    required String signer,
    required String tokenProgram,
    required String recipient,
    required String sender,
  })  : _associatedProgram = associatedProgram,
        _signer = signer,
        _tokenProgram = tokenProgram,
        _recipient = recipient,
        _sender = sender,
        super(programId: programId);

  /// Creates a new instance of [SolanaSwapInstruction] from the serialized data.
  static SolanaSwapInstruction fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String sender = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String recipient = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    String signer = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();
    String associatedProgram = accountKeys[solanaCompiledInstruction.accounts[4]].toBase58();
    String tokenProgram = accountKeys[solanaCompiledInstruction.accounts[5]].toBase58();
    return SolanaSwapInstruction(
      associatedProgram: associatedProgram,
      programId: programId,
      signer: signer,
      tokenProgram: tokenProgram,
      recipient: recipient,
      sender: sender,
    );
  }

  @override
  String? get associatedProgram => _associatedProgram;

  @override
  String? get recipient => _recipient;

  @override
  String? get sender => _sender;

  @override
  String? get signer => _signer;

  String? get tokenProgram => _tokenProgram;

  @override
  List<Object?> get props => <Object?>[
        associatedProgram,
        programId,
        recipient,
        sender,
        signer,
        tokenProgram,
      ];
}
