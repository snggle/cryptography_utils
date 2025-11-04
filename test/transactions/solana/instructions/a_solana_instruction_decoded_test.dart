import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ASolanaInstructionDecoded.decode()', () {
    group('Tests of ASolanaInstructionDecoded.decode() - default path', () {
      test('Should [return SolanaUnknownInstruction] from an instruction with an unknown programId', () {
        // Act
        ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
            programIdIndex: 1,
            accounts: Uint8List.fromList(<int>[0, 1]),
            data: base64Decode(
                'AQAAAFGYCAVd43XhlRiSq7C4NB9zYy/yP5Zodzow9Mo0zXtcBwAAAAAAAABzdGFrZTowyAiZOwAAAADIAAAAAAAAAAah2BeRN1QqmDQ3vf4qerJVf1NcinhyK2ikncAAAAAA'),
          ),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('wz8cu0jrS8Gt71lzlkKPUyLwd3Wq/J2JWjpRn93SKpY=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxksXFEhjMlMPUrxf1ja7gibof1E49vZigAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('3fQqBIAKVN4uWD+U8XsIlyW3ctEzNSYnEkFTJ3bS/8Y=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxk1hND+7ZuzQx0TIGvlRCgbV7hWbMU3X/QAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF6UCBQtoB5Hmzm24jh5bcVD2H8Z5Ck600QAAAAA=')),
          ],
        );

        // Assert
        SolanaUnknownInstruction expectedSolanaUnknownInstruction =
            const SolanaUnknownInstruction(programId: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR');

        expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
      });

      test('Should [return SolanaUnknownInstruction] from an instruction with an unknown programId', () {
        // Act
        ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
            programIdIndex: 1,
            accounts: Uint8List.fromList(<int>[0, 1]),
            data: base64Decode(
                'AQAAAFGYCAVd43XhlRiSq7C4NB9zYy/yP5Zodzow9Mo0zXtcBwAAAAAAAABzdGFrZTowyAiZOwAAAADIAAAAAAAAAAah2BeRN1QqmDQ3vf4qerJVf1NcinhyK2ikncAAAAAA'),
          ),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('wz8cu0jrS8Gt71lzlkKPUyLwd3Wq/J2JWjpRn93SKpY=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxksXFEhjMlMPUrxf1ja7gibof1E49vZigAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('3fQqBIAKVN4uWD+U8XsIlyW3ctEzNSYnEkFTJ3bS/8Y=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxk1hND+7ZuzQx0TIGvlRCgbV7hWbMU3X/QAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF6UCBQtoB5Hmzm24jh5bcVD2H8Z5Ck600QAAAAA=')),
          ],
        );

        // Assert
        SolanaUnknownInstruction expectedSolanaUnknownInstruction =
            const SolanaUnknownInstruction(programId: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR');

        expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
      });

      test('Should [return SolanaInvalidInstruction] from serialized instruction with no account keys', () {
        // Act
        ASolanaInstructionDecoded actualSolanaInvalidInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 11, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1])),
          const <SolanaPubKey>[],
        );

        // Assert
        SolanaInvalidInstruction expectedSolanaInvalidInstruction = const SolanaInvalidInstruction();

        expect(actualSolanaInvalidInstruction, expectedSolanaInvalidInstruction);
      });

      test('Should [return SolanaInvalidInstruction] from serialized instruction with programId out of bounds', () {
        // Act
        ASolanaInstructionDecoded actualSolanaInvalidInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 25, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('rpH5txy8M7bxBPIjkHpFrfq04cryOKnpH2SiPswoAmM=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
          ],
        );

        // Assert
        SolanaInvalidInstruction expectedSolanaInvalidInstruction = const SolanaInvalidInstruction();

        expect(actualSolanaInvalidInstruction, expectedSolanaInvalidInstruction);
      });
    });

    group('Tests of ASolanaInstructionDecoded.decode() - _decodeSystemProgram() path', () {
      test('Should [return SolanaSystemTransferInstruction] from serialized SolanaSystemTransferInstruction', () {
        // Act
        ASolanaInstructionDecoded actualSolanaSystemTransferInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
              programIdIndex: 2, accounts: Uint8List.fromList(<int>[0, 1]), data: Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
          ],
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

      test('Should [return SolanaUnknownInstruction] from serialized system program instruction with an unknown tag', () {
        // Act
        ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
            programIdIndex: 3,
            accounts: Uint8List.fromList(<int>[0, 1]),
            data: base64Decode(
                'AQAAAFGYCAVd43XhlRiSq7C4NB9zYy/yP5Zodzow9Mo0zXtcBwAAAAAAAABzdGFrZTowyAiZOwAAAADIAAAAAAAAAAah2BeRN1QqmDQ3vf4qerJVf1NcinhyK2ikncAAAAAA'),
          ),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('wz8cu0jrS8Gt71lzlkKPUyLwd3Wq/J2JWjpRn93SKpY=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxksXFEhjMlMPUrxf1ja7gibof1E49vZigAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('3fQqBIAKVN4uWD+U8XsIlyW3ctEzNSYnEkFTJ3bS/8Y=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxk1hND+7ZuzQx0TIGvlRCgbV7hWbMU3X/QAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF6UCBQtoB5Hmzm24jh5bcVD2H8Z5Ck600QAAAAA=')),
          ],
        );

        // Assert
        SolanaUnknownInstruction expectedSolanaUnknownInstruction = const SolanaUnknownInstruction(programId: '11111111111111111111111111111111');

        expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
      });
    });

    group('Tests of ASolanaInstructionDecoded.decode() - _decodeTokenProgram() path', () {
      test('Should [return SolanaTokenTransferInstruction] from serialized SolanaTokenTransferInstruction', () {
        // Act
        ASolanaInstructionDecoded actualSolanaTokenTransferInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
              programIdIndex: 5, accounts: Uint8List.fromList(<int>[2, 3, 1, 0]), data: Uint8List.fromList(<int>[12, 64, 66, 15, 0, 0, 0, 0, 0, 6])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('QcP4RyZsB5mqKLVXbVwJOPUQz1BEAbKAvrz2grGLjSg=')),
            SolanaPubKey.fromBytes(base64Decode('fgTQkptSwcCd6H+RFKHWRBILwGHlUQiXdfuEeaD99kM=')),
            SolanaPubKey.fromBytes(base64Decode('O0Qss5EhV/E6kz0BNCgtAytf/s0Botvxt3kGCN8ALqc=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('Bt324ddloZPZy+FGzut5rBy0he1fWzeROoz1hX7/AKk=')),
          ],
        );

        // Assert
        SolanaTokenTransferCheckedInstruction expectedSolanaTokenTransferInstruction = SolanaTokenTransferCheckedInstruction(
          programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
          source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
          destination: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
          amount: BigInt.from(1000000),
          mint: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
          authority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
          decimals: 6,
        );

        expect(actualSolanaTokenTransferInstruction, expectedSolanaTokenTransferInstruction);
      });

      test('Should [return SolanaUnknownInstruction] from serialized token transfer instruction with an unknown tag', () {
        // Act
        ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
              programIdIndex: 5, accounts: Uint8List.fromList(<int>[2, 3, 1, 0]), data: Uint8List.fromList(<int>[11, 64, 66, 15, 0, 0, 0, 0, 0, 6])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('QcP4RyZsB5mqKLVXbVwJOPUQz1BEAbKAvrz2grGLjSg=')),
            SolanaPubKey.fromBytes(base64Decode('fgTQkptSwcCd6H+RFKHWRBILwGHlUQiXdfuEeaD99kM=')),
            SolanaPubKey.fromBytes(base64Decode('O0Qss5EhV/E6kz0BNCgtAytf/s0Botvxt3kGCN8ALqc=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('Bt324ddloZPZy+FGzut5rBy0he1fWzeROoz1hX7/AKk=')),
          ],
        );

        // Assert
        SolanaUnknownInstruction expectedSolanaUnknownInstruction =
            const SolanaUnknownInstruction(programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');

        expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
      });
    });

    group('Tests of ASolanaInstructionDecoded.decode() - _decodeComputeBudgetProgram() path', () {
      test('Should [return SolanaComputeBudgetSetComputeUnitPriceInstruction] from serialized SolanaComputeBudgetSetComputeUnitPriceInstruction', () {
        // Act
        ASolanaInstructionDecoded actualSolanaComputeBudgetSetComputeUnitPriceInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[3, 0, 45, 49, 1, 0, 0, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
          ],
        );

        // Assert
        SolanaComputeBudgetUnitPriceInstruction expectedSolanaComputeBudgetSetComputeUnitPriceInstruction =
            const SolanaComputeBudgetUnitPriceInstruction(
          discriminator: 3,
          programId: 'ComputeBudget111111111111111111111111111111',
          microLamports: 20000000,
        );

        expect(actualSolanaComputeBudgetSetComputeUnitPriceInstruction, expectedSolanaComputeBudgetSetComputeUnitPriceInstruction);
      });

      test('Should [return SolanaComputeBudgetSetComputeUnitLimitInstruction] from serialized SolanaComputeBudgetSetComputeUnitLimitInstruction', () {
        // Act
        ASolanaInstructionDecoded actualSolanaComputeBudgetSetComputeUnitLimitInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[2, 239, 1, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
          ],
        );

        // Assert
        SolanaComputeBudgetUnitLimitInstruction expectedSolanaComputeBudgetSetComputeUnitLimitInstruction =
            const SolanaComputeBudgetUnitLimitInstruction(
          discriminator: 2,
          programId: 'ComputeBudget111111111111111111111111111111',
          units: 495,
        );

        expect(actualSolanaComputeBudgetSetComputeUnitLimitInstruction, expectedSolanaComputeBudgetSetComputeUnitLimitInstruction);
      });

      test('Should [return SolanaUnknownInstruction] from serialized compute budget instruction with an unknown tag', () {
        // Act
        ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[1, 0, 45, 49, 1, 0, 0, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
          ],
        );

        // Assert
        SolanaUnknownInstruction expectedSolanaUnknownInstruction =
            const SolanaUnknownInstruction(programId: 'ComputeBudget111111111111111111111111111111');

        expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
      });
    });

    group('Tests of ASolanaInstructionDecoded.decode() - _decodeStakeProgram() path', () {
      test('Should [return SolanaStakeInitializeInstruction] from serialized SolanaStakeInitializeInstruction', () {
        // Act
        ASolanaInstructionDecoded actualSolanaStakeInitializeInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
            programIdIndex: 4,
            accounts: Uint8List.fromList(<int>[1, 5]),
            data: base64Decode(
                'AAAAAFGYCAVd43XhlRiSq7C4NB9zYy/yP5Zodzow9Mo0zXtcUZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1wAAAAAAAAAAAAAAAAAAAAAUZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w='),
          ),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('wz8cu0jrS8Gt71lzlkKPUyLwd3Wq/J2JWjpRn93SKpY=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxksXFEhjMlMPUrxf1ja7gibof1E49vZigAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('3fQqBIAKVN4uWD+U8XsIlyW3ctEzNSYnEkFTJ3bS/8Y=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxk1hND+7ZuzQx0TIGvlRCgbV7hWbMU3X/QAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF6UCBQtoB5Hmzm24jh5bcVD2H8Z5Ck600QAAAAA=')),
          ],
        );

        // Assert
        SolanaStakeInitializeInstruction expectedSolanaStakeInitializeInstruction = const SolanaStakeInitializeInstruction(
          custodian: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
          epoch: 0,
          programId: 'Stake11111111111111111111111111111111111111',
          rentSysvar: 'SysvarRent111111111111111111111111111111111',
          stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
          staker: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
          unixTimestamp: 0,
          withdrawer: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        );

        expect(actualSolanaStakeInitializeInstruction, expectedSolanaStakeInitializeInstruction);
      });

      test('Should [return SolanaStakeDelegateInstruction] from serialized SolanaStakeDelegateInstruction', () {
        // Act
        ASolanaInstructionDecoded actualSolanaStakeDelegateInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
              programIdIndex: 4, accounts: Uint8List.fromList(<int>[1, 6, 7, 8, 9, 0]), data: Uint8List.fromList(<int>[2, 0, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('wz8cu0jrS8Gt71lzlkKPUyLwd3Wq/J2JWjpRn93SKpY=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxksXFEhjMlMPUrxf1ja7gibof1E49vZigAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('3fQqBIAKVN4uWD+U8XsIlyW3ctEzNSYnEkFTJ3bS/8Y=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxk1hND+7ZuzQx0TIGvlRCgbV7hWbMU3X/QAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF6UCBQtoB5Hmzm24jh5bcVD2H8Z5Ck600QAAAAA=')),
          ],
        );

        // Assert
        SolanaStakeDelegateInstruction expectedSolanaStakeDelegateInstruction = const SolanaStakeDelegateInstruction(
          clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
          programId: 'Stake11111111111111111111111111111111111111',
          stakeAuthority: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
          stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
          stakeConfigAccount: 'StakeConfig11111111111111111111111111111111',
          stakeHistorySysvar: 'SysvarStakeHistory1111111111111111111111111',
          voteAccount: 'FwR3PbjS5iyqzLiLugrBqKSa5EKZ4vK9SKs7eQXtT59f',
        );

        expect(actualSolanaStakeDelegateInstruction, expectedSolanaStakeDelegateInstruction);
      });

      test('Should [return SolanaStakeDeactivateInstruction] from serialized SolanaStakeDeactivateInstruction', () {
        // Act
        ASolanaInstructionDecoded actualSolanaStakeDeactivateInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List.fromList(<int>[1, 4, 0]), data: Uint8List.fromList(<int>[5, 0, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('rpH5txy8M7bxBPIjkHpFrfq04cryOKnpH2SiPswoAmM=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
          ],
        );

        // Assert
        SolanaStakeDeactivateInstruction expectedSolanaStakeDeactivateInstruction = const SolanaStakeDeactivateInstruction(
          programId: 'Stake11111111111111111111111111111111111111',
          clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
          stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
          stakeAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        );

        expect(actualSolanaStakeDeactivateInstruction, expectedSolanaStakeDeactivateInstruction);
      });

      test('Should [return SolanaStakeWithdrawInstruction] from serialized SolanaStakeWithdrawInstruction', () {
        // Act
        ASolanaInstructionDecoded actualSolanaStakeWithdrawInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
              programIdIndex: 3,
              accounts: Uint8List.fromList(<int>[1, 0, 4, 5, 0]),
              data: Uint8List.fromList(<int>[4, 0, 0, 0, 128, 159, 189, 59, 0, 0, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('rpH5txy8M7bxBPIjkHpFrfq04cryOKnpH2SiPswoAmM=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxk1hND+7ZuzQx0TIGvlRCgbV7hWbMU3X/QAAAA=')),
          ],
        );

        // Assert
        SolanaStakeWithdrawInstruction expectedSolanaStakeWithdrawInstruction = SolanaStakeWithdrawInstruction(
          clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
          destination: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
          programId: 'Stake11111111111111111111111111111111111111',
          lamports: BigInt.from(1002282880),
          stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
          stakeHistorySysvar: 'SysvarStakeHistory1111111111111111111111111',
          withdrawAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        );

        expect(actualSolanaStakeWithdrawInstruction, expectedSolanaStakeWithdrawInstruction);
      });

      test('Should [return SolanaUnknownInstruction] from serialized stake instruction with an unknown tag', () {
        // Act
        ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List.fromList(<int>[1, 4, 0]), data: Uint8List.fromList(<int>[1, 0, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('rpH5txy8M7bxBPIjkHpFrfq04cryOKnpH2SiPswoAmM=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
          ],
        );

        // Assert
        SolanaUnknownInstruction expectedSolanaUnknownInstruction =
            const SolanaUnknownInstruction(programId: 'Stake11111111111111111111111111111111111111');

        expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
      });
    });
  });

  group('Tests of ASolanaInstructionDecoded.getAmount()', () {
    test('Should [return TokenAmount (0)] from 0 lamports', () {
      // Arrange
      SolanaSystemTransferInstruction actualSolanaSystemTransferInstruction = SolanaSystemTransferInstruction(
        programId: '11111111111111111111111111111111',
        source: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        destination: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        lamports: BigInt.from(0),
      );

      // Act
      TokenAmount? actualTokenAmount = actualSolanaSystemTransferInstruction.getAmount();

      // Assert
      TokenAmount expectedTokenAmount = TokenAmount(denomination: 'SOL', amount: Decimal.fromInt(0));

      expect(actualTokenAmount, expectedTokenAmount);
    });

    test('Should [return TokenAmount] from an arbitrary amount of lamports', () {
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
      TokenAmount expectedTokenAmount = TokenAmount(denomination: 'SOL', amount: Decimal.parse('0.1'));

      expect(actualTokenAmount, expectedTokenAmount);
    });

    test('Should [return TokenAmount (0)] from 0 tokens', () {
      // Arrange
      SolanaTokenTransferCheckedInstruction actualSolanaTokenTransferCheckedInstruction = SolanaTokenTransferCheckedInstruction(
        programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
        destination: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
        amount: BigInt.from(0),
        mint: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
        authority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        decimals: 6,
      );

      // Act
      TokenAmount? actualTokenAmount = actualSolanaTokenTransferCheckedInstruction.getAmount();

      // Assert
      TokenAmount expectedTokenAmount = TokenAmount(denomination: '', amount: Decimal.fromInt(0));

      expect(actualTokenAmount, expectedTokenAmount);
    });

    test('Should [return TokenAmount] from an arbitrary amount of tokens', () {
      // Arrange
      SolanaTokenTransferCheckedInstruction actualSolanaTokenTransferCheckedInstruction = SolanaTokenTransferCheckedInstruction(
        programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
        destination: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
        amount: BigInt.from(1000000),
        mint: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
        authority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        decimals: 6,
      );

      // Act
      TokenAmount? actualTokenAmount = actualSolanaTokenTransferCheckedInstruction.getAmount();

      // Assert
      TokenAmount expectedTokenAmount = TokenAmount(denomination: '', amount: Decimal.fromInt(1));

      expect(actualTokenAmount, expectedTokenAmount);
    });

    test('Should [return null] from an instruction with undefined amount and lamports', () {
      // Arrange
      SolanaComputeBudgetUnitLimitInstruction actualSolanaComputeBudgetUnitSetComputeLimitInstruction = const SolanaComputeBudgetUnitLimitInstruction(
        discriminator: 2,
        programId: 'ComputeBudget111111111111111111111111111111',
        units: 495,
      );

      // Act
      TokenAmount? actualTokenAmount = actualSolanaComputeBudgetUnitSetComputeLimitInstruction.getAmount();

      // Assert
      expect(actualTokenAmount, null);
    });
  });

  group('Tests of ASolanaInstructionDecoded.getMintAddress()', () {
    test('Should [return mint address] from an instruction WITH mint', () {
      // Arrange
      SolanaTokenTransferCheckedInstruction actualASolanaInstructionDecoded = SolanaTokenTransferCheckedInstruction(
        programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
        destination: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
        amount: BigInt.from(1000000),
        mint: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
        authority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        decimals: 6,
      );

      // Act
      String? actualMintAddress = actualASolanaInstructionDecoded.getMintAddress();

      // Assert
      String expectedMintAddress = '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU';

      expect(actualMintAddress, expectedMintAddress);
    });

    test('Should [return null] for an instruction WITHOUT mint', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaComputeBudgetUnitPriceInstruction(
        discriminator: 3,
        programId: 'ComputeBudget111111111111111111111111111111',
        microLamports: 20000000,
      );

      // Act
      String? actualMintAddress = actualASolanaInstructionDecoded.getMintAddress();

      // Assert
      String? expectedMintAddress;

      expect(actualMintAddress, expectedMintAddress);
    });
  });

  group('Tests of ASolanaInstructionDecoded.getSenderAddress()', () {
    test('Should [return stakeAuthority as SENDER ADDRESS] from a SolanaStakeDeactivateInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaStakeDeactivateInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
        stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        stakeAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSenderAddress();

      // Assert
      String expectedSenderAddress = '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return stakeAuthority as SENDER ADDRESS] from a SolanaStakeDelegateInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaStakeDelegateInstruction(
        clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
        programId: 'Stake11111111111111111111111111111111111111',
        stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
        stakeAuthority: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        stakeConfigAccount: 'StakeConfig11111111111111111111111111111111',
        stakeHistorySysvar: 'SysvarStakeHistory1111111111111111111111111',
        voteAccount: 'FwR3PbjS5iyqzLiLugrBqKSa5EKZ4vK9SKs7eQXtT59f',
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSenderAddress();

      // Assert
      String? expectedSenderAddress = '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return STAKER as SENDER ADDRESS] from a SolanaStakeInitializeInstruction', () {
      // Arrange
      SolanaStakeInitializeInstruction actualASolanaInstructionDecoded = const SolanaStakeInitializeInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        custodian: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        epoch: 0,
        rentSysvar: 'SysvarRent111111111111111111111111111111111',
        stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
        staker: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        unixTimestamp: 0,
        withdrawer: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSenderAddress();

      // Assert
      String? expectedSenderAddress = '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return stakeAccount as SENDER ADDRESS] from a SolanaStakeWithdrawInstruction', () {
      // Arrange
      SolanaStakeWithdrawInstruction actualASolanaInstructionDecoded = SolanaStakeWithdrawInstruction(
        clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
        destination: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        programId: 'Stake11111111111111111111111111111111111111',
        lamports: BigInt.from(1002282880),
        stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        stakeHistorySysvar: 'SysvarStakeHistory1111111111111111111111111',
        withdrawAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSenderAddress();

      // Assert
      String? expectedSenderAddress = 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return source as SENDER ADDRESS] from a SolanaSystemTransferInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = SolanaSystemTransferInstruction(
        programId: '11111111111111111111111111111111',
        source: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        destination: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        lamports: BigInt.from(1000000000),
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSenderAddress();

      // Assert
      String? expectedSenderAddress = '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return source as SENDER ADDRESS] from a SolanaTokenTransferCheckedInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = SolanaTokenTransferCheckedInstruction(
        programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
        destination: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
        amount: BigInt.from(1000000),
        mint: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
        authority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        decimals: 6,
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSenderAddress();

      // Assert
      String? expectedSenderAddress = '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return NULL] for an instruction WITHOUT source, stakeAccount, stakeAuthority or staker', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaComputeBudgetUnitPriceInstruction(
        discriminator: 3,
        programId: 'ComputeBudget111111111111111111111111111111',
        microLamports: 20000000,
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSenderAddress();

      // Assert
      String? expectedSenderAddress;

      expect(actualSenderAddress, expectedSenderAddress);
    });
  });

  group('Tests of ASolanaInstructionDecoded.getRecipientAddress()', () {
    test('Should [return stakeAccount as RECIPIENT ADDRESS] from a SolanaStakeDeactivateInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaStakeDeactivateInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
        stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        stakeAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
      );

      // Act
      String? actualRecipientAddress = actualASolanaInstructionDecoded.getRecipientAddress();

      // Assert
      String expectedRecipientAddress = 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k';

      expect(actualRecipientAddress, expectedRecipientAddress);
    });

    test('Should [return stakeAccount as RECIPIENT ADDRESS] from a SolanaStakeDelegateInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaStakeDelegateInstruction(
        clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
        programId: 'Stake11111111111111111111111111111111111111',
        stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
        stakeAuthority: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        stakeConfigAccount: 'StakeConfig11111111111111111111111111111111',
        stakeHistorySysvar: 'SysvarStakeHistory1111111111111111111111111',
        voteAccount: 'FwR3PbjS5iyqzLiLugrBqKSa5EKZ4vK9SKs7eQXtT59f',
      );

      // Act
      String? actualRecipientAddress = actualASolanaInstructionDecoded.getRecipientAddress();

      // Assert
      String? expectedRecipientAddress = 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR';

      expect(actualRecipientAddress, expectedRecipientAddress);
    });

    test('Should [return stakeAccount as RECIPIENT ADDRESS] from a SolanaStakeInitializeInstruction', () {
      // Arrange
      SolanaStakeInitializeInstruction actualASolanaInstructionDecoded = const SolanaStakeInitializeInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        custodian: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        epoch: 0,
        rentSysvar: 'SysvarRent111111111111111111111111111111111',
        stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
        staker: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        unixTimestamp: 0,
        withdrawer: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
      );

      // Act
      String? actualRecipientAddress = actualASolanaInstructionDecoded.getRecipientAddress();

      // Assert
      String? expectedRecipientAddress = 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR';

      expect(actualRecipientAddress, expectedRecipientAddress);
    });

    test('Should [return destination as RECIPIENT ADDRESS] from a SolanaStakeWithdrawInstruction', () {
      // Arrange
      SolanaStakeWithdrawInstruction actualASolanaInstructionDecoded = SolanaStakeWithdrawInstruction(
        clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
        destination: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        programId: 'Stake11111111111111111111111111111111111111',
        lamports: BigInt.from(1002282880),
        stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        stakeHistorySysvar: 'SysvarStakeHistory1111111111111111111111111',
        withdrawAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
      );

      // Act
      String? actualRecipientAddress = actualASolanaInstructionDecoded.getRecipientAddress();

      // Assert
      String? expectedRecipientAddress = '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19';

      expect(actualRecipientAddress, expectedRecipientAddress);
    });

    test('Should [return destination as RECIPIENT ADDRESS] from a SolanaSystemTransferInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = SolanaSystemTransferInstruction(
        programId: '11111111111111111111111111111111',
        source: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        destination: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        lamports: BigInt.from(1000000000),
      );

      // Act
      String? actualRecipientAddress = actualASolanaInstructionDecoded.getRecipientAddress();

      // Assert
      String? expectedRecipientAddress = '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z';

      expect(actualRecipientAddress, expectedRecipientAddress);
    });

    test('Should [return destination as RECIPIENT ADDRESS] from a SolanaTokenTransferCheckedInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = SolanaTokenTransferCheckedInstruction(
        programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
        destination: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
        amount: BigInt.from(1000000),
        mint: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
        authority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        decimals: 6,
      );

      // Act
      String? actualRecipientAddress = actualASolanaInstructionDecoded.getRecipientAddress();

      // Assert
      String? expectedRecipientAddress = '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP';

      expect(actualRecipientAddress, expectedRecipientAddress);
    });

    test('Should [return NULL] for an instruction WITHOUT destination or stakeAccount', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaComputeBudgetUnitPriceInstruction(
        discriminator: 3,
        programId: 'ComputeBudget111111111111111111111111111111',
        microLamports: 20000000,
      );

      // Act
      String? actualRecipientAddress = actualASolanaInstructionDecoded.getRecipientAddress();

      // Assert
      String? expectedRecipientAddress;

      expect(actualRecipientAddress, expectedRecipientAddress);
    });
  });

  group('Tests of ASolanaInstructionDecoded.getSignerAddress()', () {
    test('Should [return stakeAuthority as SIGNER ADDRESS] from a SolanaStakeDeactivateInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaStakeDeactivateInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
        stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        stakeAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSignerAddress();

      // Assert
      String expectedSenderAddress = '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return stakeAuthority as SIGNER ADDRESS] from a SolanaStakeDelegateInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaStakeDelegateInstruction(
        clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
        programId: 'Stake11111111111111111111111111111111111111',
        stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
        stakeAuthority: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        stakeConfigAccount: 'StakeConfig11111111111111111111111111111111',
        stakeHistorySysvar: 'SysvarStakeHistory1111111111111111111111111',
        voteAccount: 'FwR3PbjS5iyqzLiLugrBqKSa5EKZ4vK9SKs7eQXtT59f',
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSignerAddress();

      // Assert
      String? expectedSenderAddress = '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return staker as SIGNER ADDRESS] from a SolanaStakeInitializeInstruction', () {
      // Arrange
      SolanaStakeInitializeInstruction actualASolanaInstructionDecoded = const SolanaStakeInitializeInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        custodian: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        epoch: 0,
        rentSysvar: 'SysvarRent111111111111111111111111111111111',
        stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
        staker: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        unixTimestamp: 0,
        withdrawer: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSignerAddress();

      // Assert
      String? expectedSenderAddress = '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return withdrawAuthority as SIGNER ADDRESS] from a SolanaStakeWithdrawInstruction', () {
      // Arrange
      SolanaStakeWithdrawInstruction actualASolanaInstructionDecoded = SolanaStakeWithdrawInstruction(
        clockSysvar: 'SysvarC1ock11111111111111111111111111111111',
        destination: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        programId: 'Stake11111111111111111111111111111111111111',
        lamports: BigInt.from(1002282880),
        stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        stakeHistorySysvar: 'SysvarStakeHistory1111111111111111111111111',
        withdrawAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSignerAddress();

      // Assert
      String? expectedSenderAddress = '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return source as SIGNER ADDRESS] from a SolanaSystemTransferInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = SolanaSystemTransferInstruction(
        programId: '11111111111111111111111111111111',
        source: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        destination: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        lamports: BigInt.from(1000000000),
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSignerAddress();

      // Assert
      String? expectedSenderAddress = '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return authority as SIGNER ADDRESS] from a SolanaTokenTransferCheckedInstruction', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = SolanaTokenTransferCheckedInstruction(
        programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
        destination: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
        amount: BigInt.from(1000000),
        mint: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
        authority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        decimals: 6,
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSignerAddress();

      // Assert
      String? expectedSenderAddress = '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19';

      expect(actualSenderAddress, expectedSenderAddress);
    });

    test('Should [return NULL] for an instruction WITHOUT authority, stakeAuthority, withdrawAuthority, staker or source', () {
      // Arrange
      ASolanaInstructionDecoded actualASolanaInstructionDecoded = const SolanaComputeBudgetUnitPriceInstruction(
        discriminator: 3,
        programId: 'ComputeBudget111111111111111111111111111111',
        microLamports: 20000000,
      );

      // Act
      String? actualSenderAddress = actualASolanaInstructionDecoded.getSignerAddress();

      // Assert
      String? expectedSenderAddress;

      expect(actualSenderAddress, expectedSenderAddress);
    });
  });
}
