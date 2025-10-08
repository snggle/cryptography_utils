import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// Raydium Liquidity Pool V4: raydium:swap
/// Example instruction: https://solscan.io/tx/4gPBAabppvhnWro2hCgM9AhrbHSCNuvtQcYZCXbuviLTL3XwpSFAjrLnE16uatUd3Em97dGh1EVt1JFR6nreCfFV
class SolanaSwapRaydiumInstruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _amountIn;
  final BigInt _minimumAmountOut;

  const SolanaSwapRaydiumInstruction({
    required String programId,
    required String signer,
    required BigInt amountIn,
    required BigInt minimumAmountOut,
  })  : _signer = signer,
        _amountIn = amountIn,
        _minimumAmountOut = minimumAmountOut,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSwapRaydiumInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader byteReader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(1);

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

    return SolanaSwapRaydiumInstruction(
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
