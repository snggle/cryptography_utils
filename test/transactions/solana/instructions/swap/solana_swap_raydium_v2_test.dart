import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapRaydiumV2Instruction.fromSerializedData()', () {
    test('Should [return SolanaSwapRaydiumV2Instruction] from serialized data', () {
      // Act
      SolanaSwapRaydiumV2Instruction actualSolanaSwapRaydiumV2Instruction = SolanaSwapRaydiumV2Instruction.fromSerializedData(
          SolanaCompiledInstruction(
              programIdIndex: 9,
              accounts: Uint8List.fromList(<int>[0]),
              data: base64Decode('KwTtCxrJHmLAxi0AAAAAADo32f8JAAAAUTsBAAEAAAAAAAAAAAAAAAE=')),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapRaydiumV2Instruction expectedSolanaSwapRaydiumV2Instruction = SolanaSwapRaydiumV2Instruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        amount: BigInt.from(3000000),
        otherAmountThreshold: BigInt.from(42947131194),
        sqrtPriceLimitX64: BigInt.from(4295048017),
        isBaseInput: true,
      );

      expect(actualSolanaSwapRaydiumV2Instruction, expectedSolanaSwapRaydiumV2Instruction);
    });
  });
}
