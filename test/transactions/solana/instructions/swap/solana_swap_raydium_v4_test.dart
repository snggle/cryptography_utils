import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaCreateIdempotentInstruction.fromSerializedData()', () {
    test('Should [return SolanaCreateIdempotentInstruction] from serialized data', () {
      const String hexString = '09d8c51d00000000005fa62e0000000000';
      print(base64.encode(HexCodec.decode(hexString)));
      final Uint8List bytes = Uint8List.fromList(HexCodec.decode(hexString));
      print(bytes);
      print(bytes.length);
    });
    test('Should [return SolanaCreateIdempotentInstruction] from serialized data', () {
      SolanaSwapRaydiumInstruction actualSolanaSwapRaydiumInstruction = SolanaSwapRaydiumInstruction.fromSerializedData(
          SolanaCompiledInstruction(programIdIndex: 9, accounts: Uint8List.fromList(<int>[0]), data: base64Decode('CdjFHQAAAAAAX6YuAAAAAAA=')),
          <SolanaPubKey>[SolanaPubKey.fromBase58('CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK')],
          'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK');
    });

    SolanaSwapRaydiumInstruction expectedSolanaSwapRaydiumInstruction = SolanaSwapRaydiumInstruction(
      programId: 'CAMMCzo5YL8w4VFF8KVHrK22GGUsp5VTaW7grrKgrWqK',
      signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
      amountIn: BigInt.from(1951192),
      minimumAmountOut: BigInt.from(3057247),
    );
  });
}
