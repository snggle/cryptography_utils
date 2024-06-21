import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

class SolidityIntType extends ASolidityType {
  final bool keepSegmentSizeBool;

  SolidityIntType(String name, {this.keepSegmentSizeBool = true}) : super(name);

  static BigInt decodeInt(List<int> encoded, int offset, {int segmentSize = ASolidityType.segmentBytesSize}) {
    print('Decode int at offset: $offset');
    return BigIntUtils.decode(encoded.sublist(offset, min(offset + segmentSize, encoded.length)));
  }

  @override
  dynamic decode(List<int> encoded, int offset) {
    return decodeInt(encoded, offset, segmentSize: segmentBytesSize).toString();
  }

  @override
  String getCanonicalName() {
    if (name == 'int') {
      return 'int256';
    } else if (name == 'uint') {
      return 'uint256';
    }
    return super.getCanonicalName();
  }

  int get segmentBytesSize {
    String canonicalName = getCanonicalName();
    if (keepSegmentSizeBool || canonicalName == 'int256' || canonicalName == 'uint256') {
      return ASolidityType.segmentBytesSize;
    }

    String bitsSizeString = canonicalName.replaceFirst('uint', '').replaceFirst('int', '');
    int bitsSize = int.parse(bitsSizeString);
    return keepSegmentSizeBool ? ASolidityType.segmentBytesSize : bitsSize ~/ 8;
  }
}
