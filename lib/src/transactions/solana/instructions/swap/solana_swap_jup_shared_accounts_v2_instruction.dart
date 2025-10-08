import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// Jupiter Aggregator v6: shared_accounts_route_v2
/// Example instruction: https://solscan.io/tx/3w8rNNgWVBDsJ565PseZkuekVWtTBVbvZWy4MmuzKtXeVXJafhRMS2awwUfoaj8JTBdf5qcUc6SVogEby7XFFvQA
class SolanaSwapJupSharedAccountsV2Instruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _inAmount;
  final BigInt _quotedOutAmount;
  final int _slippageBps;
  final int _platformFeeBps;
  final int _positiveSlippageBps;

  const SolanaSwapJupSharedAccountsV2Instruction({
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
  factory SolanaSwapJupSharedAccountsV2Instruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader reader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(9);

    Uint8List inAmountBytes = reader.shiftRightBy(8);
    int inAmount = ByteData.sublistView(inAmountBytes).getUint64(0, Endian.little);

    Uint8List quotedOutAmountBytes = reader.shiftRightBy(8);
    int quotedOutAmount = ByteData.sublistView(quotedOutAmountBytes).getUint64(0, Endian.little);

    Uint8List slippageBytes = reader.shiftRightBy(2);
    int slippageBps = ByteData.sublistView(slippageBytes).getUint16(0, Endian.little);

    Uint8List platformFeeBpsBytes = reader.shiftRightBy(2);
    int platformFeeBps = ByteData.sublistView(platformFeeBpsBytes).getUint16(0, Endian.little);

    Uint8List positiveSlippageBpsBytes = reader.shiftRightBy(2);
    int positiveSlippageBps = ByteData.sublistView(positiveSlippageBpsBytes).getUint16(0, Endian.little);

    print('Decoded Jupiter v6 shared_accounts_route instruction:');
    int tag = solanaCompiledInstruction.data[0];
    int dataLength = solanaCompiledInstruction.data.length;
    int currentOffset = reader.offset;
    print('  data length: $dataLength, offset: $currentOffset');
    print('  tag: $tag');
    print('  signer: $signer');
    print('  inAmount: $inAmount');
    print('  quotedOutAmount: $quotedOutAmount');
    print('  slippageBps: $slippageBps');
    print('  platformFeeBps: $platformFeeBps');
    print('  positiveSlippageBps: $positiveSlippageBps');

    return SolanaSwapJupSharedAccountsV2Instruction(
      programId: programId,
      signer: signer,
      inAmount: BigInt.from(inAmount),
      quotedOutAmount: BigInt.from(quotedOutAmount),
      slippageBps: slippageBps,
      platformFeeBps: platformFeeBps,
      positiveSlippageBps: positiveSlippageBps,
    );
  }

  @override
  String get signer => _signer;

  @override
  BigInt get inAmount => _inAmount;

  @override
  BigInt get quotedOutAmount => _quotedOutAmount;

  @override
  int get slippageBps => _slippageBps;

  @override
  int get platformFeeBps => _platformFeeBps;

  @override
  int get positiveSlippageBps => _positiveSlippageBps;

  @override
  List<Object?> get props => <Object?>[programId, _signer, _inAmount, _quotedOutAmount, _slippageBps, _platformFeeBps, _positiveSlippageBps];
}
