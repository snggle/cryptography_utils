import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ASolanaInstruction.decode()', () {
    test('Should [return SolanaCreateIdempotentInstruction] from serialized SolanaCreateIdempotentInstruction', () {
      // Act
      ASolanaInstructionDecoded actualSolanaCreateIdempotentInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 12, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('rFTC9gYN3R8tFWvXXFdWfzYRh8lWISdIxPtDERhXplY=')),
            SolanaPubKey.fromBytes(base64Decode('Vnc0WHX0iBa76mPlR5DMysds1h9/FNOv+q/dzEjiSqQ=')),
            SolanaPubKey.fromBytes(base64Decode('Zn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yQ=')),
            SolanaPubKey.fromBytes(base64Decode('cTN9kd8r51/xwc6IwfXwKTzn7kVi9u4+BF+gf6rTEd0=')),
            SolanaPubKey.fromBytes(base64Decode('iou8xepom1HvEnvPP/CxI5KlTFCbIDBNTEiG08FkW4M=')),
            SolanaPubKey.fromBytes(base64Decode('zN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Sw=')),
            SolanaPubKey.fromBytes(base64Decode('3+/RoUrlKizmFZC9fonXiuk04mBKC9JYdvazXH1yWH4=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BHnVW/IxwG7udMVuzmgVB/2xst6j9I5RArHNola8E48=')),
            SolanaPubKey.fromBytes(base64Decode('Bt324ddloZPZy+FGzut5rBy0he1fWzeROoz1hX7/AKk=')),
            SolanaPubKey.fromBytes(base64Decode('UmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXo=')),
            SolanaPubKey.fromBytes(base64Decode('jJclj04kifG7PRApFI4NgwtaE5na/xCEBI572Nvp+Fk=')),
            SolanaPubKey.fromBytes(base64Decode('moAL/0yHNoiWwg/BQHPr8ctao3X+gf5NvcgrpN+3Xng=')),
            SolanaPubKey.fromBytes(base64Decode('tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5eU=')),
            SolanaPubKey.fromBytes(base64Decode('50rZbONln9MTUQAoS/d4BFuFEKjzTkmMki7ub8MF+Gk=')),
          ]);

      // Assert
      SolanaCreateIdempotentInstruction expectedSolanaCreateIdempotentInstruction = const SolanaCreateIdempotentInstruction(
        programId: 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL',
        systemProgram: '11111111111111111111111111111111',
        wallet: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        tokenProgram: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        account: 'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY',
        source: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
      );

      expect(actualSolanaCreateIdempotentInstruction, expectedSolanaCreateIdempotentInstruction);
    });

    test('Should [return SolanaUnknownInstruction] from serialized create idempotent instruction with an unknown tag', () {
      // Act
      ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 12, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[2])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('rFTC9gYN3R8tFWvXXFdWfzYRh8lWISdIxPtDERhXplY=')),
            SolanaPubKey.fromBytes(base64Decode('Vnc0WHX0iBa76mPlR5DMysds1h9/FNOv+q/dzEjiSqQ=')),
            SolanaPubKey.fromBytes(base64Decode('Zn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yQ=')),
            SolanaPubKey.fromBytes(base64Decode('cTN9kd8r51/xwc6IwfXwKTzn7kVi9u4+BF+gf6rTEd0=')),
            SolanaPubKey.fromBytes(base64Decode('iou8xepom1HvEnvPP/CxI5KlTFCbIDBNTEiG08FkW4M=')),
            SolanaPubKey.fromBytes(base64Decode('zN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Sw=')),
            SolanaPubKey.fromBytes(base64Decode('3+/RoUrlKizmFZC9fonXiuk04mBKC9JYdvazXH1yWH4=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BHnVW/IxwG7udMVuzmgVB/2xst6j9I5RArHNola8E48=')),
            SolanaPubKey.fromBytes(base64Decode('Bt324ddloZPZy+FGzut5rBy0he1fWzeROoz1hX7/AKk=')),
            SolanaPubKey.fromBytes(base64Decode('UmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXo=')),
            SolanaPubKey.fromBytes(base64Decode('jJclj04kifG7PRApFI4NgwtaE5na/xCEBI572Nvp+Fk=')),
            SolanaPubKey.fromBytes(base64Decode('moAL/0yHNoiWwg/BQHPr8ctao3X+gf5NvcgrpN+3Xng=')),
            SolanaPubKey.fromBytes(base64Decode('tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5eU=')),
            SolanaPubKey.fromBytes(base64Decode('50rZbONln9MTUQAoS/d4BFuFEKjzTkmMki7ub8MF+Gk=')),
          ]);

      // Assert
      SolanaUnknownInstruction expectedSolanaUnknownInstruction =
      const SolanaUnknownInstruction(programId: 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL');

      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

    test('Should [return SolanaUnknownInstruction] from serialized create idempotent instruction with no data (and no tag)', () {
      // Act
      ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 12, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('rFTC9gYN3R8tFWvXXFdWfzYRh8lWISdIxPtDERhXplY=')),
            SolanaPubKey.fromBytes(base64Decode('Vnc0WHX0iBa76mPlR5DMysds1h9/FNOv+q/dzEjiSqQ=')),
            SolanaPubKey.fromBytes(base64Decode('Zn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yQ=')),
            SolanaPubKey.fromBytes(base64Decode('cTN9kd8r51/xwc6IwfXwKTzn7kVi9u4+BF+gf6rTEd0=')),
            SolanaPubKey.fromBytes(base64Decode('iou8xepom1HvEnvPP/CxI5KlTFCbIDBNTEiG08FkW4M=')),
            SolanaPubKey.fromBytes(base64Decode('zN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Sw=')),
            SolanaPubKey.fromBytes(base64Decode('3+/RoUrlKizmFZC9fonXiuk04mBKC9JYdvazXH1yWH4=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BHnVW/IxwG7udMVuzmgVB/2xst6j9I5RArHNola8E48=')),
            SolanaPubKey.fromBytes(base64Decode('Bt324ddloZPZy+FGzut5rBy0he1fWzeROoz1hX7/AKk=')),
            SolanaPubKey.fromBytes(base64Decode('UmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXo=')),
            SolanaPubKey.fromBytes(base64Decode('jJclj04kifG7PRApFI4NgwtaE5na/xCEBI572Nvp+Fk=')),
            SolanaPubKey.fromBytes(base64Decode('moAL/0yHNoiWwg/BQHPr8ctao3X+gf5NvcgrpN+3Xng=')),
            SolanaPubKey.fromBytes(base64Decode('tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5eU=')),
            SolanaPubKey.fromBytes(base64Decode('50rZbONln9MTUQAoS/d4BFuFEKjzTkmMki7ub8MF+Gk=')),
          ]);

      // Assert
      SolanaUnknownInstruction expectedSolanaUnknownInstruction =
      const SolanaUnknownInstruction(programId: 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL');

      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

    test('Should [return SolanaComputeBudgetUnitPriceInstruction] from serialized SolanaComputeBudgetUnitPriceInstruction', () {
      // Act
      ASolanaInstructionDecoded actualSolanaComputeBudgetUnitPriceInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[3, 0, 45, 49, 1, 0, 0, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
            SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
          ]);

      // Assert
      SolanaComputeBudgetUnitPriceInstruction expectedSolanaComputeBudgetUnitPriceInstruction = const SolanaComputeBudgetUnitPriceInstruction(
        programId: 'ComputeBudget111111111111111111111111111111',
        microLamports: 20000000,
      );

      expect(actualSolanaComputeBudgetUnitPriceInstruction, expectedSolanaComputeBudgetUnitPriceInstruction);
    });

    test('Should [return SolanaComputeBudgetUnitLimitInstruction] from serialized SolanaComputeBudgetUnitLimitInstruction', () {
      // Act
      ASolanaInstructionDecoded actualSolanaComputeBudgetUnitLimitInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[2, 239, 1, 0, 0])), <SolanaPubKey>[
        SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
        SolanaPubKey.fromBytes(base64Decode('UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
        SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
        SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
      ]);

      // Assert
      SolanaComputeBudgetUnitLimitInstruction expectedSolanaComputeBudgetUnitLimitInstruction = const SolanaComputeBudgetUnitLimitInstruction(
        programId: 'ComputeBudget111111111111111111111111111111',
        units: 495,
      );

      expect(actualSolanaComputeBudgetUnitLimitInstruction, expectedSolanaComputeBudgetUnitLimitInstruction);
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
          ]);

      // Assert
      SolanaUnknownInstruction expectedSolanaUnknownInstruction =
          const SolanaUnknownInstruction(programId: 'ComputeBudget111111111111111111111111111111');

      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

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
          ]);

      // Assert
      SolanaSystemTransferInstruction expectedSolanaSystemTransferInstruction = const SolanaSystemTransferInstruction(
        programId: '11111111111111111111111111111111',
        source: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        destination: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        lamports: 1000000000,
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
          ]);

      // Assert
      SolanaUnknownInstruction expectedSolanaUnknownInstruction = const SolanaUnknownInstruction(programId: '11111111111111111111111111111111');

      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

    test('Should [return SolanaStakeInitializeInstruction] from serialized SolanaStakeInitializeInstruction', () {
      // Act
      ASolanaInstructionDecoded actualSolanaStakeInitializeInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(
            programIdIndex: 4,
            accounts: Uint8List.fromList(<int>[1, 6, 7, 8, 9, 0]),
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
          ]);

      // Assert
      SolanaStakeInitializeInstruction expectedSolanaStakeInitializeInstruction = const SolanaStakeInitializeInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
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
          ]);

      // Assert
      SolanaStakeDelegateInstruction expectedSolanaStakeDelegateInstruction = const SolanaStakeDelegateInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        stakeAuthority: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
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
          ]);

      // Assert
      SolanaStakeDeactivateInstruction expectedSolanaStakeDeactivateInstruction = const SolanaStakeDeactivateInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
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
          ]);

      // Assert
      SolanaStakeWithdrawInstruction expectedSolanaStakeWithdrawInstruction = const SolanaStakeWithdrawInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        withdrawAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        lamports: 1002282880,
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
          ]);

      // Assert
      SolanaUnknownInstruction expectedSolanaUnknownInstruction =
          const SolanaUnknownInstruction(programId: 'Stake11111111111111111111111111111111111111');

      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

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
          ]);

      // Assert
      SolanaTransferCheckedInstruction expectedSolanaTokenTransferInstruction = const SolanaTransferCheckedInstruction(
        programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
        destination: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
        amount: 1000000,
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
          ]);

      // Assert
      SolanaUnknownInstruction expectedSolanaUnknownInstruction =
          const SolanaUnknownInstruction(programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');

      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

    test('Should [return SolanaInvalidInstruction] from serialized instruction with no account keys', () {
      // Act
      ASolanaInstructionDecoded actualSolanaInvalidInstruction = ASolanaInstructionDecoded.decode(
          SolanaCompiledInstruction(programIdIndex: 11, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1])),
          const <SolanaPubKey>[]);

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
          ]);

      // Assert
      SolanaInvalidInstruction expectedSolanaInvalidInstruction = const SolanaInvalidInstruction();

      expect(actualSolanaInvalidInstruction, expectedSolanaInvalidInstruction);
    });
  });
}
