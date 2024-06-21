import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_array_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_int_type.dart';

/// Dart representation of the Solidity's dynamic array type used in the ABI (Application Binary Interface) encoding.
/// Variable-length array (<type>[]) of elements of the given type.
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityDynamicArrayType extends ASolidityArrayType {
  /// The length of the array.
  int? length;

  SolidityDynamicArrayType(String name, [List<AbiParamDefinition>? components]) : super(name, components);

  /// Returns the canonical name of the Solidity type.
  @override
  String get canonicalName => '${elementType.canonicalName}[]';

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  List<dynamic> decode(List<int> encoded, int offset) {
    length = SolidityIntType.decodeInt(encoded, offset).toInt();
    return decodeTuple(encoded, offset + ASolidityType.segmentBytesSize, length!);
  }

  /// Returns the fixed size of the Solidity type.
  @override
  int get fixedSize {
    if (length == null) {
      throw Exception('Length is not calculated yet');
    }
    return length! * elementType.fixedSize + ASolidityType.segmentBytesSize;
  }
}
