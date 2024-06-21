import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

abstract class ASolidityType {
  static const int segmentBytesSize = 32;
  
  final String name;

  ASolidityType(this.name);

  static ASolidityType getType(String typeName) {
    if (typeName.endsWith(']')) {
      return ASolidityArrayType.getType(typeName);
    }
    if ('bool' == typeName) {
      return BoolType();
    }
    if (typeName.startsWith('int')) {
      return SolidityIntType(typeName);
    }
    if (typeName.startsWith('uint')) {
      return SolidityIntType(typeName);
    }
    if ('address' == typeName) {
      return SolidityAddressType();
    }
    if ('string' == typeName) {
      return SolidityStringType();
    }
    if ('bytes' == typeName) {
      return SolidityBytesType();
    }
    if ('function' == typeName) {
      return SolidityFunctionType();
    }
    if ('tuple' == typeName) {
      return SolidityTupleType();
    }
    if (typeName.startsWith('bytes')) {
      return SolidityBytesType(typeName);
    }
    throw ArgumentError('Unknown type: $typeName');
  }

  dynamic decode(List<int> encoded, int offset);

  String getCanonicalName() {
    return name;
  }

  bool isDynamicType() {
    return false;
  }

  int getFixedSize() {
    return ASolidityType.segmentBytesSize;
  }

  @override
  String toString() {
    return getCanonicalName();
  }
}