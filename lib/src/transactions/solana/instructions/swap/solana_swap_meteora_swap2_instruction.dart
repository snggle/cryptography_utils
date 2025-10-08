import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// Meteora Dynamic Bonding Curve Program: swap2
/// Example instruction: https://solscan.io/tx/GG4aFQG2BzadkRXaXnRyCRwCeugiUQE3Wfd2Ushu1CuMZRL2SQDmmVWT3VC9GGVe1ZKJMDsKTLRrjB2WyGqFLna
class SolanaSwapMeteoraSwap2Instruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _amount0;
  final BigInt _amount1;
  final int _swapMode;

  const SolanaSwapMeteoraSwap2Instruction({
    required String programId,
    required String signer,
    required BigInt amount0,
    required BigInt amount1,
    required int swapMode,
  })  : _signer = signer,
        _amount0 = amount0,
        _amount1 = amount1,
        _swapMode = swapMode,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSwapMeteoraSwap2Instruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader byteReader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(8);

    Uint8List amount0Bytes = byteReader.shiftRightBy(8);
    BigInt amount0 = BigInt.from(ByteData.sublistView(amount0Bytes).getUint64(0, Endian.little));

    Uint8List amount1Bytes = byteReader.shiftRightBy(8);
    BigInt amount1 = BigInt.from(ByteData.sublistView(amount1Bytes).getUint64(0, Endian.little));

    // TODO(kamil): bool?
    int swapMode = byteReader.shiftRight();

    print('Decoded Raydium Concentrated Liquidity: swap_v2 instruction:');
    int tag = solanaCompiledInstruction.data[0];
    print('  tag: $tag');
    print('  signer: $signer');
    print('  amount0: $amount0');
    print('  amount1: $amount1');
    print('  swapMode: $swapMode');

    return SolanaSwapMeteoraSwap2Instruction(
      programId: programId,
      signer: signer,
      amount0: amount0,
      amount1: amount1,
      swapMode: swapMode,
    );
  }

  @override
  String get signer => _signer;

  @override
  BigInt? get amount0 => _amount0;

  @override
  BigInt? get amount1 => _amount1;

  @override
  int get swapMode => _swapMode;

  @override
  List<Object?> get props => <Object?>[programId, _signer, _amount0, _amount1, _swapMode];
}
