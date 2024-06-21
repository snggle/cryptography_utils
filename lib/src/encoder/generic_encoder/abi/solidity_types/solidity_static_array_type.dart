import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

class SolidityStaticArrayType extends ASolidityArrayType {
  late final int size;

  SolidityStaticArrayType(String name) : super(name) {
    int idx1 = name.lastIndexOf('[');
    int idx2 = name.lastIndexOf(']');
    String dim = name.substring(idx1 + 1, idx2);
    size = int.parse(dim);
  }

  @override
  String getCanonicalName() {
    return '${elementType.getCanonicalName()}[$size]';
  }

  @override
  List<dynamic> decode(List<int> encoded, int offset) {
    return decodeTuple(encoded, offset, size);
  }

  @override
  int getFixedSize() {
    if (isDynamicType()) {
      return ASolidityType.segmentBytesSize;
    } else {
      return elementType.getFixedSize() * size;
    }
  }

  @override
  bool isDynamicType() {
    return getElementType().isDynamicType() && size > 0;
  }
}
