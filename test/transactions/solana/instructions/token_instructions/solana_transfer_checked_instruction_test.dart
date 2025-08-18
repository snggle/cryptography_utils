import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaTransferCheckedInstruction.fromSerializedData()', () {
    test('Should [return SolanaTransferCheckedInstruction] from serialized data', () {
      // Act
      SolanaTransferCheckedInstruction actualSolanaTransferCheckedInstruction = SolanaTransferCheckedInstruction.fromSerializedData(
        SolanaCompiledInstruction(
            programIdIndex: 5, accounts: Uint8List.fromList(<int>[2, 3, 1, 0]), data: Uint8List.fromList(<int>[12, 64, 66, 15, 0, 0, 0, 0, 0, 6])),
        <SolanaPubKey>[
          SolanaPubKey.fromBytes(base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=')),
          SolanaPubKey.fromBytes(base64Decode('QcP4RyZsB5mqKLVXbVwJOPUQz1BEAbKAvrz2grGLjSg=')),
          SolanaPubKey.fromBytes(base64Decode('fgTQkptSwcCd6H+RFKHWRBILwGHlUQiXdfuEeaD99kM=')),
          SolanaPubKey.fromBytes(base64Decode('O0Qss5EhV/E6kz0BNCgtAytf/s0Botvxt3kGCN8ALqc=')),
          SolanaPubKey.fromBytes(base64Decode('AwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAA=')),
          SolanaPubKey.fromBytes(base64Decode('Bt324ddloZPZy+FGzut5rBy0he1fWzeROoz1hX7/AKk=')),
        ],
        'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
      );

      // Assert
      SolanaTransferCheckedInstruction expectedSolanaTransferCheckedInstruction = const SolanaTransferCheckedInstruction(
        programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
        destination: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
        amount: 1000000,
        mint: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
        authority: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        decimals: 6,
      );

      expect(actualSolanaTransferCheckedInstruction, expectedSolanaTransferCheckedInstruction);
    });
  });
}
