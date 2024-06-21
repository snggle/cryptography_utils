import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/generic_encoder/abi/registry/abi_input.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/registry/uniswap/uniswap_command.dart';

class AbiUniswapExecuteInput extends ABIInput {
  static const String transferFunctionSelector = '3593564c';

  final List<UniswapCommand> _commands;
  final List<Uint8List> _inputs;
  final BigInt _deadline;

  AbiUniswapExecuteInput({
    required super.functionSelector,
    required super.functionData,
    required super.json,
    required List<UniswapCommand> commands,
    required List<Uint8List> inputs,
    required BigInt deadline,
  })  : _commands = commands,
        _inputs = inputs,
        _deadline = deadline;

  factory AbiUniswapExecuteInput.fromJson(Map<String, dynamic> json, String functionSelector, String functionData) {
    List<int> commands = json['commands'] as List<int>;
    List<String> commandBinaries = commands.map((int e) => e.toRadixString(2).padLeft(8, '0')).toList();
    List<Uint8List> commandInputs = (json['inputs'] as List<dynamic>).map((dynamic e) => Uint8List.fromList(e as List<int>)).toList();
    List<UniswapCommand> uniswapCommands = <UniswapCommand>[];

    int commandIndex = 0;
    for (String binaryCommand in commandBinaries) {
      uniswapCommands.add(
        UniswapCommand.buildFromABI(
          fBinary: binaryCommand[0],
          rBinary: binaryCommand[1],
          commandBinary: binaryCommand.substring(2, 7),
          input: commandInputs[commandIndex],
        ),
      );
      commandIndex += 1;
    }

    return AbiUniswapExecuteInput(
      functionSelector: functionSelector,
      functionData: functionData,
      commands: uniswapCommands,
      inputs: commandInputs,
      deadline: BigInt.parse(json['deadline'] as String),
      json: <String, dynamic>{
        'commands': uniswapCommands.map((UniswapCommand e) => e.command),
        'deadline': json['deadline'].toString(),
      },
    );
  }

  @override
  List<Object?> get props {
    return <Object?>[functionSelector, functionData, _commands, _inputs, _deadline];
  }
}
