import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapJupRouteV2Instruction.fromSerializedData()', () {
    test('Should [return SolanaSwapJupRouteV2Instruction] from serialized data', () {
      // Act
      SolanaSwapJupRouteV2Instruction actualSolanaSwapJupRouteV2Instruction = SolanaSwapJupRouteV2Instruction.fromSerializedData(
          SolanaCompiledInstruction(
            programIdIndex: 9,
            accounts: Uint8List.fromList(<int>[0]),
            data: base64Decode('u2T6zDHErxSGZzGlhw0AAFbwqD0AAAAAZAAKAAAAAQAAAGIQJwAB'),
          ),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapJupRouteV2Instruction expectedSolanaSwapJupRouteV2Instruction = SolanaSwapJupRouteV2Instruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        inAmount: BigInt.from(14876243224454),
        quotedOutAmount: BigInt.from(1034481750),
        slippageBps: 100,
        platformFeeBps: 10,
        positiveSlippageBps: 0,
      );

      expect(actualSolanaSwapJupRouteV2Instruction, expectedSolanaSwapJupRouteV2Instruction);
    });
  });
}
