import 'package:cryptography_utils/src/encoder/generic_encoder/abi/abi_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/registry/uniswap/uniswap_commands_abi.dart';
import 'package:equatable/equatable.dart';

class UniswapCommand extends Equatable {
  final String f;
  final String r;
  final Map<String, dynamic> command;

  const UniswapCommand({
    required this.f,
    required this.r,
    required this.command,
  });

  factory UniswapCommand.buildFromABI({
    required String fBinary,
    required String rBinary,
    required String commandBinary,
    required List<int> input,
  }) {
    int commandNumber = int.parse(commandBinary, radix: 2);
    ABIDefinition commandDefinition = UniswapCommandsAbi.commandsAbi[commandNumber]!;

    Map<String, dynamic> commandMap = commandDefinition.decodeParameters(commandDefinition, input);
    commandMap['name'] = commandDefinition.name;
    return UniswapCommand(f: fBinary, r: rBinary, command: commandMap);
  }

  @override
  List<Object?> get props => <Object?>[f, r, command];
}
