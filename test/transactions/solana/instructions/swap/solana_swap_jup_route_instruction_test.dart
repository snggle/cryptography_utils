import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapJupRouteInstruction.fromSerializedData()', () {
    test('Should [return SolanaSwapJupRouteInstruction] from serialized data', () {
      // Act
      SolanaSwapJupRouteInstruction actualSolanaSwapJupRouteInstruction = SolanaSwapJupRouteInstruction.fromSerializedData(
          SolanaCompiledInstruction(
            programIdIndex: 9,
            accounts: Uint8List.fromList(<int>[0]),
            data: base64Decode('5RfLl3rjrSoBAAAAQ2QAAbmU6wMAAAAA0e0AAAAAAAAFAAA='),
          ),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapJupRouteInstruction expectedSolanaSwapJupRouteInstruction = SolanaSwapJupRouteInstruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        inAmount: BigInt.from(65770681),
        quotedOutAmount: BigInt.from(60881),
        slippageBps: 5,
        platformFeeBps: 0,
      );

      expect(actualSolanaSwapJupRouteInstruction, expectedSolanaSwapJupRouteInstruction);
    });
  });
}
