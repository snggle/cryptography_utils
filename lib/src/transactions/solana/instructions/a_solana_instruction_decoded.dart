import 'dart:core';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// Abstract base class representing a decoded Solana instruction.
abstract class ASolanaInstructionDecoded extends Equatable {
  /// The unique identifier of the Solana program that an instruction uses
  final String _programId;

  /// Creates a new decoded Solana instruction with the given [programId].
  const ASolanaInstructionDecoded({required String programId}) : _programId = programId;

  /// Decodes a [SolanaCompiledInstruction] into the appropriate [ASolanaInstructionDecoded] subclass based on the program ID and data.
  /// and returns an appropriate instruction type
  static ASolanaInstructionDecoded decode(SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys) {
    if (accountKeys.isEmpty || solanaInstruction.programIdIndex >= accountKeys.length) {
      return const SolanaInvalidInstruction();
    }

    String programId = accountKeys[solanaInstruction.programIdIndex].toBase58();
    switch (programId) {
      case '11111111111111111111111111111111':
        return _decodeSystemProgram(solanaInstruction, accountKeys, programId);
      case 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA':
        return _decodeTokenProgram(solanaInstruction, accountKeys, programId);
      case 'ComputeBudget111111111111111111111111111111':
        return _decodeComputeBudgetProgram(solanaInstruction, accountKeys, programId);
      case 'Stake11111111111111111111111111111111111111':
        return _decodeStakeProgram(solanaInstruction, accountKeys, programId);
      case 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL':
        return SolanaSwapInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  /// The amount of tokens in the transaction
  int? get amount => null;

  /// The amount of tokens being a result of a swap
  int? get amountSwappedTo => null;

  /// The Base58 encoded associated program ID
  String? get associatedProgram => null;

  /// The token mint address
  String? get mint => null;

  /// The Base58 encoded program ID
  String? get programId => _programId;

  /// The transaction recipient account address
  String? get recipient => null;

  /// The transaction sender account address
  String? get sender => null;

  /// The transaction signer account address
  String? get signer => null;

  /// The token's decimal precision
  int? get tokenDecimalPrecision => null;

  /// The unit limit for compute budget program
  int? get unitLimit => null;

  /// The unit price for compute budget program
  int? get unitPrice => null;

  /// Decodes a Compute Budget Program instruction.
  static ASolanaInstructionDecoded _decodeComputeBudgetProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 2:
        return SolanaComputeBudgetUnitLimitInstruction.fromSerializedData(solanaInstruction, programId);
      case 3:
        return SolanaComputeBudgetUnitPriceInstruction.fromSerializedData(solanaInstruction, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  /// Decodes a Stake Program instruction.
  static ASolanaInstructionDecoded _decodeStakeProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 0:
        return SolanaStakeInitializeInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 2:
        return SolanaStakeDelegateInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 4:
        return SolanaStakeWithdrawInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 5:
        return SolanaStakeDeactivateInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  /// Decodes a System Program instruction.
  static ASolanaInstructionDecoded _decodeSystemProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 2:
        return SolanaSystemTransferInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 3:
        return SolanaSystemAssignInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  /// Decodes a Token Program instruction.
  static ASolanaInstructionDecoded _decodeTokenProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 12:
        return SolanaTokenTransferInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }
}
