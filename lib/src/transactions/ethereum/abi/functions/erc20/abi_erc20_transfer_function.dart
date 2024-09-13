import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_function.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_function_definition.dart';

/// The [AbiERC20TransferFunction] class encapsulates the details required to
/// create a transaction for the ERC-20 [transfer] function. This includes the
/// recipient address and the amount to be transferred.
class AbiERC20TransferFunction extends AbiFunction {
  /// The function selector for the ERC-20 [transfer] function.
  static const String functionSelector = 'a9059cbb';

  /// The recipient address for the transfer.
  final String _recipient;

  /// The amount to be transferred.
  final BigInt _amount;

  /// Creates an instance of the [AbiERC20TransferFunction].
  const AbiERC20TransferFunction({
    required super.selector,
    required super.data,
    required super.json,
    required super.abiFunctionDefinition,
    required String recipient,
    required BigInt amount,
  })  : _amount = amount,
        _recipient = recipient;

  /// Creates an instance of the [AbiERC20TransferFunction] from the given [json].
  static AbiERC20TransferFunction fromJson({
    required Map<String, dynamic> json,
    required String functionSelector,
    required String data,
    required AbiFunctionDefinition abiFunctionDefinition,
  }) {
    return AbiERC20TransferFunction(
      selector: functionSelector,
      data: data,
      json: json,
      abiFunctionDefinition: abiFunctionDefinition,
      recipient: json['recipient'] as String,
      amount: BigInt.parse(json['amount'] as String),
    );
  }

  /// Returns the recipient of the function.
  @override
  String? get recipient => _recipient;

  /// Returns the amount of the function.
  @override
  BigInt? get amount => _amount;

  @override
  List<Object?> get props {
    return <Object?>[selector, data, json, functionSelector, _recipient, _amount];
  }
}
