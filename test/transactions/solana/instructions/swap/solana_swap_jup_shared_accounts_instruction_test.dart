import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapJupSharedAccountsInstruction.fromSerializedData()', () {
    test('Should [return SolanaSwapJupSharedAccountsInstruction] from serialized data', () {
      // Act
      SolanaSwapJupSharedAccountsInstruction actualSolanaSwapJupSharedAccountsInstruction = SolanaSwapJupSharedAccountsInstruction.fromSerializedData(
          SolanaCompiledInstruction(
              programIdIndex: 9,
              accounts: Uint8List.fromList(<int>[0]),
              data: base64Decode('wSCbM0HWnIEGAgAAADoBZAABOgBkAQIQJwAAAAAAADAGAAAAAAAAMgBQ')),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapJupSharedAccountsInstruction expectedSolanaSwapJupSharedAccountsInstruction = SolanaSwapJupSharedAccountsInstruction(
          programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
          signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
          inAmount: BigInt.from(10000),
          quotedOutAmount: BigInt.from(1584),
          slippageBps: 50,
          platformFeeBps: 80);

      expect(actualSolanaSwapJupSharedAccountsInstruction, expectedSolanaSwapJupSharedAccountsInstruction);
    });
  });
}
