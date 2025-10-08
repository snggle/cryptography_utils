import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// Jupiter Aggregator v6: route_v2
/// Example instruction: https://solscan.io/tx/39GPttca38zVA1iGbPsv8Njy2FGXwZFSZKhxbfFTByHpChVuU1skUkN9ZYEk157dGeg2ub7tqdXRwhaBR2pyosMa
class SolanaSwapJupRouteV2Instruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _inAmount;
  final BigInt _quotedOutAmount;
  final int _slippageBps;
  final int _platformFeeBps;
  final int _positiveSlippageBps;

  const SolanaSwapJupRouteV2Instruction({
    required String programId,
    required String signer,
    required BigInt inAmount,
    required BigInt quotedOutAmount,
    required int slippageBps,
    required int platformFeeBps,
    required int positiveSlippageBps,
  })  : _signer = signer,
        _inAmount = inAmount,
        _quotedOutAmount = quotedOutAmount,
        _slippageBps = slippageBps,
        _platformFeeBps = platformFeeBps,
        _positiveSlippageBps = positiveSlippageBps,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSwapJupRouteV2Instruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader byteReader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(8);

    Uint8List inAmountBytes = byteReader.shiftRightBy(8);
    BigInt inAmount = BigInt.from(ByteData.sublistView(inAmountBytes).getUint64(0, Endian.little));

    Uint8List quotedOutAmountBytes = byteReader.shiftRightBy(8);
    BigInt quotedOutAmount = BigInt.from(ByteData.sublistView(quotedOutAmountBytes).getUint64(0, Endian.little));

    Uint8List slippageBpsBytes = byteReader.shiftRightBy(2);
    int slippageBps = ByteData.sublistView(slippageBpsBytes).getUint16(0, Endian.little);

    Uint8List platformFeeBpsBytes = byteReader.shiftRightBy(2);
    int platformFeeBps = ByteData.sublistView(platformFeeBpsBytes).getUint16(0, Endian.little);

    Uint8List positiveSlippageBpsBytes = byteReader.shiftRightBy(2);
    int positiveSlippageBps = ByteData.sublistView(positiveSlippageBpsBytes).getUint16(0, Endian.little);

    print('Decoded Raydium Concentrated Liquidity: swap_v2 instruction:');
    int tag = solanaCompiledInstruction.data[0];
    print('  tag: $tag');
    print('  signer: $signer');
    print('  inAmount: $inAmount');
    print('  quotedOutAmount: $quotedOutAmount');
    print('  slippageBps: $slippageBps');
    print('  platformFeeBps: $platformFeeBps');
    print('  positiveSlippageBps: $positiveSlippageBps');

    return SolanaSwapJupRouteV2Instruction(
      programId: programId,
      signer: signer,
      inAmount: inAmount,
      quotedOutAmount: quotedOutAmount,
      slippageBps: slippageBps,
      platformFeeBps: platformFeeBps,
      positiveSlippageBps: positiveSlippageBps,
    );
  }

  @override
  String get signer => _signer;

  @override
  BigInt? get inAmount => _inAmount;

  @override
  BigInt? get quotedOutAmount => _quotedOutAmount;

  @override
  int get slippageBps => _slippageBps;

  @override
  int get platformFeeBps => _platformFeeBps;

  @override
  int get positiveSlippageBps => _positiveSlippageBps;

  @override
  List<Object?> get props => <Object?>[programId, _signer, _inAmount, _quotedOutAmount, _slippageBps, _platformFeeBps, _positiveSlippageBps];
}
