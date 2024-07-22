import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_dynamic_array_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_int_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_static_array_type.dart';

/// Dart representation of the Solidity's array type used in the ABI (Application Binary Interface) encoding.
/// https://docs.soliditylang.org/en/latest/abi-spec.html
abstract class ASolidityArrayType extends ASolidityType {
  /// The element type of the array.
  final ASolidityType elementType;

  /// Creates an instance of the [ASolidityArrayType] with the given [name] and [components].
  ASolidityArrayType(String name, List<AbiParamDefinition>? components)
      : elementType = ASolidityType.getType(name.substring(0, name.lastIndexOf('[')), components),
        super(name);

  /// Returns the proper [ASolidityArrayType] type for dynamic and static arrays.
  static ASolidityArrayType getType(String typeName, List<AbiParamDefinition>? components) {
    if (typeName.endsWith('[]')) {
      return SolidityDynamicArrayType(typeName, components);
    } else {
      return SolidityStaticArrayType(typeName, components);
    }
  }

  /// Decodes array of [encoded] list of bytes starting from the given [offset] and [length].
  List<dynamic> decodeTuple(List<int> encoded, int offset, int length) {
    int localOffset = offset;
    List<dynamic> result = List<dynamic>.filled(length, null);
    for (int i = 0; i < length; i++) {
      if (elementType.hasDynamicSize) {
        result[i] = elementType.decode(encoded, offset + SolidityIntType.decodeInt(encoded, localOffset).toInt());
      } else {
        result[i] = elementType.decode(encoded, localOffset);
      }
      localOffset += elementType.fixedSize;
    }
    return result;
  }
}
