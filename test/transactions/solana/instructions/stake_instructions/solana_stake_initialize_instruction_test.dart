import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaStakeInitializeInstruction.fromSerializedData()', () {
    test('Should [return SolanaStakeInitializeInstruction] from serialized data', () {
      // Act
      SolanaStakeInitializeInstruction actualSolanaStakeInitializeInstruction = SolanaStakeInitializeInstruction.fromSerializedData(
        SolanaCompiledInstruction(
            programIdIndex: 4,
            accounts: Uint8List.fromList(<int>[1, 6, 7, 8, 9, 0]),
            data: base64Decode(
                'AAAAAFGYCAVd43XhlRiSq7C4NB9zYy/yP5Zodzow9Mo0zXtcUZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1wAAAAAAAAAAAAAAAAAAAAAUZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1w=')),
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
        'Stake11111111111111111111111111111111111111',
      );

      // Assert
      SolanaStakeInitializeInstruction expectedSolanaStakeInitializeInstruction = const SolanaStakeInitializeInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        stakeAccount: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
      );

      expect(actualSolanaStakeInitializeInstruction, expectedSolanaStakeInitializeInstruction);
    });
  });
}
