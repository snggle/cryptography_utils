import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapOkxInstruction.fromSerializedData()', () {
    test('Should [return SolanaSwapOkxInstruction] from serialized data', () {
      // Act
      SolanaSwapOkxInstruction actualSolanaSwapOkxInstruction = SolanaSwapOkxInstruction.fromSerializedData(
          SolanaCompiledInstruction(
              programIdIndex: 9,
              accounts: Uint8List.fromList(<int>[0]),
              data: base64Decode('+MaekeF1h8jhqi1ZAAAAAKIRn+IBAAAARfZbsgEAAAABAAAA4aotWQAAAAABAAAAAQAAAAEAAAAhAQAAAGQAAAAAAAAAAA==')),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');

      // Assert
      SolanaSwapOkxInstruction expectedSolanaSwapOkxInstruction = SolanaSwapOkxInstruction(
        programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        amountIn: BigInt.from(1496165089),
        expectAmountOut: BigInt.from(8097042850),
        minReturn: BigInt.from(7287338565),
      );

      expect(actualSolanaSwapOkxInstruction, expectedSolanaSwapOkxInstruction);
    });
  });
}
