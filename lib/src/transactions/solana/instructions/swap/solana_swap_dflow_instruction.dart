import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// DFlow Aggregator v4: swap2
/// Example instruction: https://solscan.io/tx/3oYyb1D1icSn5HayrFQJKNuVg7A3fZaizPwWYXPyde2Qvz46E9YLjR6pgZgWSFpNc55D11WqT2wQj3HrpWEVyyDA
class SolanaSwapDFlowInstruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _quotedOutAmount;
  final int _slippageBps;
  final int _platformFeeBps;
  final int _positiveSlippageFeeLimitPct;

  const SolanaSwapDFlowInstruction({
    required String programId,
    required String signer,
    required BigInt quotedOutAmount,
    required int slippageBps,
    required int platformFeeBps,
    required int positiveSlippageFeeLimitPct,
  })  : _signer = signer,
        _quotedOutAmount = quotedOutAmount,
        _slippageBps = slippageBps,
        _platformFeeBps = platformFeeBps,
        _positiveSlippageFeeLimitPct = positiveSlippageFeeLimitPct,
        super(programId: programId);

  factory SolanaSwapDFlowInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader byteReader = ByteReader(Uint8List.fromList(solanaCompiledInstruction.data));

    Uint8List discriminator = byteReader.shiftRightBy(8);
    Uint8List actionsLenBytes = byteReader.shiftRightBy(4);
    int actionsCount = ByteData.sublistView(actionsLenBytes).getUint32(0, Endian.little);

    int totalLen = solanaCompiledInstruction.data.length;
    int tailOffset = totalLen - 13;

    ByteData tailBD = ByteData.sublistView(solanaCompiledInstruction.data);
    int quotedOutAmount = tailBD.getUint64(tailOffset, Endian.little);
    int slippageBps = tailBD.getUint16(tailOffset + 8, Endian.little);
    int platformFeeBps = tailBD.getUint16(tailOffset + 10, Endian.little);
    int positiveSlippageFeeLimitPct = tailBD.getUint8(tailOffset + 12);

    print('Decoded DFlow Swap2Params:');
    print('  discriminator: ${discriminator.map((int b) => b.toRadixString(16).padLeft(2, "0")).join()}');
    print('  signer: $signer');
    print('  actionsCount: $actionsCount');
    print('  quotedOutAmount: $quotedOutAmount');
    print('  slippageBps: $slippageBps');
    print('  platformFeeBps: $platformFeeBps');
    print('  positiveSlippageFeeLimitPct: $positiveSlippageFeeLimitPct');

    return SolanaSwapDFlowInstruction(
      programId: programId,
      signer: signer,
      quotedOutAmount: BigInt.from(quotedOutAmount),
      slippageBps: slippageBps,
      platformFeeBps: platformFeeBps,
      positiveSlippageFeeLimitPct: positiveSlippageFeeLimitPct,
    );
  }

  @override
  String get signer => _signer;

  @override
  BigInt get quotedOutAmount => _quotedOutAmount;

  @override
  int get slippageBps => _slippageBps;

  @override
  int get platformFeeBps => _platformFeeBps;

  @override
  int get positiveSlippageFeeLimitPct => _positiveSlippageFeeLimitPct;

  @override
  List<Object?> get props => <Object?>[programId, _signer, _quotedOutAmount, _slippageBps, _platformFeeBps, _positiveSlippageFeeLimitPct];
}
