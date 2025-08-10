import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SystemTransferInstruction.fromSerializedData()', () {
    test('Should [return SystemTransferInstruction] from serialized data', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction = SolanaCompiledInstruction(programIdIndex: 2, accounts: Uint8List.fromList(<int>[0, 1]), data: Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0]));
      String actualProgramId = actualAccountKeys[actualSolanaCompiledInstruction.programIdIndex].toBase58();

      // Act
      SolanaSystemTransferInstruction actualSolanaSystemTransferInstruction = SolanaSystemTransferInstruction.fromSerializedData(actualSolanaCompiledInstruction, actualAccountKeys, actualProgramId);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 2, accounts: Uint8List.fromList(<int>[0, 1]), data: Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0]));
      const SolanaSystemTransferInstruction expectedSolanaSystemTransferInstruction =
      SolanaSystemTransferInstruction(
        programId: '11111111111111111111111111111111',
        sender: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        recipient: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        amount: 1000000000,
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaSystemTransferInstruction, expectedSolanaSystemTransferInstruction);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109,
          45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          174, 145, 249, 183, 28, 188, 51, 182, 241, 4, 242, 35, 144, 122, 69, 173,
          250, 180, 225, 202, 242, 56, 169, 233, 31, 100, 162, 62, 204, 40, 2, 99
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231,
          188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178,
          85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 24, 199, 116, 201, 40, 86, 99, 152, 105, 29, 94, 182,
          139, 94, 184, 163, 155, 75, 109, 92, 115, 85, 91, 33, 0, 0, 0, 0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaInstruction =
      SolanaCompiledInstruction(programIdIndex: 2, accounts: Uint8List.fromList(<int>[0, 1]), data: Uint8List.fromList(<int>[2, 0]));
      String actualProgramId = actualAccountKeys[actualSolanaInstruction.programIdIndex].toBase58();

      // Assert
      expect(() => SolanaSystemTransferInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
