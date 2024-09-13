import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/a_solidity_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_int_type.dart';

/// Dart representation of the Solidity's [tuple] type used in the ABI (Application Binary Interface) encoding.
/// (T1,T2,...,Tn): tuple consisting of the types T1, …, Tn, n >= 0
///
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityTupleType extends ASolidityType {
  /// The list of types in the tuple.
  final List<AbiParamDefinition> components;

  SolidityTupleType(this.components) : super('tuple');

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  Map<String, dynamic> decode(List<int> encoded, int offset) {
    Map<String, dynamic> decodedParams = <String, dynamic>{};
    int localOffset = offset;

    for (AbiParamDefinition abiParamDefinition in components) {
      dynamic decodedValue = abiParamDefinition.type.hasDynamicSize
          ? abiParamDefinition.type.decode(encoded, SolidityIntType.decodeInt(encoded, localOffset).toInt())
          : abiParamDefinition.type.decode(encoded, localOffset);

      decodedParams[abiParamDefinition.name] = decodedValue;
      localOffset += abiParamDefinition.type.fixedSize;
    }

    return decodedParams;
  }

  /// Returns the canonical name of the Solidity type.
  @override
  String get canonicalName => '(${components.map((AbiParamDefinition abiParamDefinition) => abiParamDefinition.type.canonicalName).join(',')})';

  /// Returns the fixed size of the Solidity type.
  @override
  int get fixedSize {
    if (hasDynamicSize) {
      return super.fixedSize;
    } else {
      List<int> allSizes = components.map((AbiParamDefinition e) => e.type.fixedSize).toList();
      return allSizes.fold(0, (int previousValue, int element) => previousValue + element);
    }
  }

  /// Indicates whether the Solidity type has a dynamic size.
  @override
  bool get hasDynamicSize => components.any((AbiParamDefinition paramDefinition) => paramDefinition.type.hasDynamicSize);
}
