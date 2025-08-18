import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaCreateIdempotentInstruction.fromSerializedData()', () {
    test('Should [return SolanaCreateIdempotentInstruction] from serialized data', () {
      // Act
      SolanaCreateIdempotentInstruction actualSolanaCreateIdempotentInstruction = SolanaCreateIdempotentInstruction.fromSerializedData(
        SolanaCompiledInstruction(programIdIndex: 12, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1])),
        <SolanaPubKey>[
          SolanaPubKey.fromBytes(base64Decode('rFTC9gYN3R8tFWvXXFdWfzYRh8lWISdIxPtDERhXplY=')),
          SolanaPubKey.fromBytes(base64Decode('Vnc0WHX0iBa76mPlR5DMysds1h9/FNOv+q/dzEjiSqQ=')),
          SolanaPubKey.fromBytes(base64Decode('Zn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yQ=')),
          SolanaPubKey.fromBytes(base64Decode('cTN9kd8r51/xwc6IwfXwKTzn7kVi9u4+BF+gf6rTEd0=')),
          SolanaPubKey.fromBytes(base64Decode('iou8xepom1HvEnvPP/CxI5KlTFCbIDBNTEiG08FkW4M=')),
          SolanaPubKey.fromBytes(base64Decode('zN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Sw=')),
          SolanaPubKey.fromBytes(base64Decode('3+/RoUrlKizmFZC9fonXiuk04mBKC9JYdvazXH1yWH4=')),
          SolanaPubKey.fromBytes(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('BHnVW/IxwG7udMVuzmgVB/2xst6j9I5RArHNola8E48=')),
          SolanaPubKey.fromBytes(base64Decode('Bt324ddloZPZy+FGzut5rBy0he1fWzeROoz1hX7/AKk=')),
          SolanaPubKey.fromBytes(base64Decode('UmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXo=')),
          SolanaPubKey.fromBytes(base64Decode('jJclj04kifG7PRApFI4NgwtaE5na/xCEBI572Nvp+Fk=')),
          SolanaPubKey.fromBytes(base64Decode('moAL/0yHNoiWwg/BQHPr8ctao3X+gf5NvcgrpN+3Xng=')),
          SolanaPubKey.fromBytes(base64Decode('tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5eU=')),
          SolanaPubKey.fromBytes(base64Decode('50rZbONln9MTUQAoS/d4BFuFEKjzTkmMki7ub8MF+Gk=')),
        ],
        'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL',
      );

      // Assert
      SolanaCreateIdempotentInstruction expectedSolanaCreateIdempotentInstruction = const SolanaCreateIdempotentInstruction(
        programId: 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL',
        systemProgram: '11111111111111111111111111111111',
        wallet: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        tokenProgram: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        account: 'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY',
        source: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
      );

      expect(actualSolanaCreateIdempotentInstruction, expectedSolanaCreateIdempotentInstruction);
    });
  });
}
