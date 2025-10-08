import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// Meteora DAMM v2: swap
/// Example instruction: https://solscan.io/tx/2p9dPEh8FWnz6doZevGhvDjZA2Ch3dAyotwvyfxAKXYmVAW1XmK7Gg9UtU1R7TgwShmsgcGwhoNckH4X3rtpg6F8
class SolanaSwapMeteoraDammInstruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _amountIn;
  final BigInt _minimumAmountOut;

  const SolanaSwapMeteoraDammInstruction({
    required String programId,
    required String signer,
    required BigInt amountIn,
    required BigInt minimumAmountOut,
  })  : _signer = signer,
        _amountIn = amountIn,
        _minimumAmountOut = minimumAmountOut,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSwapMeteoraDammInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader byteReader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(8);

    Uint8List amountInBytes = byteReader.shiftRightBy(8);
    BigInt amountIn = BigInt.from(ByteData.sublistView(amountInBytes).getUint64(0, Endian.little));

    Uint8List minimumAmountOutBytes = byteReader.shiftRightBy(8);
    BigInt minimumAmountOut = BigInt.from(ByteData.sublistView(minimumAmountOutBytes).getUint64(0, Endian.little));

    print('Decoded Raydium Concentrated Liquidity: swap_v2 instruction:');
    int tag = solanaCompiledInstruction.data[0];
    print('  tag: $tag');
    print('  signer: $signer');
    print('  amountIn: $amountIn');
    print('  minimumAmountOut: $minimumAmountOut');

    return SolanaSwapMeteoraDammInstruction(
      programId: programId,
      signer: signer,
      amountIn: amountIn,
      minimumAmountOut: minimumAmountOut,
    );
  }

  @override
  String get signer => _signer;

  @override
  BigInt? get amountIn => _amountIn;

  @override
  BigInt? get minimumAmountOut => _minimumAmountOut;

  @override
  List<Object?> get props => <Object?>[programId, _signer, _amountIn, _minimumAmountOut];
}
