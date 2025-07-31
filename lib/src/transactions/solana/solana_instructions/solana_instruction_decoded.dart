import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_instructions/solana_instruction_type.dart';

class SolanaInstructionDecoded {
  final SolanaInstructionType type;
  final String programId;
  final String? from;
  final String? to;
  final String? signer;
  final int? amount;
  final int? amountSwappedTo;
  final int? tokenDecimalPrecision;
  final String? mint;
  final int? unitPrice;
  final int? unitLimit;
  final String? tokenProgram;
  final String? associatedProgram;

  const SolanaInstructionDecoded({
    required this.type,
    required this.programId,
    this.from,
    this.to,
    this.signer,
    this.amount,
    this.amountSwappedTo,
    this.tokenDecimalPrecision,
    this.mint,
    this.unitPrice,
    this.unitLimit,
    this.tokenProgram,
    this.associatedProgram,
  });
}