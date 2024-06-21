import 'package:cryptography_utils/src/encoder/generic_encoder/abi/registry/erc20/abi_transfer_input.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/registry/uniswap/abi_uniswap_execute_input.dart';
import 'package:equatable/equatable.dart';

class ABIInput extends Equatable {
  final String functionSelector;
  final String functionData;
  final Map<String, dynamic> json;

  ABIInput({
    required this.functionSelector,
    required this.functionData,
    Map<String, dynamic>? json,
  }) : json = json ?? <String, dynamic>{};

  static ABIInput fromJson(Map<String, dynamic> json, String functionSelector, String encodedData) {
    if (functionSelector == AbiERC20Transfer.transferFunctionSelector) {
      return AbiERC20Transfer.fromJson(json, functionSelector, encodedData);
    } else if (functionSelector == AbiUniswapExecuteInput.transferFunctionSelector) {
      return AbiUniswapExecuteInput.fromJson(json, functionSelector, encodedData);
    }
    return ABIInput(
      functionSelector: functionSelector,
      functionData: encodedData,
      json: json,
    );
  }

  String? get sender => null;

  String? get recipient => null;

  BigInt? get amount => null;

  @override
  List<Object?> get props {
    return <Object?>[functionSelector, functionData];
  }
}
