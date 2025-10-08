import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// Jupiter Aggregator v6: shared_accounts_route
/// Example instruction: https://solscan.io/tx/2p7aS3jmsUBuuNAsR82GeYQrpdikHY6xJDaaDRicW5vTU2NtNTwKg8RYJDx3fiJRCFeRHGLeEg4ebhzD36yV7FEh
class SolanaSwapJupSharedAccountsInstruction extends ASolanaInstructionDecoded {
  final String _signer;

  final BigInt _inAmount;
  final BigInt _quotedOutAmount;
  final int _slippageBps;
  final int _platformFeeBps;

  const SolanaSwapJupSharedAccountsInstruction({
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
  factory SolanaSwapJupSharedAccountsInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String signer = accountKeys[0].toBase58();

    ByteReader reader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(8);

    int id = reader.shiftRight();

    Uint8List routeLengthBytes = reader.shiftRightBy(4);
    int routeLength = ByteData.sublistView(routeLengthBytes).getUint32(0, Endian.little);
    reader.shiftRightBy(5 * routeLength);

    Uint8List inAmountBytes = reader.shiftRightBy(8);
    int inAmount = ByteData.sublistView(inAmountBytes).getUint64(0, Endian.little);

    Uint8List quotedOutAmountBytes = reader.shiftRightBy(8);
    int quotedOutAmount = ByteData.sublistView(quotedOutAmountBytes).getUint64(0, Endian.little);

    Uint8List slippageBytes = reader.shiftRightBy(2);
    int slippageBps = ByteData.sublistView(slippageBytes).getUint16(0, Endian.little);

    int platformFeeBps = reader.shiftRight();

    print('Decoded Jupiter v6 shared_accounts_route instruction:');
    int tag = solanaCompiledInstruction.data[0];
    int dataLength = solanaCompiledInstruction.data.length;
    int currentOffset = reader.offset;
    print('  data length: $dataLength, offset: $currentOffset');
    print('  tag: $tag');
    print('  signer: $signer');
    print('  routeLen: $routeLength');
    print('  inAmount: $inAmount');
    print('  quotedOutAmount: $quotedOutAmount');
    print('  slippageBps: $slippageBps');
    print('  platformFeeBps: $platformFeeBps');

    return SolanaSwapJupSharedAccountsInstruction(
      programId: programId,
      signer: signer,
      inAmount: BigInt.from(inAmount),
      quotedOutAmount: BigInt.from(quotedOutAmount),
      slippageBps: slippageBps,
      platformFeeBps: platformFeeBps,
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
  List<Object?> get props => <Object?>[programId, _signer, _inAmount, _quotedOutAmount, _slippageBps, _platformFeeBps];
}
