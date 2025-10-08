import 'dart:core';

import 'package:cryptography_utils/cryptography_utils.dart';
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

    String programId = accountKeys[solanaInstruction.programIdIndex].toBase58();
    switch (programId) {
      case '11111111111111111111111111111111':
        return _decodeSystemProgram(solanaInstruction, accountKeys, programId);
      case 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA':
        return _decodeTokenProgram(solanaInstruction, accountKeys, programId);
      case 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL':
        return _decodeAssociatedTokenProgram(solanaInstruction, accountKeys, programId);
      case 'ComputeBudget111111111111111111111111111111':
        return _decodeComputeBudgetProgram(solanaInstruction, accountKeys, programId);
      case 'Stake11111111111111111111111111111111111111':
        return _decodeStakeProgram(solanaInstruction, accountKeys, programId);
      case 'JUP6LkbZbjS1jKKwapdHNy74zcZ3tLUZoi5QNyVTaV4':
        return _decodeJupiterSwapProgram(solanaInstruction, accountKeys, programId);
      case 'DF1ow4tspfHX9JwWJsAb9epbkA8hmpSEAtxXy1V27QBH':
        return _decodeDflowSwapProgram(solanaInstruction, accountKeys, programId);
      case '675kPX9MHTjS2zt1qfr1NYHuzeLXfQM9H24wFSUt1Mp8':
        return _decodeRaydiumLiquiditySwapProgram(solanaInstruction, accountKeys, programId);
      case 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK':
        return _decodeRaydiumConcentratedLiquiditySwapProgram(solanaInstruction, accountKeys, programId);
      case '6m2CDdhRgxpH4WjvdzxAYbGxwdGUz5MziiL5jek2kBma':
        return _decodeOkxDexSwapProgram(solanaInstruction, accountKeys, programId);
      case 'dbcij3LWUppWqq96dh6gJWwBifmcGfLSB5D4DuSMaqN':
        return _decodeMeteoraDynamicBondingSwapProgram(solanaInstruction, accountKeys, programId);
      case 'cpamdpZCGKUy5JxQXB4dcpGPiikHawvSWAd6mEn1sGG':
        return _decodeMeteoraDammSwapProgram(solanaInstruction, accountKeys, programId);
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

    return _getSwapAmount();
  }

  TokenAmount? getSwapExpectedAmountOut() {
    BigInt? actualExpectedAmountOut = quotedOutAmount ?? otherAmountThreshold ?? amount1 ?? expectAmountOut;
    if (actualExpectedAmountOut != null) {
      return _getAmountToken(actualExpectedAmountOut, decimals ?? 0);
    }
    return null;
  }

  TokenAmount? getSwapMinimumAmountOut() {
    BigInt? actualMinimumAmountOut = minimumAmountOut ?? minReturn;
    if (actualMinimumAmountOut != null) {
      return _getAmountToken(actualMinimumAmountOut, decimals ?? 0);
    }
    return null;
  }

  String? getMintAddress() {
    return mint;
  }

  String? getSenderAddress() {
    return source ?? stakeAccount ?? staker;
  }

  String? getRecipientAddress() {
    return destination ?? stakeAccount ?? stakeAuthority;
  }

  String? getSignerAddress() {
    return authority ?? stakeAuthority ?? withdrawAuthority ?? signer;
  }

  String? getSlippagePercentage() {
    if (slippageBps == null) {
      return null;
    }

    double slippagePercentage = slippageBps! / 100.0;
    return '${slippagePercentage.toStringAsFixed(2)}%';
  }

  /// The Base58-encoded associated account address in a [SolanaCreateIdempotentInstruction].
  String? get account => null;

  /// The amount of tokens in a [SolanaTokenTransferCheckedInstruction].
  BigInt? get amount => null;

  /// The Base58-encoded transaction authority account address in a [SolanaTokenTransferCheckedInstruction].
  String? get authority => null;

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

  /// The tag used in [SolanaComputeBudgetUnitPriceInstruction] and [SolanaComputeBudgetUnitLimitInstruction]
  /// to differentiate between them.
  int? get discriminator => null;

  /// The epoch value used in a [SolanaStakeInitializeInstruction].
  int? get epoch => null;

  /// The amount of lamports (SOL) in a [SolanaSystemTransferInstruction] or a [SolanaStakeWithdrawInstruction].
  BigInt? get lamports => null;

  /// The compute unit price in micro-lamports in a [SolanaComputeBudgetUnitPriceInstruction].
  int? get microLamports => null;

  /// The Base58-encoded token mint address in a [SolanaTokenTransferCheckedInstruction].
  String? get mint => null;

  /// The Base58-encoded address of a new associated account created in a [SolanaSystemCreateAccountWithSeedInstruction] for storing a stake.
  String? get newAccount => null;

  ///
  String? get owner => null;

  /// The Base58-encoded unique identifier of the Solana program that an instruction uses.
  String? get programId => _programId;

  /// The Base58-encoded rent sysvar program address used in a [SolanaStakeInitializeInstruction].
  String? get rentSysvar => null;

  /// An indicator used in [SolanaSystemCreateAccountWithSeedInstruction] of how many associated
  String? get seed => null;

  /// The Base58-encoded transaction source account address used in a [SolanaSystemTransferInstruction],
  /// [SolanaTokenTransferCheckedInstruction], or a [SolanaCreateIdempotentInstruction].
  String? get source => null;

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

  ///
  ///
  ///
  BigInt? get quotedOutAmount => null;
  BigInt? get otherAmountThreshold => null;
  BigInt? get amountIn => null;
  BigInt? get expectAmountOut => null;
  BigInt? get minReturn => null;
  BigInt? get minimumAmountOut => null;
  BigInt? get amount0 => null;
  BigInt? get amount1 => null;
  BigInt? get inAmount => null;
  int? get slippageBps => null;
  String? get signer => null;
  BigInt? get sqrtPriceLimitX64 => null;
  String? get systemProgram => null;
  String? get wallet => null;
  String? get tokenProgram => null;
  int? get platformFeeBps => null;
  int? get positiveSlippageBps => null;
  int? get positiveSlippageFeeLimitPct => null;
  int? get swapMode => null;
  bool? get isBaseInput => null;

  static ASolanaInstructionDecoded _decodeAssociatedTokenProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
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

  static ASolanaInstructionDecoded _decodeJupiterSwapProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    print('Suchar: Jupiter Swap tag: $tag');
    switch (tag) {
      case 42:
        return SolanaSwapJupSharedAccountsInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 43:
        return SolanaSwapJupRouteInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 187:
        return SolanaSwapJupRouteV2Instruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 209:
        return SolanaSwapJupSharedAccountsV2Instruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  static ASolanaInstructionDecoded _decodeDflowSwapProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    print('Suchar: DFlow Swap tag: $tag');
    switch (tag) {
      //case 47:
      // TODO(Kamil): Consider implementing WrapSOL
      case 65:
        return SolanaSwapDFlowInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  static ASolanaInstructionDecoded _decodeRaydiumLiquiditySwapProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    print('Suchar: Raydium Liquidity Swap tag: $tag');
    switch (tag) {
      case 9:
        return SolanaSwapRaydiumInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  static ASolanaInstructionDecoded _decodeRaydiumConcentratedLiquiditySwapProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    print('Suchar: Raydium Concentrated Swap tag: $tag');
    switch (tag) {
      case 43:
        return SolanaSwapRaydiumV2Instruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  static ASolanaInstructionDecoded _decodeOkxDexSwapProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    print('Suchar: OKX DEX Swap tag: $tag');
    switch (tag) {
      case 248:
        return SolanaSwapOkxInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 14:
        return SolanaSwapOkxTob3Instruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 240:
        return SolanaSwapOkxV3Instruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  static ASolanaInstructionDecoded _decodeMeteoraDynamicBondingSwapProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    print('Suchar: Meteora Dynamic Swap tag: $tag');
    switch (tag) {
      case 248:
        return SolanaSwapMeteoraSwapInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 65:
        return SolanaSwapMeteoraSwap2Instruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return SolanaUnknownInstruction.fromSerializedData(programId);
    }
  }

  static ASolanaInstructionDecoded _decodeMeteoraDammSwapProgram(
      SolanaCompiledInstruction solanaInstruction, List<SolanaPubKey> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    print('Suchar: Meteora Damm Swap tag: $tag');
    switch (tag) {
      case 248:
        return SolanaSwapMeteoraDammInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
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
        return SolanaSystemCreateAccountWithSeedInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
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

  TokenAmount? _getSwapAmount() {
    BigInt? actualAmount = amount ?? inAmount ?? amountIn ?? amount0;
    if (actualAmount != null) {
      return _getAmountToken(actualAmount, decimals ?? 0);
    }
    return null;
  }
}
