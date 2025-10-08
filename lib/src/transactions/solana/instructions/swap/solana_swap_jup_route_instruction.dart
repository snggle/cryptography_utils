import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// Jupiter Aggregator v6: route
/// Example instruction: https://solscan.io/tx/41KuRBj8fkQLYSwVegjjWTJTSa7rm1Lhhb5dU8sSYViPnC6NHQxRqwd1DpiiJJPvF8KLZHWWhbjNSrPKjCgq6f8w
class SolanaSwapJupRouteInstruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _inAmount;
  final BigInt _quotedOutAmount;
  final int _slippageBps;
  final int _platformFeeBps;

  const SolanaSwapJupRouteInstruction({
    required String programId,
    required String signer,
    required BigInt inAmount,
    required BigInt quotedOutAmount,
    required int slippageBps,
    required int platformFeeBps,
  })  : _signer = signer,
        _inAmount = inAmount,
        _quotedOutAmount = quotedOutAmount,
        _slippageBps = slippageBps,
        _platformFeeBps = platformFeeBps,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSwapJupRouteInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader byteReader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(8);

    Uint8List dataLength = byteReader.shiftRightBy(4);
    int actionsCount = ByteData.sublistView(dataLength).getUint32(0, Endian.little);

    byteReader.shiftRightBy(actionsCount * 4);

    Uint8List inAmountBytes = byteReader.shiftRightBy(8);
    BigInt inAmount = BigInt.from(ByteData.sublistView(inAmountBytes).getUint64(0, Endian.little));

    Uint8List quotedOutAmountBytes = byteReader.shiftRightBy(8);
    BigInt quotedOutAmount = BigInt.from(ByteData.sublistView(quotedOutAmountBytes).getUint64(0, Endian.little));

    Uint8List slippageBpsBytes = byteReader.shiftRightBy(2);
    int slippageBps = ByteData.sublistView(slippageBpsBytes).getUint16(0, Endian.little);

    Uint8List platformFeeBpsBytes = byteReader.shiftRightBy(1);
    int platformFeeBps = ByteData.sublistView(platformFeeBpsBytes).getUint8(0);

    print('Decoded Raydium Concentrated Liquidity: swap_v2 instruction:');
    int tag = solanaCompiledInstruction.data[0];
    print('  tag: $tag');
    print('  signer: $signer');
    print('  inAmount: $inAmount');
    print('  quotedOutAmount: $quotedOutAmount');
    print('  slippageBps: $slippageBps');
    print('  platformFeeBps: $platformFeeBps');

    return SolanaSwapJupRouteInstruction(
      programId: programId,
      signer: signer,
      inAmount: inAmount,
      quotedOutAmount: quotedOutAmount,
      slippageBps: slippageBps,
      platformFeeBps: platformFeeBps,
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
  List<Object?> get props => <Object?>[programId, _signer, _inAmount, _quotedOutAmount, _slippageBps, _platformFeeBps];
}
