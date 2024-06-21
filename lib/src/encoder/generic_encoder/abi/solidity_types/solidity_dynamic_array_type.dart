import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

class SolidityDynamicArrayType extends ASolidityArrayType {
  SolidityDynamicArrayType(String name) : super(name);

  SolidityDynamicArrayType.fromType(ASolidityType elementType) : super.fromType(elementType);

  @override
  String getCanonicalName() {
    return '${elementType.getCanonicalName()}[]';
  }

  @override
  Object decode(List<int> encoded, int offset) {
    int len = SolidityIntType.decodeInt(encoded, offset).toInt();
    return decodeTuple(encoded, offset + ASolidityType.segmentBytesSize, len);
  }

  @override
  bool isDynamicType() {
    return true;
  }
}