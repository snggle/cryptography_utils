import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SwapInstruction.fromSerializedData()', () {
    test('Should [return SwapInstruction] from serialized data', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          172, 84, 194, 246, 6, 13, 221, 31, 45, 21, 107, 215, 92, 87, 86, 127,
          54, 17, 135, 201, 86, 33, 39, 72, 196, 251, 67, 17, 24, 87, 166, 86
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          86, 119, 52, 88, 117, 244, 136, 22, 187, 234, 99, 229, 71, 144, 204, 202,
          199, 108, 214, 31, 127, 20, 211, 175, 250, 175, 221, 204, 72, 226, 74, 164
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          102, 127, 203, 83, 133, 82, 54, 177, 25, 38, 15, 97, 38, 49, 47, 127,
          3, 35, 152, 210, 194, 188, 144, 233, 19, 33, 180, 204, 126, 216, 215, 36
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          113, 51, 125, 145, 223, 43, 231, 95, 241, 193, 206, 136, 193, 245, 240, 41,
          60, 231, 238, 69, 98, 246, 238, 62, 4, 95, 160, 127, 170, 211, 17, 221
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          138, 139, 188, 197, 234, 104, 155, 81, 239, 18, 123, 207, 63, 240, 177, 35,
          146, 165, 76, 80, 155, 32, 48, 77, 76, 72, 134, 211, 193, 100, 91, 131
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          204, 223, 224, 143, 81, 250, 73, 43, 73, 114, 136, 241, 127, 37, 82, 4,
          206, 2, 176, 209, 223, 246, 207, 5, 187, 44, 34, 142, 253, 209, 237, 44
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          223, 239, 209, 161, 74, 229, 42, 44, 230, 21, 144, 189, 126, 137, 215, 138,
          233, 52, 226, 96, 74, 11, 210, 88, 118, 246, 179, 92, 125, 114, 88, 126
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231,
          188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          4, 121, 213, 91, 242, 49, 192, 110, 238, 116, 197, 110, 206, 104, 21, 7,
          253, 177, 178, 222, 163, 244, 142, 81, 2, 177, 205, 162, 86, 188, 19, 143
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 221, 246, 225, 215, 101, 161, 147, 217, 203, 225, 70, 206, 235, 121, 172,
          28, 180, 133, 237, 95, 91, 55, 145, 58, 140, 245, 133, 126, 255, 0, 169
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          82, 97, 209, 74, 172, 197, 188, 14, 236, 99, 93, 168, 112, 90, 31, 112,
          163, 158, 227, 90, 154, 207, 11, 248, 242, 44, 198, 206, 73, 1, 157, 122
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          140, 151, 37, 143, 78, 36, 137, 241, 187, 61, 16, 41, 20, 142, 13, 131,
          11, 90, 19, 153, 218, 255, 16, 132, 4, 142, 123, 216, 219, 233, 248, 89
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          154, 128, 11, 255, 76, 135, 54, 136, 150, 194, 15, 193, 64, 115, 235, 241,
          203, 90, 163, 117, 254, 129, 254, 77, 189, 200, 43, 164, 223, 183, 94, 120
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          180, 63, 250, 39, 245, 215, 246, 74, 116, 192, 155, 31, 41, 88, 121, 222,
          75, 9, 171, 54, 223, 201, 221, 81, 75, 50, 26, 167, 179, 140, 229, 229
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          231, 74, 217, 108, 227, 101, 159, 211, 19, 81, 0, 40, 75, 247, 120, 4,
          91, 133, 16, 168, 243, 78, 73, 140, 146, 46, 238, 111, 195, 5, 248, 105
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 12, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1]));

      // Act
      ASolanaInstructionDecoded actualSolanaSwapInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction = SolanaCompiledInstruction(programIdIndex: 12, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1]));
      const SolanaSwapInstruction expectedSolanaSwapInstruction =
      SolanaSwapInstruction(
        programId: 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL',
        associatedProgram: '11111111111111111111111111111111',
        signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        tokenProgram: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        recipient: 'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY',
        sender: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaSwapInstruction, expectedSolanaSwapInstruction);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          172, 84, 194, 246, 6, 13, 221, 31, 45, 21, 107, 215, 92, 87, 86, 127,
          54, 17, 135, 201, 86, 33, 39, 72, 196, 251, 67, 17, 24, 87, 166, 86
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          86, 119, 52, 88, 117, 244, 136, 22, 187, 234, 99, 229, 71, 144, 204, 202,
          199, 108, 214, 31, 127, 20, 211, 175, 250, 175, 221, 204, 72, 226, 74, 164
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          102, 127, 203, 83, 133, 82, 54, 177, 25, 38, 15, 97, 38, 49, 47, 127,
          3, 35, 152, 210, 194, 188, 144, 233, 19, 33, 180, 204, 126, 216, 215, 36
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          113, 51, 125, 145, 223, 43, 231, 95, 241, 193, 206, 136, 193, 245, 240, 41,
          60, 231, 238, 69, 98, 246, 238, 62, 4, 95, 160, 127, 170, 211, 17, 221
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          138, 139, 188, 197, 234, 104, 155, 81, 239, 18, 123, 207, 63, 240, 177, 35,
          146, 165, 76, 80, 155, 32, 48, 77, 76, 72, 134, 211, 193, 100, 91, 131
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          204, 223, 224, 143, 81, 250, 73, 43, 73, 114, 136, 241, 127, 37, 82, 4,
          206, 2, 176, 209, 223, 246, 207, 5, 187, 44, 34, 142, 253, 209, 237, 44
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          223, 239, 209, 161, 74, 229, 42, 44, 230, 21, 144, 189, 126, 137, 215, 138,
          233, 52, 226, 96, 74, 11, 210, 88, 118, 246, 179, 92, 125, 114, 88, 126
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231,
          188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          4, 121, 213, 91, 242, 49, 192, 110, 238, 116, 197, 110, 206, 104, 21, 7,
          253, 177, 178, 222, 163, 244, 142, 81, 2, 177, 205, 162, 86, 188, 19, 143
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 221, 246, 225, 215, 101, 161, 147, 217, 203, 225, 70, 206, 235, 121, 172,
          28, 180, 133, 237, 95, 91, 55, 145, 58, 140, 245, 133, 126, 255, 0, 169
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          82, 97, 209, 74, 172, 197, 188, 14, 236, 99, 93, 168, 112, 90, 31, 112,
          163, 158, 227, 90, 154, 207, 11, 248, 242, 44, 198, 206, 73, 1, 157, 122
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          140, 151, 37, 143, 78, 36, 137, 241, 187, 61, 16, 41, 20, 142, 13, 131,
          11, 90, 19, 153, 218, 255, 16, 132, 4, 142, 123, 216, 219, 233, 248, 89
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          154, 128, 11, 255, 76, 135, 54, 136, 150, 194, 15, 193, 64, 115, 235, 241,
          203, 90, 163, 117, 254, 129, 254, 77, 189, 200, 43, 164, 223, 183, 94, 120
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          180, 63, 250, 39, 245, 215, 246, 74, 116, 192, 155, 31, 41, 88, 121, 222,
          75, 9, 171, 54, 223, 201, 221, 81, 75, 50, 26, 167, 179, 140, 229, 229
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          231, 74, 217, 108, 227, 101, 159, 211, 19, 81, 0, 40, 75, 247, 120, 4,
          91, 133, 16, 168, 243, 78, 73, 140, 146, 46, 238, 111, 195, 5, 248, 105
        ])),
      ];
      SolanaCompiledInstruction actualSolanaInstruction =
      SolanaCompiledInstruction(programIdIndex: 12, accounts: Uint8List.fromList(<int>[0, 4]), data: Uint8List.fromList(<int>[1]));
      String actualProgramId = actualAccountKeys[actualSolanaInstruction.programIdIndex].toBase58();

      expect(() => SolanaSwapInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
