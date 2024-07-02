import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/ethereum/access_list_bytes_item.dart';
import 'package:cryptography_utils/src/transactions/ethereum/ethereum_eip1559_transaction.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EthereumEIP1559Transaction.fromSerializedData() constructor', () {
    test('Should [return EthereumEIP1559Transaction] from given bytes', () {
      // Arrange
      Uint8List actualSerializedData = Uint8List.fromList(<int>[2, 249, 1, 21, 131, 170, 54, 167, 40, 132, 89, 104, 47, 0, 133, 55, 226, 46, 44, 146, 131, 5, 50, 60, 148, 0, 177, 154, 82, 0, 161, 0, 229, 252, 76, 152, 0, 119, 47, 77, 0, 47, 33, 132, 0, 128, 184, 232, 126, 115, 76, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 160, 137, 89, 70, 113, 201, 251, 132, 109, 66, 108, 2, 82, 60, 84, 113, 80, 136, 10, 183, 83, 168, 252, 32, 218, 83, 79, 58, 83, 107, 220, 163, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 80, 105, 99, 107, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 80, 99, 107, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 159, 100, 227, 192]);

      // Act
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction.fromSerializedData(actualSerializedData);

      // Assert
      EthereumEIP1559Transaction expectedEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.parse('40'),
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('240017878162'),
        gasLimit: BigInt.parse('340540'),
        to: '0x00b19a5200a100e5fc4c9800772f4d002f218400',
        value: BigInt.parse('0'),
        data: Uint8List.fromList(<int>[126, 115, 76, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 160, 137, 89, 70, 113, 201, 251, 132, 109, 66, 108, 2, 82, 60, 84, 113, 80, 136, 10, 183, 83, 168, 252, 32, 218, 83, 79, 58, 83, 107, 220, 163, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 80, 105, 99, 107, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 80, 99, 107, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 159, 100, 227]),
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
        nonce: BigInt.parse('40'),
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('240017878162'),
        gasLimit: BigInt.parse('340540'),
        to: '0x00b19a5200a100e5fc4c9800772f4d002f218400',
        value: BigInt.parse('0'),
        data: Uint8List.fromList(<int>[126, 115, 76, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 160, 137, 89, 70, 113, 201, 251, 132, 109, 66, 108, 2, 82, 60, 84, 113, 80, 136, 10, 183, 83, 168, 252, 32, 218, 83, 79, 58, 83, 107, 220, 163, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 80, 105, 99, 107, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 80, 99, 107, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 159, 100, 227]),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      Uint8List actualSerializedData = actualEthereumEIP1559Transaction.serialize();

      // Assert
      Uint8List expectedSerializedData = Uint8List.fromList(<int>[2, 249, 1, 21, 131, 170, 54, 167, 40, 132, 89, 104, 47, 0, 133, 55, 226, 46, 44, 146, 131, 5, 50, 60, 148, 0, 177, 154, 82, 0, 161, 0, 229, 252, 76, 152, 0, 119, 47, 77, 0, 47, 33, 132, 0, 128, 184, 232, 126, 115, 76, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 160, 137, 89, 70, 113, 201, 251, 132, 109, 66, 108, 2, 82, 60, 84, 113, 80, 136, 10, 183, 83, 168, 252, 32, 218, 83, 79, 58, 83, 107, 220, 163, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 80, 105, 99, 107, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 80, 99, 107, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 159, 100, 227, 192]);

      expect(actualSerializedData, expectedSerializedData);
    });
  });

  group('Tests of EthereumEIP1559Transaction.fromSerializedData() constructor', () {
    test('Should [return EthereumEIP1559Transaction] from given bytes', () {
      // Arrange
      Uint8List actualSerializedData = Uint8List.fromList(<int>[2, 246, 131, 170, 54, 167, 42, 132, 89, 104, 47, 0, 133, 10, 217, 68, 247, 151, 130, 110, 124, 148, 255, 249, 151, 103, 130, 212, 108, 192, 86, 48, 209, 246, 235, 171, 24, 178, 50, 77, 107, 20, 135, 3, 141, 126, 164, 198, 128, 0, 132, 208, 227, 13, 176, 192]);

      // Act
      EthereumEIP1559Transaction actualEthereumEIP1559Transaction = EthereumEIP1559Transaction.fromSerializedData(actualSerializedData);

      // Assert
      EthereumEIP1559Transaction expectedEthereumEIP1559Transaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('11155111'),
        nonce: BigInt.parse('42'),
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('46594848663'),
        gasLimit: BigInt.parse('28284'),
        to: '0xfff9976782d46cc05630d1f6ebab18b2324d6b14',
        value: BigInt.parse('1000000000000000'),
        data: Uint8List.fromList(<int>[208, 227, 13, 176]),
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
        nonce: BigInt.parse('42'),
        maxPriorityFeePerGas: BigInt.parse('1500000000'),
        maxFeePerGas: BigInt.parse('46594848663'),
        gasLimit: BigInt.parse('28284'),
        to: '0xfff9976782d46cc05630d1f6ebab18b2324d6b14',
        value: BigInt.parse('1000000000000000'),
        data: Uint8List.fromList(<int>[208, 227, 13, 176]),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      // Act
      Uint8List actualSerializedData = actualEthereumEIP1559Transaction.serialize();

      // Assert
      Uint8List expectedSerializedData = Uint8List.fromList(<int>[2, 246, 131, 170, 54, 167, 42, 132, 89, 104, 47, 0, 133, 10, 217, 68, 247, 151, 130, 110, 124, 148, 255, 249, 151, 103, 130, 212, 108, 192, 86, 48, 209, 246, 235, 171, 24, 178, 50, 77, 107, 20, 135, 3, 141, 126, 164, 198, 128, 0, 132, 208, 227, 13, 176, 192]);

      expect(actualSerializedData, expectedSerializedData);
    });
  });
}
