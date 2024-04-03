import 'dart:core';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/instructions/solana_program_type.dart';
import 'package:cryptography_utils/src/utils/solana_utils.dart';
import 'package:equatable/equatable.dart';

/// Abstract base class representing a decoded Solana instruction.
abstract class ASolanaInstructionDecoded extends Equatable {
  static const int solDecimalPrecision = 9;
  final String _programId;

  /// Creates a new decoded Solana instruction with the given [programId].
  const ASolanaInstructionDecoded({required String programId}) : _programId = programId;

  /// Decodes a [SolanaCompiledInstruction] into the appropriate [ASolanaInstructionDecoded] subclass based on the program ID and data.
  factory ASolanaInstructionDecoded.decode(SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys) {
    if (accountKeys.isEmpty || solanaInstruction.programIdIndex >= accountKeys.length) {
      return const SolanaInvalidInstruction();
    }

    /// Program id identifies the program that processes the instruction. It is also the program's address on Solana blockchain.
    /// The address is stored in account keys list, and its position on the list is indicated by [programIdIndex] in the [SolanaCompiledInstruction].
    /// Program id is similar to Contract Address on Ethereum chain.
    /// Examples in switch case below.
    String programId = accountKeys[solanaInstruction.programIdIndex].toBase58();
    SolanaProgramType? solanaProgramType = SolanaProgramType.fromProgramId(programId);
    switch (solanaProgramType) {
      case SolanaProgramType.system:
        return _decodeSystemProgram(solanaInstruction, accountKeys, programId);
      case SolanaProgramType.token:
        return _decodeTokenProgram(solanaInstruction, accountKeys, programId);
      case SolanaProgramType.computeBudget:
        return _decodeComputeBudgetProgram(solanaInstruction, accountKeys, programId);
      case SolanaProgramType.stake:
        return _decodeStakeProgram(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  /// Returns the amount of lamports or token in a transaction in a human-readable form.
  TokenAmount? getAmount() {
    if (lamports != null) {
      return _getAmountLamports(lamports!);
    }

    if (amount != null && decimals != null) {
      return _getAmountToken(amount!, decimals ?? 0);
    }

    return null;
  }

  /// Returns the base58-encoded address of the [mint] if it exists within an instruction.
  String? getMintAddress() {
    return mint;
  }

  /// Returns the base58-encoded address of the transaction sender if it exists within an instruction.
  /// Various instructions use different field names to represent a sender.
  /// For a single instruction, only one of these values will be non-null at the same time.
  String? getSenderAddress() {
    return source ?? (lamports != null ? stakeAccount : stakeAuthority ?? staker);
  }

  /// Returns the base58-encoded address of the transaction recipient if it exists within an instruction.
  /// Various instructions use different field names to represent a recipient.
  /// For a single instruction, only one of these values will be non-null at the same time.
  String? getRecipientAddress() {
    return destination ?? stakeAccount ?? newAccount;
  }

  /// Returns the base58-encoded address of the transaction signer if it exists within an instruction.
  /// Various instructions use different field names to represent a signer.
  /// For a single instruction, only one of these values will be non-null at the same time.
  String? getSignerAddress() {
    return authority ?? stakeAuthority ?? withdrawAuthority ?? staker ?? source;
  }

  /// The Base58-encoded associated account address in a [SolanaCreateIdempotentInstruction].
  String? get account => null;

  /// The amount of tokens in a [SolanaTokenTransferCheckedInstruction].
  BigInt? get amount => null;

  /// The Base58-encoded transaction authority account address in a [SolanaTokenTransferCheckedInstruction].
  String? get authority => null;

  /// The Base58-encoded account address used as a base for generating an associated account address with [seed].
  /// Practically equal to [source] in [SolanaSystemAccountSeedInstruction] when used for creating a new Stake account.
  String? get base => null;

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

  /// The [discriminator] is the first piece of data within instruction's data array.
  /// It is used to differentiate between instruction types belonging to the same program id.
  int? get discriminator => null;

  /// The epoch value used in a [SolanaStakeInitializeInstruction].
  int? get epoch => null;

  /// The amount of lamports (SOL) in a [SolanaSystemTransferInstruction] or a [SolanaStakeWithdrawInstruction].
  BigInt? get lamports => null;

  /// The compute unit price in micro-lamports in a [SolanaComputeBudgetUnitPriceInstruction].
  int? get microLamports => null;

  /// The Base58-encoded token mint address in a [SolanaTokenTransferCheckedInstruction].
  String? get mint => null;

  /// The Base58-encoded address of a new associated account created in a [SolanaSystemAccountSeedInstruction] for storing a stake.
  String? get newAccount => null;

  /// The Base58-encoded address of the owner program account.
  String? get owner => null;

  /// The Base58-encoded unique identifier of the Solana program that an instruction uses.
  String? get programId => _programId;

  /// The Base58-encoded rent sysvar program address used in a [SolanaStakeInitializeInstruction].
  String? get rentSysvar => null;

  /// String of ASCII chars, no longer than `Address::MAX_SEED_LEN`, used to generate [newAccount] in [SolanaSystemAccountSeedInstruction].
  String? get seed => null;

  /// The Base58-encoded transaction source account address used in a [SolanaSystemTransferInstruction],
  /// [SolanaTokenTransferCheckedInstruction], or a [SolanaCreateIdempotentInstruction].
  String? get source => null;

  /// The number of bytes of memory to allocate in [newAccount] without funding
  int? get space => null;

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

  /// The compute unit limit in a [SolanaComputeBudgetUnitLimitInstruction].
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
    int discriminator = solanaInstruction.data[0];
    switch (discriminator) {
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
    int discriminator = solanaInstruction.data[0];
    switch (discriminator) {
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
    int discriminator = solanaInstruction.data[0];
    switch (discriminator) {
      case 2:
        return SolanaSystemTransferInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 3:
        return SolanaSystemAccountSeedInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  /// Decodes a Token Program instruction.
  static ASolanaInstructionDecoded _decodeTokenProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int discriminator = solanaInstruction.data[0];
    switch (discriminator) {
      case 12:
        return SolanaTokenTransferCheckedInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  /// Returns the amount of lamports in a transaction in a human-readable form.
  TokenAmount _getAmountLamports(BigInt lamports) {
    if (lamports == BigInt.zero) {
      return TokenAmount.fromBigInt(denomination: SolanaUtils.solSymbol, amount: lamports);
    }
    return TokenAmount(
      denomination: SolanaUtils.solSymbol,
      amount: SolanaUtils.parseTokenAmount(lamports, solDecimalPrecision),
    );
  }

  /// Returns the token amount in a transaction in a human-readable form.
  TokenAmount _getAmountToken(BigInt amount, int decimals) {
    if (amount == BigInt.zero) {
      return TokenAmount.fromBigInt(denomination: '', amount: amount);
    }
    return TokenAmount(
      denomination: '',
      amount: SolanaUtils.parseTokenAmount(amount, decimals),
    );
  }
}
