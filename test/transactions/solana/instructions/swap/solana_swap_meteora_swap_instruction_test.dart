import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapMeteoraSwapInstruction.fromSerializedData()', () {
    test('Should [return SolanaSwapMeteoraSwapInstruction] from serialized data', () {
      // Act
      SolanaSwapMeteoraSwapInstruction actualSolanaSwapMeteoraSwapInstruction = SolanaSwapMeteoraSwapInstruction.fromSerializedData(
          SolanaCompiledInstruction(
            programIdIndex: 9,
            accounts: Uint8List.fromList(<int>[0]),
            data: base64Decode('+MaekeF1h8gu7DIUAAAAAHbGPokHAAAA'),
          ),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapMeteoraSwapInstruction expectedSolanaSwapMeteoraSwapInstruction = SolanaSwapMeteoraSwapInstruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        amount0: BigInt.from(338881582),
        amount1: BigInt.from(32367363702),
      );

      expect(actualSolanaSwapMeteoraSwapInstruction, expectedSolanaSwapMeteoraSwapInstruction);
    });
  });
}
