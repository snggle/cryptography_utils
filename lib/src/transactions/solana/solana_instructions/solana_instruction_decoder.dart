import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

extension SolanaInstructionDecoder on SolanaInstruction {
  SolanaInstructionDecoded decode(List<Uint8List> accountKeys) {
    bool isInvalidInstructionBool = accountKeys.isEmpty || programIdIndex >= accountKeys.length;

    if (isInvalidInstructionBool) {
      return const SolanaInstructionDecoded(
        type: SolanaInstructionType.invalidInstruction,
        programId: '',
      );
    }

    String programId = Base58Codec.encode(accountKeys[programIdIndex]);

    switch (programId) {
      case '11111111111111111111111111111111':
        return _decodeSystemProgram(accountKeys, programId);
      case 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA':
        return _decodeTokenProgram(accountKeys, programId);
      case 'ComputeBudget111111111111111111111111111111':
        return _decodeComputeBudgetProgram(accountKeys, programId);
      case 'Stake11111111111111111111111111111111111111':
        return _decodeStakeProgram(accountKeys, programId);
      case 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL':
        return _decodeSwapProgram(accountKeys, programId);
      default:
        return _unknownInstruction(programId);
    }
  }

  String? _accessAccountKeySafe(List<Uint8List> accountKeys, int index) {
    if (accountIndices.length > index && accountIndices[index] < accountKeys.length) {
      return Base58Codec.encode(accountKeys[accountIndices[index]]);
    }
    return null;
  }

  SolanaInstructionDecoded _decodeComputeBudgetProgram(List<Uint8List> accountKeys, String programId) {
    int tag = data[0];
    switch (tag) {
      case 2:
        return _decodeComputeUnitLimit(accountKeys, programId);
      case 3:
        return _decodeComputeUnitPrice(accountKeys, programId);
      default:
        return _unknownInstruction(programId);
    }
  }

  SolanaInstructionDecoded _decodeComputeUnitLimit(List<Uint8List> accountKeys, String programId) {
    ByteData byteData = data.buffer.asByteData();
    int unitLimit = byteData.getUint32(1, Endian.little);
    return SolanaInstructionDecoded(
      type: SolanaInstructionType.computeBudgetUnitLimit,
      programId: programId,
      unitLimit: unitLimit,
    );
  }

  SolanaInstructionDecoded _decodeComputeUnitPrice(List<Uint8List> accountKeys, String programId) {
    ByteData byteData = data.buffer.asByteData();
    int microLamports = byteData.getUint64(1, Endian.little);
    return SolanaInstructionDecoded(
      type: SolanaInstructionType.computeBudgetUnitPrice,
      programId: programId,
      unitPrice: microLamports,
    );
  }

  SolanaInstructionDecoded _decodeStakeDeactivate(List<Uint8List> accountKeys, String programId) {
    String? stakeAccount = _accessAccountKeySafe(accountKeys, 0);
    String? authority = _accessAccountKeySafe(accountKeys, 2);
    return SolanaInstructionDecoded(
      type: SolanaInstructionType.stakeDeactivate,
      programId: programId,
      from: stakeAccount,
      to: authority,
    );
  }

  SolanaInstructionDecoded _decodeStakeDelegate(List<Uint8List> accountKeys, String programId) {
    String? stakeAccount = _accessAccountKeySafe(accountKeys, 0);
    String? authority = _accessAccountKeySafe(accountKeys, 5);
    return SolanaInstructionDecoded(
      type: SolanaInstructionType.stakeDelegate,
      programId: programId,
      to: stakeAccount,
      from: authority,
    );
  }

  SolanaInstructionDecoded _decodeStakeInitialize(List<Uint8List> accountKeys, String programId) {
    String? stakeAccount = _accessAccountKeySafe(accountKeys, 0);
    return SolanaInstructionDecoded(
      type: SolanaInstructionType.stakeInitialize,
      programId: programId,
      to: stakeAccount,
    );
  }

  SolanaInstructionDecoded _decodeStakeProgram(List<Uint8List> accountKeys, String programId) {
    int tag = data[0];
    switch (tag) {
      case 0:
        return _decodeStakeInitialize(accountKeys, programId);
      case 2:
        return _decodeStakeDelegate(accountKeys, programId);
      case 4:
        return _decodeStakeWithdraw(accountKeys, programId);
      case 5:
        return _decodeStakeDeactivate(accountKeys, programId);
      default:
        return _unknownInstruction(programId);
    }
  }

  SolanaInstructionDecoded _decodeStakeWithdraw(List<Uint8List> accountKeys, String programId) {
    ByteData byteData = data.buffer.asByteData();
    int lamports = byteData.getUint64(4, Endian.little);
    String? stakeAccount = _accessAccountKeySafe(accountKeys, 0);
    String? authority = _accessAccountKeySafe(accountKeys, 4);
    return SolanaInstructionDecoded(
      type: SolanaInstructionType.stakeWithdraw,
      programId: programId,
      from: stakeAccount,
      to: authority,
      amount: lamports,
    );
  }

  SolanaInstructionDecoded _decodeSwapProgram(List<Uint8List> accountKeys, String programId) {
    String? source = _accessAccountKeySafe(accountKeys, 0);
    String? destination = _accessAccountKeySafe(accountKeys, 1);
    String? signer = _accessAccountKeySafe(accountKeys, 2);
    String? transactionProgram = _accessAccountKeySafe(accountKeys, 4);
    String? tokenProgram = _accessAccountKeySafe(accountKeys, 5);

    return SolanaInstructionDecoded(
      type: SolanaInstructionType.swap,
      programId: programId,
      from: source,
      to: destination,
      signer: signer,
      associatedProgram: transactionProgram,
      tokenProgram: tokenProgram,
    );
  }

  SolanaInstructionDecoded _decodeSystemAssign(List<Uint8List> accountKeys, String programId) {
    String? account = _accessAccountKeySafe(accountKeys, 0);
    Uint8List newOwnerBytes = data.sublist(4, 36);
    String newOwner = Base58Codec.encode(newOwnerBytes);
    return SolanaInstructionDecoded(
      type: SolanaInstructionType.systemAssign,
      programId: programId,
      to: newOwner,
      signer: account,
    );
  }

  SolanaInstructionDecoded _decodeSystemProgram(List<Uint8List> accountKeys, String programId) {
    int tag = data[0];
    switch (tag) {
      case 2:
        return _decodeSystemTransfer(accountKeys, programId);
      case 3:
        return _decodeSystemAssign(accountKeys, programId);
      default:
        return _unknownInstruction(programId);
    }
  }

  SolanaInstructionDecoded _decodeSystemTransfer(List<Uint8List> accountKeys, String programId) {
    ByteData byteData = data.buffer.asByteData();
    int amount = byteData.getUint64(4, Endian.little);
    String? from = _accessAccountKeySafe(accountKeys, 0);
    String? to = _accessAccountKeySafe(accountKeys, 1);
    return SolanaInstructionDecoded(
      type: SolanaInstructionType.systemTransfer,
      programId: programId,
      from: from,
      to: to,
      amount: amount,
    );
  }

  SolanaInstructionDecoded _decodeTokenApproveChecked(List<Uint8List> accountKeys, String programId) {
    ByteData byteData = data.buffer.asByteData();
    int amount = byteData.getUint64(1, Endian.little);
    int decimals = byteData.getUint8(9);
    String? from = _accessAccountKeySafe(accountKeys, 0);
    String? mint = _accessAccountKeySafe(accountKeys, 1);
    String? to = _accessAccountKeySafe(accountKeys, 2);
    String? signer = _accessAccountKeySafe(accountKeys, 3);
    return SolanaInstructionDecoded(
      type: SolanaInstructionType.tokenTransfer,
      programId: programId,
      from: from,
      to: to,
      signer: signer,
      mint: mint,
      amount: amount,
      tokenDecimalPrecision: decimals,
    );
  }

  SolanaInstructionDecoded _decodeTokenProgram(List<Uint8List> accountKeys, String programId) {
    int tag = data[0];
    switch (tag) {
      case 12:
        return _decodeTokenApproveChecked(accountKeys, programId);
      default:
        return _unknownInstruction(programId);
    }
  }

  SolanaInstructionDecoded _unknownInstruction(String programId) {
    return SolanaInstructionDecoded(type: SolanaInstructionType.unknown, programId: programId);
  }
}
