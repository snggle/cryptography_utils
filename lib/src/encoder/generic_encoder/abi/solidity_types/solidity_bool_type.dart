import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

class BoolType extends SolidityIntType {
  BoolType() : super('bool');

  @override
  bool decode(List<int> encoded, int offset) {
    return super.decode(encoded, offset) != BigInt.zero;
  }
}
