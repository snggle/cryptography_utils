import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/abi_decoder.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/abi_library.dart';

// ignore_for_file: invalid_assignment

// Function to get the function selector from function signature

void main() async {
  String name = '0x06fdde03';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(name)));
  print('');

  String symbol = '0x95d89b41';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(symbol)));
  print('');

  String decimals = '0x313ce567';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(decimals)));
  print('');

  String totalSupply = '0x18160ddd';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(totalSupply)));
  print('');

  String balanceOf = '0x70a082310000000000000000000000001234567890abcdef1234567890abcdef12345678';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(balanceOf)));
  print('');


  String transfer = '0xa9059cbb0000000000000000000000001234567890abcdef1234567890abcdef1234567800000000000000000000000000000000000000000000000000000000000003e8';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(transfer)));
  print('');

  String transferFrom = '0x23b872dd0000000000000000000000001234567890abcdef1234567890abcdef12345678000000000000000000000000abcdefabcdefabcdefabcdefabcdefabcdefabcd00000000000000000000000000000000000000000000000000000000000001f4';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(transferFrom)));
  print('');

  String approve = '0x095ea7b3000000000000000000000000abcdefabcdefabcdefabcdefabcdefabcdefabcd00000000000000000000000000000000000000000000000000000000000003e8';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(approve)));
  print('');

  String allowance = '0xdd62ed3e0000000000000000000000001234567890abcdef1234567890abcdef12345678000000000000000000000000abcdefabcdefabcdefabcdefabcdefabcdefabcd';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(allowance)));
  print('');

  String event = '0x00000000000000000000000000000000000000000000000000000000000003e8';
  print(ABIDecoder(AbiLibrary.erc20).decodeInput(HexEncoder.decode(event)));
  print('');


}


