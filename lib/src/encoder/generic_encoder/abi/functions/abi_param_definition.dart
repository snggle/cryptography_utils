import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_tuple_type.dart';
import 'package:equatable/equatable.dart';

/// [AbiParamDefinition] class encapsulates the details of a parameter in
/// the ABI (Application Binary Interface) of an Ethereum contract. This includes
/// the parameter's name, type, internal type, whether it is indexed, and any
/// nested components.
class AbiParamDefinition extends Equatable {
  /// The name of the parameter
  final String name;

  /// The type of the parameter as an instance of [ASolidityType]
  final ASolidityType type;

  /// The internal type of the parameter, if specified.
  final String? internalType;

  /// A boolean indicating whether the parameter is indexed (relevant for event parameters).
  final bool? indexed;

  /// A list of nested [AbiParamDefinition] objects, if the parameter is a complex type.
  final List<AbiParamDefinition>? components;

  /// Constructs an instance of [AbiParamDefinition] with the specified parameters.
  AbiParamDefinition({
    required this.name,
    required this.type,
    this.internalType,
    this.indexed,
    List<AbiParamDefinition>? components,
  }) : components = (components == null && type is SolidityTupleType) ? type.components : components;

  /// Constructs an instance of [AbiParamDefinition] from a JSON object.
  factory AbiParamDefinition.fromJson(Map<String, dynamic> json) {
    List<AbiParamDefinition>? components =
        (json['components'] as List<dynamic>?)?.map((dynamic e) => AbiParamDefinition.fromJson(e as Map<String, dynamic>)).toList();

    return AbiParamDefinition(
      name: json['name'] as String,
      type: ASolidityType.getType(json['type'] as String, components),
      internalType: json['internalType'] as String?,
      indexed: json['indexed'] as bool?,
      components: components,
    );
  }

  @override
  List<Object?> get props => <Object?>[name, type, internalType, indexed, components];
}
