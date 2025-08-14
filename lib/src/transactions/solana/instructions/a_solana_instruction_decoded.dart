import 'dart:core';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// Abstract base class representing a decoded Solana instruction.
abstract class ASolanaInstructionDecoded extends Equatable {
  final String _programId;

  /// Creates a new decoded Solana instruction with the given [programId].
  const ASolanaInstructionDecoded({required String programId}) : _programId = programId;

  /// Decodes a [SolanaCompiledInstruction] into the appropriate [ASolanaInstructionDecoded] subclass based on the program ID and data.
  /// and returns an appropriate instruction type
  factory ASolanaInstructionDecoded.decode(SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys) {
    if (accountKeys.isEmpty || solanaInstruction.programIdIndex >= accountKeys.length) {
      return const SolanaInvalidInstruction();
    }

    String programId = accountKeys[solanaInstruction.programIdIndex].toBase58();
    switch (programId) {
      case '11111111111111111111111111111111':
        return _decodeSystemProgram(solanaInstruction, accountKeys, programId);
      case 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL':
        return _decodeAssociatedTokenProgram(solanaInstruction, accountKeys, programId);
      case 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA':
        return _decodeTokenProgram(solanaInstruction, accountKeys, programId);
      case 'ComputeBudget111111111111111111111111111111':
        return _decodeComputeBudgetProgram(solanaInstruction, accountKeys, programId);
      case 'Stake11111111111111111111111111111111111111':
        return _decodeStakeProgram(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  /// The amount of a token in a [SolanaTransferCheckedInstruction].
  int? get amount => null;

  /// The Base58 encoded token mint address in a [SolanaTransferCheckedInstruction].
  String? get mint => null;

  /// The Base58 encoded unique identifier of the Solana program that an instruction uses
  String? get programId => _programId;

  /// The Base58 encoded transaction destination account address in a [SolanaSystemTransferInstruction] or a [SolanaTransferCheckedInstruction].
  String? get destination => null;

  /// The Base58 encoded transaction source account address in a [SolanaSystemTransferInstruction], [SolanaTransferCheckedInstruction] or a [SolanaCreateIdempotentInstruction].
  String? get source => null;

  /// The Base58 encoded transaction authority account address in a [SolanaTransferCheckedInstruction].
  String? get authority => null;

  /// The token's decimal precision in a [SolanaTransferCheckedInstruction].
  int? get decimals => null;

  /// The Base58 encoded system program in a [SolanaCreateIdempotentInstruction].
  String? get systemProgram => null;

  /// The Base58 encoded associated account address in a [SolanaCreateIdempotentInstruction].
  String? get account => null;

  /// The Base58 encoded main wallet address in a [SolanaCreateIdempotentInstruction], which owns the associated [account].
  String? get wallet => null;

  /// The Base58 encoded stake authority account address in a [SolanaStakeDelegateInstruction] or a [SolanaStakeDeactivateInstruction], which owns the associated [stakeAccount].
  String? get stakeAuthority => null;

  /// The Base58 encoded stake account address in a [SolanaStakeInitializeInstruction], [SolanaStakeDelegateInstruction], [SolanaStakeDeactivateInstruction] or a [SolanaStakeWithdrawInstruction].
  String? get stakeAccount => null;

  /// The Base58 encoded authority account address in a [SolanaStakeWithdrawInstruction], which owns the associated [stakeAccount].
  String? get withdrawAuthority => null;

  /// The amount of lamports (SOL) in a [SolanaSystemTransferInstruction] or a [SolanaStakeWithdrawInstruction].
  int? get lamports => null;

  /// The Base58 encoded token program id in a [SolanaCreateIdempotentInstruction].
  String? get tokenProgram => null;

  /// The unit limit in a [SolanaComputeBudgetUnitLimitInstruction].
  int? get units => null;

  /// The unit price in a [SolanaComputeBudgetUnitPriceInstruction].
  int? get microLamports => null;

  static ASolanaInstructionDecoded _decodeAssociatedTokenProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    if (solanaInstruction.data.isEmpty) {
      return SolanaUnknownInstruction.fromSerializedData(programId);
    }

    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 1:
        return SolanaCreateIdempotentInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

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
        return SolanaTransferCheckedInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }
}
