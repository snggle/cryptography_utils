import 'package:cryptography_utils/src/encoder/generic_encoder/abi/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

class SolidityTupleType extends ASolidityType {
  final List<ABIParamDefinition> types;

  SolidityTupleType({List<ABIParamDefinition>? types})
      : types = types ?? <ABIParamDefinition>[],
        super('tuple');

  @override
  int getFixedSize() {
    if (isDynamicType()) {
      return super.getFixedSize();
    } else {
      return types.fold(0, (int sum, ABIParamDefinition paramDefinition) => sum + paramDefinition.type.getFixedSize());
    }
  }

  @override
  bool isDynamicType() {
    return _containsDynamicTypes();
  }

  @override
  Object decode(List<int> encoded, int offset) {
    print('Start decoding tuple with offset: $offset');
    int calculatedOffset = offset;
    Map<String, dynamic> result = <String, dynamic>{};

    for (int i = 0; i < types.length; i++) {
      ABIParamDefinition paramDefinition = types[i];
      if (calculatedOffset > encoded.length) {
        break;
      }
      if (paramDefinition.type.isDynamicType()) {
        result[paramDefinition.name] = paramDefinition.type.decode(encoded, offset + SolidityIntType.decodeInt(encoded, calculatedOffset).toInt());
      } else {
        result[paramDefinition.name] = paramDefinition.type.decode(encoded, calculatedOffset);
      }
      print('Increment tuple by ${paramDefinition.type.getFixedSize()}');
      calculatedOffset += paramDefinition.type.getFixedSize();
    }
    return result;
  }

  bool _containsDynamicTypes() {
    return types.any((ABIParamDefinition paramDefinition) => paramDefinition.type.isDynamicType());
  }
}
