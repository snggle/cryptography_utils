import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapMeteoraDammInstruction.fromSerializedData()', () {
    test('Should [return SolanaSwapMeteoraDammInstruction] from serialized data', () {
      // Act
      SolanaSwapMeteoraDammInstruction actualSolanaSwapMeteoraDammInstruction = SolanaSwapMeteoraDammInstruction.fromSerializedData(
          SolanaCompiledInstruction(
            programIdIndex: 9,
            accounts: Uint8List.fromList(<int>[0]),
            data: base64Decode('+MaekeF1h8gp7WkAAAAAAAEAAAAAAAAA'),
          ),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapMeteoraDammInstruction expectedSolanaSwapMeteoraDammInstruction = SolanaSwapMeteoraDammInstruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        amountIn: BigInt.from(6941993),
        minimumAmountOut: BigInt.from(1),
      );

      expect(actualSolanaSwapMeteoraDammInstruction, expectedSolanaSwapMeteoraDammInstruction);
    });
  });
}
