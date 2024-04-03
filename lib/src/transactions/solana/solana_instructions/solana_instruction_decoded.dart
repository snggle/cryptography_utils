import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_instructions/solana_instruction_type.dart';

class SolanaInstructionDecoded {
  final SolanaInstructionType type;
  final String programId;
  final String? from;
  final String? to;
  final String? signer;
  final int? amount;
  final int? amountLamports;
  final String? error;
  final int? decimals;
  final String? mint;
  final int? baseFee;
  final int? heapFrameBytes;
  final String? tokenProgram;
  final String? associatedProgram;

  const SolanaInstructionDecoded({
    required this.type,
    required this.programId,
    this.from,
    this.to,
    this.signer,
    this.amount,
    this.amountLamports,
    this.error,
    this.decimals,
    this.mint,
    this.baseFee,
    this.heapFrameBytes,
    this.tokenProgram,
    this.associatedProgram,
  });
}