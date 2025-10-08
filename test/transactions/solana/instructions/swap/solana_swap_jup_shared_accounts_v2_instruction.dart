import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapJupSharedAccountsV2Instruction.fromSerializedData()', () {
    test('Should [return SolanaSwapJupSharedAccountsV2Instruction] from serialized data', () {
      // Act
      SolanaSwapJupSharedAccountsV2Instruction actualSolanaSwapJupSharedAccountsV2Instruction =
          SolanaSwapJupSharedAccountsV2Instruction.fromSerializedData(
              SolanaCompiledInstruction(
                  programIdIndex: 9,
                  accounts: Uint8List.fromList(<int>[0]),
                  data: base64Decode('0ZhTk3z+2OkLABCl1OgAAADOwi86AAAAAGQADAAAAAQAAABpECcAAVYA/pABAQRWAP6QAQEEXwDwIwEE')),
              <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
              'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapJupSharedAccountsV2Instruction expectedSolanaSwapJupSharedAccountsV2Instruction = SolanaSwapJupSharedAccountsV2Instruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        inAmount: BigInt.from(1000000000000),
        quotedOutAmount: BigInt.from(976208590),
        slippageBps: 100,
        platformFeeBps: 12,
        positiveSlippageBps: 0,
      );

      expect(actualSolanaSwapJupSharedAccountsV2Instruction, expectedSolanaSwapJupSharedAccountsV2Instruction);
    });
  });
}
