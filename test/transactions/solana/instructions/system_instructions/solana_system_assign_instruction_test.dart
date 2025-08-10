import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SystemAssignInstruction.fromSerializedData()', () {
    test('Should [return SystemAssignInstruction] from serialized data', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31,
          115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          195, 63, 28, 187, 72, 235, 75, 193, 173, 239, 89, 115, 150, 66, 143, 83,
          34, 240, 119, 117, 170, 252, 157, 137, 90, 58, 81, 159, 221, 210, 42, 150
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231,
          188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178,
          85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 25, 44, 92, 81, 33, 140, 201, 76, 61, 74, 241, 127,
          88, 218, 238, 8, 155, 161, 253, 68, 227, 219, 217, 138, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          221, 244, 42, 4, 128, 10, 84, 222, 46, 88, 63, 148, 241, 123, 8, 151,
          37, 183, 114, 209, 51, 53, 38, 39, 18, 65, 83, 39, 118, 210, 255, 198
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 24, 199, 116, 201, 40, 86, 99, 152, 105, 29, 94, 182,
          139, 94, 184, 163, 155, 75, 109, 92, 115, 85, 91, 33, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 25, 53, 132, 208, 254, 237, 155, 179, 67, 29, 19, 32,
          107, 229, 68, 40, 27, 87, 184, 86, 108, 197, 55, 95, 244, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 161, 216, 23, 165, 2, 5, 11, 104, 7, 145, 230, 206, 109, 184, 142,
          30, 91, 113, 80, 246, 31, 198, 121, 10, 78, 180, 209, 0, 0, 0, 0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction = SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List.fromList(<int>[0, 1]), data: Uint8List.fromList(<int>[3, 0, 0, 0, 81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92, 7, 0, 0, 0, 0, 0, 0, 0, 115, 116, 97, 107, 101, 58, 48, 200, 8, 153, 59, 0, 0, 0, 0, 200, 0, 0, 0, 0, 0, 0, 0, 6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178, 85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0]));
      String actualProgramId = actualAccountKeys[actualSolanaCompiledInstruction.programIdIndex].toBase58();

      // Act
      SolanaSystemAssignInstruction actualSolanaSystemAssignInstruction = SolanaSystemAssignInstruction.fromSerializedData(actualSolanaCompiledInstruction, actualAccountKeys, actualProgramId);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction = SolanaCompiledInstruction(
        programIdIndex: 3,
        accounts: Uint8List.fromList(<int>[0, 1]),
        data: Uint8List.fromList(<int>[
          3, 0, 0, 0,
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92,
          7, 0, 0, 0, 0, 0, 0, 0,
          115, 116, 97, 107, 101, 58, 48,
          200, 8, 153, 59, 0, 0, 0, 0,
          200, 0, 0, 0, 0, 0, 0, 0,
          6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178, 85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0
        ]),
      );
      const SolanaSystemAssignInstruction expectedSolanaSystemAssignInstruction =
      SolanaSystemAssignInstruction(
        programId: '11111111111111111111111111111111',
        signer: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        recipient: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaSystemAssignInstruction, expectedSolanaSystemAssignInstruction);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31,
          115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          195, 63, 28, 187, 72, 235, 75, 193, 173, 239, 89, 115, 150, 66, 143, 83,
          34, 240, 119, 117, 170, 252, 157, 137, 90, 58, 81, 159, 221, 210, 42, 150
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231,
          188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178,
          85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 25, 44, 92, 81, 33, 140, 201, 76, 61, 74, 241, 127,
          88, 218, 238, 8, 155, 161, 253, 68, 227, 219, 217, 138, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          221, 244, 42, 4, 128, 10, 84, 222, 46, 88, 63, 148, 241, 123, 8, 151,
          37, 183, 114, 209, 51, 53, 38, 39, 18, 65, 83, 39, 118, 210, 255, 198
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 24, 199, 116, 201, 40, 86, 99, 152, 105, 29, 94, 182,
          139, 94, 184, 163, 155, 75, 109, 92, 115, 85, 91, 33, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 25, 53, 132, 208, 254, 237, 155, 179, 67, 29, 19, 32,
          107, 229, 68, 40, 27, 87, 184, 86, 108, 197, 55, 95, 244, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 161, 216, 23, 165, 2, 5, 11, 104, 7, 145, 230, 206, 109, 184, 142,
          30, 91, 113, 80, 246, 31, 198, 121, 10, 78, 180, 209, 0, 0, 0, 0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaInstruction = SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List.fromList(<int>[0, 1]), data: Uint8List.fromList(<int>[3, 0, 0]));
      String actualProgramId = actualAccountKeys[actualSolanaInstruction.programIdIndex].toBase58();

      // Assert
      expect(() => SolanaSystemAssignInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
