import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of StakeDeactivateInstruction.fromSerializedData()', () {
    test('Should [return fromSerializedData] from serialized data', () {
      // Act
      SolanaStakeDeactivateInstruction actualSolanaStakeDeactivateInstruction = SolanaStakeDeactivateInstruction.fromSerializedData(
          SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List.fromList(<int>[1, 4, 0]), data: Uint8List.fromList(<int>[5, 0, 0, 0])),
          <SolanaPubKey>[
            SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
            SolanaPubKey.fromBytes(base64Decode('rpH5txy8M7bxBPIjkHpFrfq04cryOKnpH2SiPswoAmM=')),
            SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqHYF5E3VCqYNDe9/ip6slV/U1yKeHIraKSdwAAAAAA=')),
            SolanaPubKey.fromBytes(base64Decode('BqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAA=')),
          ],
          'Stake11111111111111111111111111111111111111');

      // Assert
      SolanaStakeDeactivateInstruction expectedSolanaStakeDeactivateInstruction = const SolanaStakeDeactivateInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        stakeAccount: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        stakeAuthority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
      );

      expect(actualSolanaStakeDeactivateInstruction, expectedSolanaStakeDeactivateInstruction);
    });
  });
}
