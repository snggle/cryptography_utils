import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_function.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_function_definition.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/erc20/abi_erc20_transfer_function.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_address_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_int_type.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EthereumEIP1559Transaction.fromSerializedData() constructor', () {
    test('Should [return EthereumEIP1559Transaction] from given bytes', () {
      // Arrange
      Uint8List actualSerializedData = base64Decode('AvGDqjanAYRZaC8AhFu8hkmCUgiUU78KGHVIc6gQJiXYIlr2oVpDQjyHEcN5N+CAAIDA');

      // Act
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction.fromSerializedData(actualSerializedData);

      // Assert
      EthereumEIP1559Transaction expectedEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x53bf0a18754873a8102625d8225af6a15a43423c',
        value: BigInt.parse('5000000000000000'),
        data: Uint8List(0),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      expect(actualEthereumEIP1559Transaction, expectedEthereumEIP1559Transaction);
    });
  });

  group('Tests of EthereumEIP1559Transaction.abiFunction getter', () {
    test('Should [return decoded AbiFunction] from given EthereumEIP1559Transaction if [ABI definition EXISTS]', () {
      // Arrange
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x16980b3B4a3f9D89E33311B5aa8f80303E5ca4F8',
        value: BigInt.parse('5000000000000000'),
        data: HexCodec.decode(
          '0xa9059cbb0000000000000000000000001234567890abcdef1234567890abcdef1234567800000000000000000000000000000000000000000000000000000000000003e8',
        ),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      AbiFunction? actualAbiFunction = actualEthereumEIP1559Transaction.abiFunction;

      // Assert
      AbiFunction expectedAbiFunction = AbiERC20TransferFunction(
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
        amount: BigInt.parse('1000'),
        recipient: '0x1234567890abcdef1234567890abcdef12345678',
      );

      expect(actualAbiFunction, expectedAbiFunction);
    });

    test('Should [return encoded AbiFunction] from given EthereumEIP1559Transaction if [ABI definition NOT EXISTS]', () {
      // Arrange
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x16980b3B4a3f9D89E33311B5aa8f80303E5ca4F8',
        value: BigInt.parse('5000000000000000'),
        data: HexCodec.decode('0xd0e30db0'),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      AbiFunction? actualAbiFunction = actualEthereumEIP1559Transaction.abiFunction;

      // Assert
      AbiFunction expectedAbiFunction = const AbiFunction(selector: 'd0e30db0', data: '');

      expect(actualAbiFunction, expectedAbiFunction);
    });
  });

  group('Tests of EthereumEIP1559Transaction.contractAddress getter', () {
    test('Should [return contract address] from given EthereumEIP1559Transaction', () {
      // Arrange
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x16980b3B4a3f9D89E33311B5aa8f80303E5ca4F8',
        value: BigInt.parse('5000000000000000'),
        data: HexCodec.decode(
          '0xa9059cbb0000000000000000000000001234567890abcdef1234567890abcdef1234567800000000000000000000000000000000000000000000000000000000000003e8',
        ),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      String? actualContractAddress = actualEthereumEIP1559Transaction.contractAddress;

      // Assert
      String expectedContractAddress = '0x16980b3B4a3f9D89E33311B5aa8f80303E5ca4F8';

      expect(actualContractAddress, expectedContractAddress);
    });
  });

  group('Tests of EthereumEIP1559Transaction.getAmount()', () {
    test('Should [return ETH amount] from given EthereumEIP1559Transaction', () {
      // Arrange
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x53Bf0A18754873A8102625D8225AF6a15a43423C',
        value: BigInt.parse('5000000000000000'),
        data: Uint8List(0),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      TokenAmount? actualTokenAmount = actualEthereumEIP1559Transaction.getAmount(TokenDenominationType.network);

      // Assert
      TokenAmount expectedTokenAmount = TokenAmount(
        amount: Decimal.parse('0.005'),
        denomination: 'ETH',
      );

      expect(actualTokenAmount, expectedTokenAmount);
    });
  });

  group('Tests of EthereumEIP1559Transaction.getFee()', () {
    test('Should [return estimated fee] from given EthereumEIP1559Transaction', () {
      // Arrange
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x53Bf0A18754873A8102625D8225AF6a15a43423C',
        value: BigInt.parse('5000000000000000'),
        data: Uint8List(0),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      TokenAmount? actualTokenAmount = actualEthereumEIP1559Transaction.getFee(TokenDenominationType.network);

      // Assert
      TokenAmount expectedTokenAmount = TokenAmount(
        amount: Decimal.parse('0.000032320717821'),
        denomination: 'ETH',
      );

      expect(actualTokenAmount, expectedTokenAmount);
    });
  });

  group('Tests of EthereumEIP1559Transaction.recipientAddress getter', () {
    test('Should [return recipient address] from given EthereumEIP1559Transaction', () {
      // Arrange
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x53Bf0A18754873A8102625D8225AF6a15a43423C',
        value: BigInt.parse('5000000000000000'),
        data: Uint8List(0),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      String? actualRecipientAddress = actualEthereumEIP1559Transaction.recipientAddress;

      // Assert
      String expectedRecipientAddress = '0x53Bf0A18754873A8102625D8225AF6a15a43423C';

      expect(actualRecipientAddress, expectedRecipientAddress);
    });
  });

  group('Tests of EthereumEIP1559Transaction.serialize()', () {
    test('Should [return bytes] representing serialized transaction', () {
      // Arrange
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x53bf0a18754873a8102625d8225af6a15a43423c',
        value: BigInt.parse('5000000000000000'),
        data: Uint8List(0),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      Uint8List actualSerializedData = actualEthereumEIP1559Transaction.serialize();

      // Assert
      Uint8List expectedSerializedData = base64Decode('AvGDqjanAYRZaC8AhFu8hkmCUgiUU78KGHVIc6gQJiXYIlr2oVpDQjyHEcN5N+CAAIDA');

      expect(actualSerializedData, expectedSerializedData);
    });
  });

  group('Tests of EthereumEIP1559Transaction.sign()', () {
    test('Should [return EthereumSignature] representing signed EthereumEIP1559Transaction', () {
      // Arrange
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x53bf0a18754873a8102625d8225af6a15a43423c',
        value: BigInt.parse('5000000000000000'),
        data: Uint8List(0),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      EthereumSignature actualEthereumSignature = actualEthereumEIP1559Transaction.sign(ECPrivateKey.fromBytes(
        HexCodec.decode('cd23c9f2e2c096ee3be3c4e0e58199800c0036ea27b7cd4e838bbde8b21788b3'),
        CurvePoints.generatorSecp256k1,
      ));

      // Assert
      EthereumSignature expectedEthereumSignature = EthereumSignature(
        s: BigInt.parse('47433393723216934132856937072151317027594472979899269687005250519575710735740'),
        r: BigInt.parse('35318783184227901530172545571080723461143763076906190194404162684934635181570'),
        v: 28,
        eip155Bool: false,
      );

      expect(actualEthereumSignature, expectedEthereumSignature);
    });
  });
}
