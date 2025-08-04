import 'dart:core';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ASolanaInstructionDecoded extends Equatable {
  const ASolanaInstructionDecoded();

  int? get amount => null;

  int? get amountSwappedTo => null;

  String? get associatedProgram => null;

  static ASolanaInstructionDecoded decode(SolanaInstructionRaw solanaInstruction, List<Uint8List> accountKeys) {
    if (accountKeys.isEmpty || solanaInstruction.programIdIndex >= accountKeys.length) {
      return const InvalidInstruction();
    }
    String programId = Base58Codec.encode(accountKeys[solanaInstruction.programIdIndex]);

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
        return SwapInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return UnknownInstruction.fromSerializedData(programId);
    }
  }

  String? get mint => null;

  String? get programId => null;

  String? get recipient => null;

  String? get sender => null;

  String? get signer => null;

  int? get tokenDecimalPrecision => null;

  int? get unitLimit => null;

  int? get unitPrice => null;

  static ASolanaInstructionDecoded _decodeComputeBudgetProgram(
      SolanaInstructionRaw solanaInstruction, List<Uint8List> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 2:
        return ComputeBudgetUnitLimitInstruction.fromSerializedData(solanaInstruction, programId);
      case 3:
        return ComputeBudgetUnitPriceInstruction.fromSerializedData(solanaInstruction, programId);
      default:
        return UnknownInstruction.fromSerializedData(programId);
    }
  }

  static ASolanaInstructionDecoded _decodeStakeProgram(SolanaInstructionRaw solanaInstruction, List<Uint8List> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 0:
        return StakeInitializeInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 2:
        return StakeDelegateInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 4:
        return StakeWithdrawInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 5:
        return StakeDeactivateInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return UnknownInstruction.fromSerializedData(programId);
    }
  }

  static ASolanaInstructionDecoded _decodeSystemProgram(SolanaInstructionRaw solanaInstruction, List<Uint8List> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 2:
        return SystemTransferInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      case 3:
        return SystemAssignInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return UnknownInstruction.fromSerializedData(programId);
    }
  }

  static ASolanaInstructionDecoded _decodeTokenProgram(SolanaInstructionRaw solanaInstruction, List<Uint8List> accountKeys, String programId) {
    int tag = solanaInstruction.data[0];
    switch (tag) {
      case 12:
        return TokenTransferInstruction.fromSerializedData(solanaInstruction, accountKeys, programId);
      default:
        return UnknownInstruction.fromSerializedData(programId);
    }
  }
}
