import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapMeteoraSwap2Instruction.fromSerializedData()', () {
    test('Should [return SolanaSwapMeteoraSwap2Instruction] from serialized data', () {
      // Act
      SolanaSwapMeteoraSwap2Instruction actualSolanaSwapMeteoraSwap2Instruction = SolanaSwapMeteoraSwap2Instruction.fromSerializedData(
          SolanaCompiledInstruction(
            programIdIndex: 9,
            accounts: Uint8List.fromList(<int>[0]),
            data: base64Decode('QUs/TOtbW4geNQmOqpABAOG+bgAAAAAAAQ=='),
          ),
          <SolanaPubKey>[SolanaPubKey.fromBase58('Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapMeteoraSwap2Instruction expectedSolanaSwapMeteoraSwap2Instruction = SolanaSwapMeteoraSwap2Instruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        amount0: BigInt.from(440537178518814),
        amount1: BigInt.from(7257825),
        swapMode: 1,
      );

      expect(actualSolanaSwapMeteoraSwap2Instruction, expectedSolanaSwapMeteoraSwap2Instruction);
    });
  });
}
