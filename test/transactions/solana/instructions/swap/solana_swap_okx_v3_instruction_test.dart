import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapOkxV3Instruction.fromSerializedData()', () {
    test('Should [return SolanaSwapOkxV3Instruction] from serialized data', () {
      // Act
      SolanaSwapOkxV3Instruction actualSolanaSwapOkxV3Instruction = SolanaSwapOkxV3Instruction.fromSerializedData(
          SolanaCompiledInstruction(
              programIdIndex: 9,
              accounts: Uint8List.fromList(<int>[0]),
              data: base64Decode('8OAmIbAf8a+OrX+cAgAAADiyFAAAAAAAPH0UAAAAAAABAAAAjq1/nAIAAAABAAAAAQAAAAEAAABSAQAAAGQgs4EAECeANt9NXF05AA==')),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapOkxV3Instruction expectedSolanaSwapOkxV3Instruction = SolanaSwapOkxV3Instruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        amountIn: BigInt.from(11215547790),
        expectAmountOut: BigInt.from(1356344),
        minReturn: BigInt.from(1342780),
      );

      expect(actualSolanaSwapOkxV3Instruction, expectedSolanaSwapOkxV3Instruction);
    });
  });
}
