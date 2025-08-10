import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of TokenTransferInstruction.fromSerializedData()', () {
    test('Should [return TokenTransferInstruction] from serialized data', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          65, 195, 248, 71, 38, 108, 7, 153, 170, 40, 181, 87, 109, 92, 9, 56, 245, 16, 207, 80, 68, 1, 178, 128, 190, 188, 246, 130, 177, 139, 141, 40
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          126, 4, 208, 146, 155, 82, 193, 192, 157, 232, 127, 145, 20, 161, 214, 68, 18, 11, 192, 97, 229, 81, 8, 151, 117, 251, 132, 121, 160, 253, 246, 67
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          59, 68, 44, 179, 145, 33, 87, 241, 58, 147, 61, 1, 52, 40, 45, 3, 43, 95, 254, 205, 1, 162, 219, 241, 183, 121, 6, 8, 223, 0, 46, 167
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 221, 246, 225, 215, 101, 161, 147, 217, 203, 225, 70, 206, 235, 121, 172, 28, 180, 133, 237, 95, 91, 55, 145, 58, 140, 245, 133, 126, 255, 0, 169
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 5, accounts: Uint8List.fromList(<int>[2, 3, 1, 0]), data: Uint8List.fromList(<int>[12, 64, 66, 15, 0, 0, 0, 0, 0, 6]));

      // Act
      ASolanaInstructionDecoded actualSolanaTokenTransferInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 5, accounts: Uint8List.fromList(<int>[2, 3, 1, 0]), data: Uint8List.fromList(<int>[12, 64, 66, 15, 0, 0, 0, 0, 0, 6]));
      const SolanaTokenTransferInstruction expectedSolanaTokenTransferInstruction =
      SolanaTokenTransferInstruction(
        programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        source: '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv',
        delegate: '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP',
        amount: 1000000,
        mint: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
        owner: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        decimals: 6,
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaTokenTransferInstruction, expectedSolanaTokenTransferInstruction);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          65, 195, 248, 71, 38, 108, 7, 153, 170, 40, 181, 87, 109, 92, 9, 56, 245, 16, 207, 80, 68, 1, 178, 128, 190, 188, 246, 130, 177, 139, 141, 40
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          126, 4, 208, 146, 155, 82, 193, 192, 157, 232, 127, 145, 20, 161, 214, 68, 18, 11, 192, 97, 229, 81, 8, 151, 117, 251, 132, 121, 160, 253, 246, 67
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          59, 68, 44, 179, 145, 33, 87, 241, 58, 147, 61, 1, 52, 40, 45, 3, 43, 95, 254, 205, 1, 162, 219, 241, 183, 121, 6, 8, 223, 0, 46, 167
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 221, 246, 225, 215, 101, 161, 147, 217, 203, 225, 70, 206, 235, 121, 172, 28, 180, 133, 237, 95, 91, 55, 145, 58, 140, 245, 133, 126, 255, 0, 169
        ])),
      ];
      SolanaCompiledInstruction actualSolanaInstruction = SolanaCompiledInstruction(
          programIdIndex: 5, accounts: Uint8List(0), data: Uint8List.fromList(<int>[12]));
      String actualProgramId = actualAccountKeys[actualSolanaInstruction.programIdIndex].toBase58();

      expect(() => SolanaTokenTransferInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
