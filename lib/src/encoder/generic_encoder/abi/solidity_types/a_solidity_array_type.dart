import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

abstract class ASolidityArrayType extends ASolidityType {
  final ASolidityType elementType;

  ASolidityArrayType(String name)
      : elementType = ASolidityType.getType(name.substring(0, name.lastIndexOf('['))),
        super(name);

  ASolidityArrayType.fromType(this.elementType)
      : super(elementType.name);

  static ASolidityArrayType getType(String typeName) {
    int idx1 = typeName.lastIndexOf('[');
    int idx2 = typeName.lastIndexOf(']');
    if (idx1 + 1 == idx2) {
      return SolidityDynamicArrayType(typeName);
    } else {
      return SolidityStaticArrayType(typeName);
    }
  }

  List<dynamic> decodeTuple(List<int> encoded, int origOffset, int len) {
    int offset = origOffset;

    print('Decode $len elements starting with offset $origOffset');

    List<dynamic> ret = List<dynamic>.filled(len, null, growable: false);

    for (int i = 0; i < len; i++) {
      if (elementType.isDynamicType()) {
        print('Decode dynamic type: ${elementType.name}');
        ret[i] = elementType.decode(encoded, origOffset + SolidityIntType.decodeInt(encoded, offset).toInt());
      } else {
        ret[i] = elementType.decode(encoded, offset);
      }
      offset += elementType.getFixedSize();
    }
    return ret;
  }

  ASolidityType getElementType() {
    return elementType;
  }
}
