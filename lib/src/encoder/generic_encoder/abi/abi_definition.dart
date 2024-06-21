import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';
import 'package:equatable/equatable.dart';

// Rename to AbiDefinitionEntry
class ABIDefinition extends Equatable {
  final String? name;
  final String? type;
  final bool? anonymous;
  final String? stateMutability;
  final List<ABIParamDefinition> inputs;
  final List<ABIParamDefinition> outputs;

  ABIDefinition({
    required this.name,
    this.type,
    this.anonymous,
    this.stateMutability,
    List<ABIParamDefinition>? inputs,
    List<ABIParamDefinition>? outputs,
  })  : inputs = inputs ?? <ABIParamDefinition>[],
        outputs = outputs ?? <ABIParamDefinition>[];

  factory ABIDefinition.fromJson(Map<String, dynamic> json) {
    return ABIDefinition(
      name: json['name'] as String?,
      stateMutability: json['stateMutability'] as String?,
      type: json['type'] as String,
      inputs: (json['inputs'] as List<dynamic>?)?.map((dynamic e) => ABIParamDefinition.fromJson(e as Map<String, dynamic>)).toList(),
      outputs: (json['outputs'] as List<dynamic>?)?.map((dynamic e) => ABIParamDefinition.fromJson(e as Map<String, dynamic>)).toList(),
      anonymous: json['anonymous'] as bool?,
    );
  }

  Map<String, dynamic> decodeParameters(ABIDefinition abiDefinition, List<int> data) {
    Map<String, dynamic> decodedParams = <String, dynamic>{};
    int offset = 0;

    for (int i = 0; i < abiDefinition.inputs.length; i++) {
      if (offset > data.length) {
        break;
      }

      ABIParamDefinition abiInput = abiDefinition.inputs[i];

      print('Start decoding parameters for: ${abiInput.name}');
      dynamic decoded;
      if (abiInput.type.isDynamicType()) {
        print('Decode dynamic type starting from: ${SolidityIntType.decodeInt(data, offset)}');
        decoded = abiInput.type.decode(data, SolidityIntType.decodeInt(data, offset).toInt());
      } else {
        decoded = abiInput.type.decode(data, offset);
      }

      decodedParams[abiInput.name] = decoded;
      offset += abiInput.type.getFixedSize();
    }

    return decodedParams;
  }

  String get functionSelector {
    Uint8List hash = Keccak(256).process(utf8.encode(functionSignature));
    return HexEncoder.encode(hash).substring(0, 8);
  }

  String get functionSignature {
    return '$name(${inputs.map((ABIParamDefinition abiInput) => abiInput.type.name).join(',')})';
  }

  @override
  List<Object?> get props => <Object?>[name, stateMutability, type, inputs, outputs];
}
