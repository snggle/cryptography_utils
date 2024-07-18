import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/abi_library.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_function.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_function_definition.dart';

/// The [AbiDecoder] class provides methods to decode transaction data and logs from Ethereum contracts,
/// allowing developers to interpret and utilize the data encoded in the ABI (Application Binary Interface) format.
class AbiDecoder {
  /// List of supported ABI libraries
  static final List<List<Map<String, Object>>> _supportedAbi = <List<Map<String, Object>>>[
    AbiLibrary.erc20,
    AbiLibrary.uniswapUniversalRouter,
    AbiLibrary.uniswapV2Router02,
    AbiLibrary.uniswapV3Router,
    AbiLibrary.uniswapV3SwapRouter,
    AbiLibrary.uniswapV3SwapRouter02,
    AbiLibrary.tether,
    AbiLibrary.sereshForwarder,
    AbiLibrary.test,
  ];

  /// List of decoded supported ABI libraries
  final List<AbiFunctionDefinition> _functionDefinitions;

  /// Creates an instance of the [AbiDecoder].
  factory AbiDecoder() {
    List<AbiFunctionDefinition> functionDefinitions = <AbiFunctionDefinition>[];
    for (List<Map<String, Object>> abiJson in _supportedAbi) {
      functionDefinitions.addAll(abiJson.map(AbiFunctionDefinition.fromJson));
    }
    return AbiDecoder._(functionDefinitions: functionDefinitions);
  }

  /// Creates an instance of the [AbiDecoder] with the given [functionDefinitions].
  AbiDecoder._({
    required List<AbiFunctionDefinition> functionDefinitions,
  }) : _functionDefinitions = functionDefinitions;

  /// Function to decode the input data using ABI
  AbiFunction decodeInput(Uint8List data) {
    String functionSelector = HexEncoder.encode(data.sublist(0, 4));
    String functionData = HexEncoder.encode(data.sublist(4));

    AbiFunctionDefinition? abiFunctionDefinition = _findDefinitionByFunctionSelector(functionSelector);

    if (abiFunctionDefinition == null) {
      return AbiFunction(selector: functionSelector, data: functionData);
    }

    try {
      Map<String, dynamic> decodedFunctionParams = abiFunctionDefinition.decodeParameters(HexEncoder.decode(functionData));
      return AbiFunction.fromJson(
        json: decodedFunctionParams,
        functionSelector: functionSelector,
        data: functionData,
        abiFunctionDefinition: abiFunctionDefinition,
      );
    } catch (_) {
      return AbiFunction(selector: functionSelector, data: functionData);
    }
  }

  /// Returns [AbiFunctionDefinition] by the given [functionSelector].
  AbiFunctionDefinition? _findDefinitionByFunctionSelector(String functionSelector) {
    AbiFunctionDefinition? matchingFunction = _functionDefinitions.where((AbiFunctionDefinition abiDefinition) {
      return abiDefinition.functionSelector == functionSelector;
    }).firstOrNull;

    return matchingFunction;
  }
}
