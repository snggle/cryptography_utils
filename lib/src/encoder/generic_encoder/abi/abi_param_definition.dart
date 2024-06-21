import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';
import 'package:equatable/equatable.dart';

class ABIParamDefinition extends Equatable {
  final String name;
  final ASolidityType type;
  final String? internalType;
  final bool? indexed;
  final List<ABIParamDefinition>? components;

  const ABIParamDefinition({
    required this.name,
    required this.type,
    this.internalType,
    this.indexed,
    this.components,
  });

  factory ABIParamDefinition.fromJson(Map<String, dynamic> json) {
    List<ABIParamDefinition>? components = (json['components'] as List<dynamic>?)?.map((dynamic e) => ABIParamDefinition.fromJson(e as Map<String, dynamic>)).toList();

    return ABIParamDefinition(
      name: json['name'] as String,
      type: ASolidityType.getType(json['type'] as String),
      internalType: json['internalType'] as String,
      indexed: json['indexed'] as bool?,
      components: components,
    );
  }

  @override
  List<Object?> get props => <Object?>[name, type, internalType, indexed, components];
}