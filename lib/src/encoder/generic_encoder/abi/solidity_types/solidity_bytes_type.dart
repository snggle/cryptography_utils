import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

class SolidityBytesType extends ASolidityType {
  SolidityBytesType([String? name]) : super(name ?? 'bytes');

  @override
  bool isDynamicType() => true;

  @override
  dynamic decode(List<int> encoded, int offset) {
    int len = SolidityIntType.decodeInt(encoded, offset).toInt();
    if (len == 0) {
      return Uint8List(0);
    }
    int calculatedOffset = offset + ASolidityType.segmentBytesSize;
    return Uint8List.fromList(encoded.sublist(calculatedOffset, min(calculatedOffset + len, encoded.length)));
  }
}
