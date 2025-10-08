import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapOkxTob3Instruction.fromSerializedData()', () {
    test('Should [return SolanaSwapOkxTob3Instruction] from serialized data', () {
      // Act
      SolanaSwapOkxTob3Instruction actualSolanaSwapOkxTob3Instruction = SolanaSwapOkxTob3Instruction.fromSerializedData(
          SolanaCompiledInstruction(
              programIdIndex: 9,
              accounts: Uint8List.fromList(<int>[0]),
              data: base64Decode(
                  'Dr8s9o7h4J0Xihe4SAEAAPWSGBsUAAAA4ihrmhMAAAABAAAAF4oXuEgBAAABAAAAAgAAAAEAAABOAQAAAGQBAAAASQEAAABkILOBgDIAAP2aAQAAAAAA')),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapOkxTob3Instruction expectedSolanaSwapOkxTob3Instruction = SolanaSwapOkxTob3Instruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        amountIn: BigInt.from(1411837823511),
        expectAmountOut: BigInt.from(86353941237),
        minReturn: BigInt.from(84195092706),
      );

      expect(actualSolanaSwapOkxTob3Instruction, expectedSolanaSwapOkxTob3Instruction);
    });
  });
}
