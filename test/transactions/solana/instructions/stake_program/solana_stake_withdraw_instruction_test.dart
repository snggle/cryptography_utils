import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaStakeWithdrawInstruction.fromSerializedData()', () {
    test('Should [return SolanaStakeWithdrawInstruction] from serialized data', () {
      // Act
      SolanaStakeWithdrawInstruction actualSolanaStakeWithdrawInstruction = SolanaStakeWithdrawInstruction.fromSerializedData(
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
        'Stake11111111111111111111111111111111111111',
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
  });
}
