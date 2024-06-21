import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_array_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_int_type.dart';

/// Dart representation of the Solidity's dynamic array type used in the ABI (Application Binary Interface) encoding.
/// Variable-length array (<type>[]) of elements of the given type.
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityDynamicArrayType extends ASolidityArrayType {
  SolidityDynamicArrayType(String name, [List<AbiParamDefinition>? components]) : super(name, components);

  /// Returns the canonical name of the Solidity type.
  @override
  String get canonicalName => '${elementType.canonicalName}[]';

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  List<dynamic> decode(List<int> encoded, int offset) {
    int length = SolidityIntType.decodeInt(encoded, offset).toInt();
    return decodeTuple(encoded, offset + ASolidityType.segmentBytesSize, length);
  }

  /// Indicates whether the Solidity type has a dynamic size.
  @override
  bool get hasDynamicSize => true;
}
