import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_int_type.dart';

/// Dart representation of the Solidity's [bool] type used in the ABI (Application Binary Interface) encoding.
///
/// Equivalent to uint8 restricted to the values 0 and 1. For computing the function selector, bool is used.
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityBoolType extends SolidityIntType {
  SolidityBoolType() : super('bool');

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  bool decode(List<int> encoded, int offset) {
    BigInt numericBoolValue = BigInt.parse(super.decode(encoded, offset) as String);
    return numericBoolValue.toInt() == 1;
  }
}
