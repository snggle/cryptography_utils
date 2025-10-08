import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// Raydium Concentrated Liquidity: swap_v2
/// Example instruction: https://solscan.io/tx/bnT38LGCawfbxKzrcQWsuM2H1uTyu8BBdsanFc5PrEmfmEj3GvyJBuGuGPMnvNgr7N4ADNqKB66ZwTi726E2fnf
class SolanaSwapRaydiumV2Instruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _amount;
  final BigInt _otherAmountThreshold;
  final BigInt _sqrtPriceLimitX64;
  final bool _isBaseInput;

  const SolanaSwapRaydiumV2Instruction({
    required String programId,
    required String signer,
    required BigInt amount,
    required BigInt otherAmountThreshold,
    required BigInt sqrtPriceLimitX64,
    required bool isBaseInput,
  })  : _signer = signer,
        _amount = amount,
        _otherAmountThreshold = otherAmountThreshold,
        _sqrtPriceLimitX64 = sqrtPriceLimitX64,
        _isBaseInput = isBaseInput,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSwapRaydiumV2Instruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader byteReader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(8);

    Uint8List amountBytes = byteReader.shiftRightBy(8);
    BigInt amount = BigInt.from(ByteData.sublistView(amountBytes).getUint64(0, Endian.little));

    Uint8List otherAmountThresholdBytes = byteReader.shiftRightBy(8);
    BigInt otherAmountThreshold = BigInt.from(ByteData.sublistView(otherAmountThresholdBytes).getUint64(0, Endian.little));

    // TODO(kamil): 16 -> U64 / U128
    Uint8List sqrtPriceLimitX64Bytes = byteReader.shiftRightBy(16);
    BigInt sqrtPriceLimitX64 = BigInt.from(ByteData.sublistView(sqrtPriceLimitX64Bytes).getUint64(0, Endian.little));

    bool isBaseInput = byteReader.shiftRight() == 1;

    print('Decoded Raydium Concentrated Liquidity: swap_v2 instruction:');
    int tag = solanaCompiledInstruction.data[0];
    print('  tag: $tag');
    print('  signer: $signer');
    print('  amount: $amount');
    print('  otherAmountTreshold: $otherAmountThreshold');
    print('  sqrtPriceLimitX64: $sqrtPriceLimitX64');
    print('  isBaseInput: $isBaseInput');

    return SolanaSwapRaydiumV2Instruction(
      programId: programId,
      signer: signer,
      amount: amount,
      otherAmountThreshold: otherAmountThreshold,
      sqrtPriceLimitX64: sqrtPriceLimitX64,
      isBaseInput: isBaseInput,
    );
  }

  @override
  String get signer => _signer;

  @override
  BigInt? get amount => _amount;

  @override
  BigInt? get otherAmountThreshold => _otherAmountThreshold;

  @override
  BigInt? get sqrtPriceLimitX64 => _sqrtPriceLimitX64;

  @override
  bool get isBaseInput => _isBaseInput;

  @override
  List<Object?> get props => <Object?>[programId, _signer, _amount, _otherAmountThreshold, _sqrtPriceLimitX64, _isBaseInput];
}
