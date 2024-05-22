import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/ethereum/access_list_bytes_item.dart';
import 'package:cryptography_utils/src/transactions/ethereum/ethereum_eip1559_transaction.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EthereumEIP1559Transaction.fromSerializedData() constructor', () {
    test('Should [return EthereumEIP1559Transaction] from given bytes', () {
      // Arrange
      Uint8List actualSerializedData = base64Decode('AvGDqjanAYRZaC8AhFu8hkmCUgiUmRXqJnURVwItUdZ/p1U77jJWNP2HEcN5N+CAAIDA');

      // Act
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction.fromSerializedData(actualSerializedData);

      // Assert
      EthereumEIP1559Transaction expectedEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.one,
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('1539081801'),
        gasLimit: BigInt.parse('21000'),
        to: '0x9915ea26751157022d51d67fa7553bee325634fd',
        value: BigInt.parse('5000000000000000'),
        data: Uint8List(0),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      expect(actualEthereumEIP1559Transaction, expectedEthereumEIP1559Transaction);
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
        to: '0x9915ea26751157022d51d67fa7553bee325634fd',
        value: BigInt.parse('5000000000000000'),
        data: Uint8List(0),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      Uint8List actualSerializedData = actualEthereumEIP1559Transaction.serialize();

      // Assert
      Uint8List expectedSerializedData = base64Decode('AvGDqjanAYRZaC8AhFu8hkmCUgiUmRXqJnURVwItUdZ/p1U77jJWNP2HEcN5N+CAAIDA');

      expect(actualSerializedData, expectedSerializedData);
    });
  });
}
