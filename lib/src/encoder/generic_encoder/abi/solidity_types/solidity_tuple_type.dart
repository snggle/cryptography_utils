import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';

/// Dart representation of the Solidity's [tuple] type used in the ABI (Application Binary Interface) encoding.
/// (T1,T2,...,Tn): tuple consisting of the types T1, …, Tn, n >= 0
///
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityTupleType extends ASolidityType {
  /// The list of types in the tuple.
  final List<AbiParamDefinition> types;

  SolidityTupleType(List<AbiParamDefinition> components)
      : types = components,
        super('tuple');

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  Object decode(List<int> encoded, int offset) {
    int calculatedOffset = offset;
    Map<String, dynamic> result = <String, dynamic>{};

    for (AbiParamDefinition paramDefinition in types) {
      if (calculatedOffset > encoded.length) {
        break;
      }
      result[paramDefinition.name] = paramDefinition.type.decode(encoded, calculatedOffset);
      calculatedOffset += paramDefinition.type.fixedSize;
    }
    return result;
  }

  /// Returns the fixed size of the Solidity type.
  @override
  int get fixedSize {
    return types.fold(0, (int sum, AbiParamDefinition paramDefinition) {
      return sum + paramDefinition.type.fixedSize;
    });
  }
}
