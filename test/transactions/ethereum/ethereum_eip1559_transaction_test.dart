import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/ethereum/access_list_bytes_item.dart';
import 'package:cryptography_utils/src/transactions/ethereum/ethereum_eip1559_transaction.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EthereumEIP1559Transaction.fromSerializedData() constructor', () {
    test('Should [return EthereumEIP1559Transaction] from given bytes', () {
      // Arrange
      List<int> bytes= <int>[2, 240, 131, 170, 54, 167, 128, 132, 89, 104, 47, 0, 132, 89, 107, 135, 73, 130, 82, 8, 148, 132, 12, 98, 45, 215, 195, 128, 119, 78, 167, 159, 159, 150, 222, 100, 103, 148, 80, 241, 201, 135, 35, 134, 242, 111, 193, 0, 0, 128, 192];
      Uint8List actualSerializedData = Uint8List.fromList(bytes);

      // Act
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction.fromSerializedData(actualSerializedData);

      Uint8List actualSerializedData2 = actualEthereumEIP1559Transaction.serialize();

      expect(actualSerializedData, actualSerializedData2);
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
