import 'package:cryptography_utils/src/encoder/generic_encoder/abi/registry/abi_input.dart';

class AbiERC20Transfer extends ABIInput {
  static const String transferFunctionSelector = 'a9059cbb';

  final String _recipient;
  final BigInt _amount;

  AbiERC20Transfer({
    required super.functionSelector,
    required super.functionData,
    required String recipient,
    required BigInt amount,
  }) : _amount = amount, _recipient = recipient;

  factory AbiERC20Transfer.fromJson(Map<String, dynamic> json, String functionSelector, String functionData) {
    return AbiERC20Transfer(
      functionSelector: functionSelector,
      functionData: functionData,
      recipient: json['recipient'] as String,
      amount: json['amount'] as BigInt,
    );
  }
  
  @override
  String? get recipient => _recipient;

  @override
  BigInt? get amount => _amount;

  @override
  List<Object?> get props {
    return <Object?>[functionSelector, functionData, _recipient, _amount];
  }
}
