import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// OKX DEX: Aggregation Router V2: swap_tob_v3
/// Example instruction: https://solscan.io/tx/4ViHzFCCdS1s7NLdKQjFLS1YAENffgL67M9WwrdB24Ss2obsbMwyarxwZ2CEY2J9HYKXDcdMAuB3p3mveRkcdWyG
class SolanaSwapOkxTob3Instruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _amountIn;
  final BigInt _expectAmountOut;
  final BigInt _minReturn;

  const SolanaSwapOkxTob3Instruction({
    required String programId,
    required String signer,
    required BigInt amountIn,
    required BigInt expectAmountOut,
    required BigInt minReturn,
  })  : _signer = signer,
        _amountIn = amountIn,
        _expectAmountOut = expectAmountOut,
        _minReturn = minReturn,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSwapOkxTob3Instruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader byteReader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(8);

    Uint8List amountInBytes = byteReader.shiftRightBy(8);
    BigInt amountIn = BigInt.from(ByteData.sublistView(amountInBytes).getUint64(0, Endian.little));

    Uint8List expectAmountOutBytes = byteReader.shiftRightBy(8);
    BigInt expectAmountOut = BigInt.from(ByteData.sublistView(expectAmountOutBytes).getUint64(0, Endian.little));

    // TODO(kamil): 16 -> U64 / U128
    Uint8List minReturnBytes = byteReader.shiftRightBy(16);
    BigInt minReturn = BigInt.from(ByteData.sublistView(minReturnBytes).getUint64(0, Endian.little));

    print('Decoded Raydium Concentrated Liquidity: swap_v2 instruction:');
    int tag = solanaCompiledInstruction.data[0];
    print('  tag: $tag');
    print('  signer: $signer');
    print('  amountIn: $amountIn');
    print('  expectedAmountOut: $expectAmountOut');
    print('  minReturn: $minReturn');

    return SolanaSwapOkxTob3Instruction(
      programId: programId,
      signer: signer,
      amountIn: amountIn,
      expectAmountOut: expectAmountOut,
      minReturn: minReturn,
    );
  }

  @override
  String get signer => _signer;

  @override
  BigInt? get amountIn => _amountIn;

  @override
  BigInt? get expectAmountOut => _expectAmountOut;

  @override
  BigInt? get minReturn => _minReturn;

  @override
  List<Object?> get props => <Object?>[programId, _signer, _amountIn, _expectAmountOut, _minReturn];
}
