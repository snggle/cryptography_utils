import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSwapDFlowInstruction.fromSerializedData()', () {
    test('Should [return SolanaSwapDFlowInstruction] from serialized data', () {
      // Act
      SolanaSwapDFlowInstruction actualSolanaSwapDFlowInstruction = SolanaSwapDFlowInstruction.fromSerializedData(
          SolanaCompiledInstruction(
            programIdIndex: 9,
            accounts: Uint8List.fromList(<int>[0]),
            data: base64Decode(
                'QUs/TOtbW4gEAAAAJXAoPIUerEPKYTnPGHEG35gEs2bNRMmnS45kUsPrm6wDG/vYEaeo9FOdCo9pz4JeukV2HJri82IKqMXUFCWqcghZwV0WAAAAAHgAAAAjzikAAAAAAAARdAwTAAAAAAABBXe92QEAAAAAAgKBGMR0AQAAAJABAAAF'),
          ),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'DF1ow4tspfHX9JwWJsAb9epbkA8hmpSEAtxXy1V27QBH');

      // Assert
      SolanaSwapDFlowInstruction expectedSolanaSwapDFlowInstruction = SolanaSwapDFlowInstruction(
          programId: 'DF1ow4tspfHX9JwWJsAb9epbkA8hmpSEAtxXy1V27QBH',
          signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
          quotedOutAmount: BigInt.from(6253975681),
          slippageBps: 400,
          platformFeeBps: 0,
          positiveSlippageFeeLimitPct: 5);

      expect(actualSolanaSwapDFlowInstruction, expectedSolanaSwapDFlowInstruction);
    });
  });
}
