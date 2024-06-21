import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';

class SolidityFunctionType extends ASolidityType {
  SolidityFunctionType() : super('function');

  @override
  bool isDynamicType() => false;

  @override
  dynamic decode(List<int> encoded, int offset) {
    return null;
  }
}
