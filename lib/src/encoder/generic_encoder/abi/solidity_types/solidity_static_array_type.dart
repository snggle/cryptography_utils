import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_array_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';

/// Dart representation of the Solidity's fixed array type used in the ABI (Application Binary Interface) encoding.
/// Fixed-length array (<type>[M]) of M elements, M >= 0, of the given type.
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityStaticArrayType extends ASolidityArrayType {
  /// The size of the array.
  late final int size;

  SolidityStaticArrayType(String name, [List<AbiParamDefinition>? components]) : super(name, components) {
    int arrayLengthStartIndex = name.lastIndexOf('[');
    int arrayLengthEndIndex = name.lastIndexOf(']');
    String sizeString = name.substring(arrayLengthStartIndex + 1, arrayLengthEndIndex);
    size = int.parse(sizeString);
  }

  /// Returns the canonical name of the Solidity type.
  @override
  String get canonicalName => '${elementType.canonicalName}[$size]';

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  List<dynamic> decode(List<int> encoded, int offset) {
    return decodeTuple(encoded, offset, size);
  }

  /// Returns the fixed size of the Solidity type.
  @override
  int get fixedSize => hasDynamicSize ? ASolidityType.segmentBytesSize : size * elementType.fixedSize;

  /// Indicates whether the Solidity type has a dynamic size.
  @override
  bool get hasDynamicSize => elementType.hasDynamicSize && size > 0;
}
