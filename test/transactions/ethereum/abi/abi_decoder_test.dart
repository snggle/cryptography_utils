import 'package:codec_utils/src/codecs/hex/hex_codec.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/abi_decoder.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_function.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_function_definition.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/erc20/abi_erc20_transfer_function.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_address_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_int_type.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of AbiDecoder.decodeInput()', () {
    group('Tests of ABI for ERC20', () {
      test('Should [return AbiFunction] with decoded input data (name)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input = '0x06fdde03';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(selector: '06fdde03', data: '', json: <String, dynamic>{});

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiFunction] with decoded input data (symbol)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input = '0x95d89b41';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(selector: '95d89b41', data: '', json: <String, dynamic>{});

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiFunction] with decoded input data (decimals)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input = '0x313ce567';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(selector: '313ce567', data: '', json: <String, dynamic>{});

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiFunction] with decoded input data (totalSupply)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input = '0x18160ddd';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(selector: '18160ddd', data: '', json: <String, dynamic>{});

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiFunction] with decoded input data (balanceOf)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input = '0x70a082310000000000000000000000001234567890abcdef1234567890abcdef12345678';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(
          selector: '70a08231',
          data: '0000000000000000000000001234567890abcdef1234567890abcdef12345678',
          json: <String, dynamic>{'account': '0x1234567890abcdef1234567890abcdef12345678'},
        );

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiERC20TransferFunction] with decoded input data (transfer)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input =
            '0xa9059cbb0000000000000000000000001234567890abcdef1234567890abcdef1234567800000000000000000000000000000000000000000000000000000000000003e8';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiERC20TransferFunction expectedAbiFunction = AbiERC20TransferFunction(
          recipient: '0x1234567890abcdef1234567890abcdef12345678',
          amount: BigInt.parse('1000'),
          selector: 'a9059cbb',
          data: '0000000000000000000000001234567890abcdef1234567890abcdef1234567800000000000000000000000000000000000000000000000000000000000003e8',
          json: const <String, dynamic>{'recipient': '0x1234567890abcdef1234567890abcdef12345678', 'amount': '1000'},
          abiFunctionDefinition: AbiFunctionDefinition(
            name: 'transfer',
            inputs: <AbiParamDefinition>[
              AbiParamDefinition(name: 'recipient', type: SolidityAddressType()),
              AbiParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
            ],
          ),
        );

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiFunction] with decoded input data (transferFrom)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input =
            '0x23b872dd0000000000000000000000001234567890abcdef1234567890abcdef12345678000000000000000000000000abcdefabcdefabcdefabcdefabcdefabcdefabcd00000000000000000000000000000000000000000000000000000000000001f4';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(
          selector: '23b872dd',
          data:
              '0000000000000000000000001234567890abcdef1234567890abcdef12345678000000000000000000000000abcdefabcdefabcdefabcdefabcdefabcdefabcd00000000000000000000000000000000000000000000000000000000000001f4',
          json: <String, dynamic>{
            'sender': '0x1234567890abcdef1234567890abcdef12345678',
            'recipient': '0xabcdefabcdefabcdefabcdefabcdefabcdefabcd',
            'amount': '500',
          },
        );

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiFunction] with decoded input data (approve)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input =
            '0x095ea7b3000000000000000000000000abcdefabcdefabcdefabcdefabcdefabcdefabcd00000000000000000000000000000000000000000000000000000000000003e8';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(
          selector: '095ea7b3',
          data: '000000000000000000000000abcdefabcdefabcdefabcdefabcdefabcdefabcd00000000000000000000000000000000000000000000000000000000000003e8',
          json: <String, dynamic>{'spender': '0xabcdefabcdefabcdefabcdefabcdefabcdefabcd', 'amount': '1000'},
        );

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiFunction] with decoded input data (allowance)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input =
            '0xdd62ed3e0000000000000000000000001234567890abcdef1234567890abcdef12345678000000000000000000000000abcdefabcdefabcdefabcdefabcdefabcdefabcd';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(
          selector: 'dd62ed3e',
          data: '0000000000000000000000001234567890abcdef1234567890abcdef12345678000000000000000000000000abcdefabcdefabcdefabcdefabcdefabcdefabcd',
          json: <String, dynamic>{'owner': '0x1234567890abcdef1234567890abcdef12345678', 'spender': '0xabcdefabcdefabcdefabcdefabcdefabcdefabcd'},
        );

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiFunction] with decoded input data (event)', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input = '0x00000000000000000000000000000000000000000000000000000000000003e8';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(selector: '00000000', data: '000000000000000000000000000000000000000000000000000003e8');

        expect(actualAbiFunction, expectedAbiFunction);
      });

      test('Should [return AbiFunction] with encoded input data if ABI Definition not found', () {
        // Arrange
        AbiDecoder abiDecoder = AbiDecoder();
        String input = '0x1010101010101010101010101010101010101010101010101010101010101010101010101010';

        // Act
        AbiFunction actualAbiFunction = abiDecoder.decodeInput(HexCodec.decode(input));

        // Assert
        AbiFunction expectedAbiFunction = const AbiFunction(selector: '10101010', data: '10101010101010101010101010101010101010101010101010101010101010101010');

        expect(actualAbiFunction, expectedAbiFunction);
      });
    });
  });
}
