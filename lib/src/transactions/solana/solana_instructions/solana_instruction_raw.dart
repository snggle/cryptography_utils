import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';

class SolanaInstructionRaw {
  final int programIdIndex;
  final List<int> accountIndices;
  final Uint8List data;

  const SolanaInstructionRaw({
    required this.programIdIndex,
    required this.accountIndices,
    required this.data,
  });

  static SolanaInstructionRaw fromSerializedData(ByteReader byteReader) {
    int programIdIndex = byteReader.shiftRight();
    int accountCount = CompactU16Decoder.decode(byteReader);
    Uint8List accountIndices = byteReader.shiftRightBy(accountCount);
    int dataLength = CompactU16Decoder.decode(byteReader);
    Uint8List instructionData = byteReader.shiftRightBy(dataLength);

    return SolanaInstructionRaw(
      programIdIndex: programIdIndex,
      accountIndices: accountIndices,
      data: instructionData,
    );
  }
}
