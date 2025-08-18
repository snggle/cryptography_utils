import 'dart:core';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// Abstract base class representing a decoded Solana instruction.
abstract class ASolanaInstructionDecoded extends Equatable {
  final String _programId;

  /// Creates a new decoded Solana instruction with the given [programId].
  const ASolanaInstructionDecoded({required String programId}) : _programId = programId;

  /// Decodes a [SolanaCompiledInstruction] into the appropriate [ASolanaInstructionDecoded] subclass based on the program ID and data.
  factory ASolanaInstructionDecoded.decode(SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys) {
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
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  /// The Base58-encoded associated account address in a [SolanaCreateIdempotentInstruction].
  String? get account => null;

  /// The amount of tokens in a [SolanaTokenTransferCheckedInstruction].
  int? get amount => null;

  /// The Base58-encoded transaction authority account address in a [SolanaTokenTransferCheckedInstruction].
  String? get authority => null;

  /// The Base58-encoded clock sysvar program address used in a
  /// [SolanaStakeDelegateInstruction], [SolanaStakeDeactivateInstruction], or [SolanaStakeWithdrawInstruction].
  String? get clockSysvar => null;

  /// The Base58-encoded stake custodian account address used in a [SolanaStakeInitializeInstruction].
  String? get custodian => null;

  /// The token’s decimal precision in a [SolanaTokenTransferCheckedInstruction].
  int? get decimals => null;

  /// The Base58-encoded transaction destination account address used in a [SolanaSystemTransferInstruction]
  /// or [SolanaTokenTransferCheckedInstruction].
  String? get destination => null;

  /// The tag used in [SolanaComputeBudgetSetComputeUnitPriceInstruction] and [SolanaComputeBudgetSetComputeUnitLimitInstruction]
  /// to differentiate between them.
  int? get discriminator => null;

  /// The epoch value used in a [SolanaStakeInitializeInstruction].
  int? get epoch => null;

  /// The amount of lamports (SOL) in a [SolanaSystemTransferInstruction] or a [SolanaStakeWithdrawInstruction].
  int? get lamports => null;

  /// The compute unit price in micro-lamports in a [SolanaComputeBudgetSetComputeUnitPriceInstruction].
  int? get microLamports => null;

  /// The Base58-encoded token mint address in a [SolanaTokenTransferCheckedInstruction].
  String? get mint => null;

  /// The Base58-encoded unique identifier of the Solana program that an instruction uses.
  String? get programId => _programId;

  /// The Base58-encoded rent sysvar program address used in a [SolanaStakeInitializeInstruction].
  String? get rentSysvar => null;

  /// The Base58-encoded transaction source account address used in a [SolanaSystemTransferInstruction],
  /// [SolanaTokenTransferCheckedInstruction], or a [SolanaCreateIdempotentInstruction].
  String? get source => null;

  /// The Base58-encoded stake account address used in a [SolanaStakeInitializeInstruction], [SolanaStakeDelegateInstruction],
  /// [SolanaStakeDeactivateInstruction], or [SolanaStakeWithdrawInstruction].
  String? get stakeAccount => null;

  /// The Base58-encoded stake authority account address in a [SolanaStakeDelegateInstruction] or a [SolanaStakeDeactivateInstruction],
  /// which owns the associated [stakeAccount].
  String? get stakeAuthority => null;

  /// The Base58-encoded stake config account address used in a [SolanaStakeDelegateInstruction] or [SolanaStakeWithdrawInstruction].
  String? get stakeConfigAccount => null;

  /// The Base58-encoded stake history sysvar program address used in a [SolanaStakeDelegateInstruction] or [SolanaStakeWithdrawInstruction].
  String? get stakeHistorySysvar => null;

  /// The Base58-encoded staker account address used in a [SolanaStakeInitializeInstruction].
  String? get staker => null;

  /// The compute unit limit in a [SolanaComputeBudgetSetComputeUnitLimitInstruction].
  int? get units => null;

  /// The Unix timestamp used in a [SolanaStakeInitializeInstruction].
  int? get unixTimestamp => null;

  /// The Base58-encoded vote account address used in a [SolanaStakeDelegateInstruction].
  String? get voteAccount => null;

  /// The Base58-encoded withdraw authority account address in a [SolanaStakeWithdrawInstruction],
  /// which owns the associated [stakeAccount].
  String? get withdrawAuthority => null;

  /// The Base58-encoded account address with a stake withdraw authority in a [SolanaStakeInitializeInstruction].
  String? get withdrawer => null;

  /// Decodes a Compute Budget Program instruction.
  static ASolanaInstructionDecoded _decodeComputeBudgetProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 2:
        return SolanaComputeBudgetSetComputeUnitLimitInstruction.fromSerializedData(solanaInstruction, programId);
      case 3:
        return SolanaComputeBudgetSetComputeUnitPriceInstruction.fromSerializedData(solanaInstruction, programId);
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
        return SolanaTokenTransferCheckedInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }
}
