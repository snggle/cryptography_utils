import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSystemTransferInstruction.fromSerializedData()', () {
    test('Should [return SolanaSystemTransferInstruction] from serialized data', () {
      // Act
      SolanaSystemTransferInstruction actualSolanaSystemTransferInstruction = SolanaSystemTransferInstruction.fromSerializedData(
        SolanaCompiledInstruction(
            programIdIndex: 2, accounts: Uint8List.fromList(<int>[0, 1]), data: Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0])),
        <SolanaPubKey>[
          SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
          SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
          SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
        ],
        '11111111111111111111111111111111',
      );

      // Assert
      SolanaSystemTransferInstruction expectedSolanaSystemTransferInstruction = SolanaSystemTransferInstruction(
        programId: '11111111111111111111111111111111',
        source: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        destination: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        lamports: BigInt.from(1000000000),
      );

      expect(actualSolanaSystemTransferInstruction, expectedSolanaSystemTransferInstruction);
    });
  });

  group('Tests of SolanaSystemTransferInstruction.getAmount()', () {
    test('Should [return ETH amount] from given EthereumEIP1559Transaction', () {
      // Arrange
      SolanaSystemTransferInstruction actualSolanaSystemTransferInstruction = SolanaSystemTransferInstruction(
        programId: '11111111111111111111111111111111',
        source: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        destination: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        lamports: BigInt.from(100000000),
      );

      // Act
      TokenAmount? actualTokenAmount = actualSolanaSystemTransferInstruction.getAmount();

      // Assert
      TokenAmount expectedTokenAmount = TokenAmount(
        amount: Decimal.parse('0.1'),
        denomination: 'SOL',
      );

      expect(actualTokenAmount, expectedTokenAmount);
    });
  });
}
