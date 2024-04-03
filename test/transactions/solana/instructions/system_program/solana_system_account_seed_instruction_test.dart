import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSystemAccountSeedInstruction.fromSerializedData()', () {
    test('Should [return SolanaSystemAccountSeedInstruction] from serialized data', () {
      // Act
      SolanaSystemAccountSeedInstruction actualSolanaSystemAccountSeedInstruction = SolanaSystemAccountSeedInstruction.fromSerializedData(
        SolanaCompiledInstruction(
            programIdIndex: 3,
            accounts: Uint8List.fromList(<int>[0, 1]),
            data: Uint8List.fromList(base64Decode(
                'AwAAAB0D1AEIXs5Rz43yeayo7W0tSpSEF7kNTRVAVF4UGFj0BwAAAAAAAABzdGFrZTo0gJ+9OwAAAADIAAAAAAAAAAah2BeRN1QqmDQ3vf4qerJVf1NcinhyK2ikncAAAAAA'))),
        <SolanaPubKey>[
          SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
          SolanaPubKey.fromBytes(base64Decode('aEARPNX8ZRouNCND7kdsxxGz9DM9YBdiHCKxvxt1e0Q=')),
          SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('BqfVFxksXFEhjMlMPUrxf1ja7gibof1E49vZigAAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('3fQqBIAKVN4uWD+U8XsIlyW3ctEzNSYnEkFTJ3bS/8Y=')),
          SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('BqfVFxk1hND+7ZuzQx0TIGvlRCgbV7hWbMU3X/QAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('BqHYF6UCBQtoB5Hmzm24jh5bcVD2H8Z5Ck600QAAAAA=')),
        ],
        '11111111111111111111111111111111',
      );

      // Assert
      SolanaSystemAccountSeedInstruction expectedSolanaSystemAccountSeedInstruction = SolanaSystemAccountSeedInstruction(
        programId: '11111111111111111111111111111111',
        source: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        newAccount: '81x4biFxxCL9hwJsX8PE8oz9omi3RcjLWRbt7Hw2kuwq',
        base: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        seed: 'stake:4',
        lamports: BigInt.from(1002282880),
        space: 200,
        owner: 'Stake11111111111111111111111111111111111111',
        discriminator: 3,
      );

      expect(actualSolanaSystemAccountSeedInstruction, expectedSolanaSystemAccountSeedInstruction);
    });
  });

  group('Tests of SolanaSystemAccountSeedInstruction.getAmount()', () {
    test('Should [return amount] from given SolanaSystemAccountSeedInstruction', () {
      // Arrange
      SolanaSystemAccountSeedInstruction actualSolanaSystemAccountSeedInstruction = SolanaSystemAccountSeedInstruction(
        programId: '11111111111111111111111111111111',
        source: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        newAccount: '81x4biFxxCL9hwJsX8PE8oz9omi3RcjLWRbt7Hw2kuwq',
        base: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        seed: 'stake:4',
        lamports: BigInt.from(1002282880),
        space: 200,
        owner: 'Stake11111111111111111111111111111111111111',
        discriminator: 3,
      );

      // Act
      TokenAmount? actualTokenAmount = actualSolanaSystemAccountSeedInstruction.getAmount();

      // Assert
      TokenAmount expectedTokenAmount = TokenAmount(
        amount: Decimal.parse('1.00228288'),
        denomination: 'SOL',
      );

      expect(actualTokenAmount, expectedTokenAmount);
    });
  });
}
