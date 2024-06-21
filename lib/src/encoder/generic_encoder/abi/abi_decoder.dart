import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/abi_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/registry/abi_input.dart';

class ABIDecoder {
  static const String _functionType = 'function';

  final List<ABIDefinition> _availableABIEntries;

  factory ABIDecoder(List<Map<String, Object>> abi) {
    List<ABIDefinition> availableABIEntries = abi.map(ABIDefinition.fromJson).toList();
    return ABIDecoder._(availableABIEntries: availableABIEntries);
  }

  ABIDecoder._({
    required List<ABIDefinition> availableABIEntries,
  }) : _availableABIEntries = availableABIEntries;

  // Function to decode the input data using ABI
  ABIInput decodeInput(Uint8List data) {
    // Extract the function selector
    String functionSelector = HexEncoder.encode(data.sublist(0, 4));
    print('Function selector: $functionSelector');
    String functionData = HexEncoder.encode(data.sublist(4));

    // Find the matching function in ABI
    ABIDefinition? matchingFunction = _findAbiByFunctionSelector(functionSelector);
    print('Matching function: $matchingFunction');

    if (matchingFunction == null) {
      return ABIInput(functionSelector: functionSelector, functionData: functionData);
    }

    // Decode the input parameters
    Map<String, dynamic> decodedParams = matchingFunction.decodeParameters(matchingFunction, HexEncoder.decode(functionData));
    return ABIInput.fromJson(decodedParams, functionSelector, HexEncoder.encode(data));
  }


  ABIDefinition? _findAbiByFunctionSelector(String functionSelector) {
    ABIDefinition? matchingFunction = _availableABIEntries.where((ABIDefinition abiDefinition) {
      if (abiDefinition.type != _functionType) {
        return false;
      }
      return abiDefinition.functionSelector == functionSelector;
    }).firstOrNull;

    return matchingFunction;
  }
}
