import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';

class SolanaInstruction {
  final int programIdIndex;
  final List<int> accountIndices;
  final Uint8List data;

  const SolanaInstruction({
    required this.programIdIndex,
    required this.accountIndices,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'programIdIndex': programIdIndex,
      'accountIndices': accountIndices,
      'data': Base58Codec.encode(data),
    };
  }
}