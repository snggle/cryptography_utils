import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_function_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/erc20/abi_erc20_transfer_function.dart';
import 'package:equatable/equatable.dart';

/// The [AbiFunction] class holds the details of a contract function that has
/// been parsed from the ABI (Application Binary Interface).
class AbiFunction extends Equatable {
  /// Unique string identifying the function.
  final String selector;

  /// Encoded data for the function.
  final String data;

  /// JSON representation of the function.
  final Map<String, dynamic>? json;

  /// The associated [AbiFunctionDefinition] for the function.
  final AbiFunctionDefinition? abiFunctionDefinition;

  /// Creates an instance of the [AbiFunction].
  const AbiFunction({
    required this.selector,
    required this.data,
    this.json,
    this.abiFunctionDefinition,
  });

  /// Creates an instance of the [AbiFunction] from the given [json].
  static AbiFunction fromJson({
    required Map<String, dynamic> json,
    required String functionSelector,
    required String data,
    required AbiFunctionDefinition abiFunctionDefinition,
  }) {
    if (functionSelector == AbiERC20TransferFunction.functionSelector) {
      return AbiERC20TransferFunction.fromJson(json: json, functionSelector: functionSelector, data: data, abiFunctionDefinition: abiFunctionDefinition);
    }

    return AbiFunction(
      selector: functionSelector,
      data: data,
      json: json,
    );
  }

  /// Returns the hexadecimal representation of the function.
  String get hex => '0x$selector$data';

  /// Returns the sender of the function if available.
  String? get sender => null;

  /// Returns the recipient of the function if available.
  String? get recipient => null;

  /// Returns the amount of the function if available.
  BigInt? get amount => null;

  @override
  List<Object?> get props => <Object?>[selector, data, json, abiFunctionDefinition];
}
