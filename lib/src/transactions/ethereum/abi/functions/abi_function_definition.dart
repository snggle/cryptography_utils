import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_int_type.dart';
import 'package:equatable/equatable.dart';

/// The [AbiFunctionDefinition] class encapsulates the details of a contract function,
/// including its name, input types, and output types, providing methods to
/// encode and decode function calls and responses.
class AbiFunctionDefinition extends Equatable {
  /// The name of the function as defined in the ABI.
  /// This may be `null` if the function is unnamed (e.g., a constructor or fallback function).
  final String? name;

  /// Indicates whether the function is anonymous.
  /// This is typically used for events to signify that the event does not have a signature.
  final bool? anonymous;

  /// The type of the function as defined in the ABI.
  /// Common types include "function", "constructor", "event", and "fallback".
  final String? type;

  /// The state mutability of the function.
  /// This describes the behavior of the function with respect to the blockchain state.
  /// Possible values include "pure", "view", "nonpayable", and "payable".
  final String? stateMutability;

  /// The list of input parameters for the function.
  final List<AbiParamDefinition> inputs;

  /// The list of output parameters for the function.
  final List<AbiParamDefinition> outputs;

  /// Creates an instance of the [AbiFunctionDefinition].
  AbiFunctionDefinition({
    required this.name,
    this.anonymous,
    this.type,
    this.stateMutability,
    List<AbiParamDefinition>? inputs,
    List<AbiParamDefinition>? outputs,
  })  : inputs = inputs ?? <AbiParamDefinition>[],
        outputs = outputs ?? <AbiParamDefinition>[];

  /// Creates an instance of the [AbiFunctionDefinition] from the given [json].
  factory AbiFunctionDefinition.fromJson(Map<String, dynamic> json) {
    return AbiFunctionDefinition(
      name: json['name'] as String?,
      anonymous: json['anonymous'] as bool?,
      type: json['type'] as String,
      stateMutability: json['stateMutability'] as String?,
      inputs: (json['inputs'] as List<dynamic>?)?.map((dynamic e) => AbiParamDefinition.fromJson(e as Map<String, dynamic>)).toList(),
      outputs: (json['outputs'] as List<dynamic>?)?.map((dynamic e) => AbiParamDefinition.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  /// This method takes a bytes of ABI-encoded data and decodes it into the
  /// corresponding parameters based on the function's input types.
  Map<String, dynamic> decodeParameters(List<int> encodedData) {
    Map<String, dynamic> decodedParams = <String, dynamic>{};
    int offset = 0;

    for (AbiParamDefinition abiParamDefinition in inputs) {
      dynamic decodedValue = abiParamDefinition.type.hasDynamicSize
          ? abiParamDefinition.type.decode(encodedData, SolidityIntType.decodeInt(encodedData, offset).toInt())
          : abiParamDefinition.type.decode(encodedData, offset);

      decodedParams[abiParamDefinition.name] = decodedValue;
      offset += abiParamDefinition.type.fixedSize;
    }

    return decodedParams;
  }

  /// The function selector, which is the first 4 bytes of the Keccak-256 hash of the function signature.
  /// This is used to identify the function in transaction data.
  String get functionSelector {
    Uint8List hash = Keccak(256).process(utf8.encode(functionSignature));
    return HexCodec.encode(hash).substring(0, 8);
  }

  /// The function signature, which is a string representation of the function name and parameter types.
  /// This is used to uniquely identify the function within the contract ABI.
  String get functionSignature {
    return '$name(${inputs.map((AbiParamDefinition abiInput) => abiInput.type.canonicalName).join(',')})';
  }

  @override
  List<Object?> get props => <Object?>[name, anonymous, type, stateMutability, inputs, outputs];
}
