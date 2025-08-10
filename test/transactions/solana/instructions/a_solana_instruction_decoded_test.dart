import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ASolanaInstruction.decode()', () {
    test('Should [return SolanaComputeBudgetUnitPriceInstruction] - testing _decodeComputeBudgetProgram() -> SolanaComputeBudgetUnitPriceInstruction.fromSerializedData()', () {
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
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[3, 0, 45, 49, 1, 0, 0, 0, 0]));

      // Act
      ASolanaInstructionDecoded actualSolanaComputeBudgetUnitPriceInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[3, 0, 45, 49, 1, 0, 0, 0, 0]));
      const SolanaComputeBudgetUnitPriceInstruction expectedSolanaComputeBudgetUnitPriceInstruction =
      SolanaComputeBudgetUnitPriceInstruction(
        programId: 'ComputeBudget111111111111111111111111111111',
        unitPrice: 20000000,
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaComputeBudgetUnitPriceInstruction, expectedSolanaComputeBudgetUnitPriceInstruction);
    });

    test('Should [return SolanaComputeBudgetUnitLimitInstruction] - testing _decodeComputeBudgetProgram() -> SolanaComputeBudgetUnitLimitInstruction.fromSerializedData()', () {
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
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[2, 239, 1, 0, 0]));

      // Act
      ASolanaInstructionDecoded actualSolanaComputeBudgetUnitLimitInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[2, 239, 1, 0, 0]));
      const SolanaComputeBudgetUnitLimitInstruction expectedSolanaComputeBudgetUnitLimitInstruction =
      SolanaComputeBudgetUnitLimitInstruction(
        programId: 'ComputeBudget111111111111111111111111111111',
        unitLimit: 495,
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaComputeBudgetUnitLimitInstruction, expectedSolanaComputeBudgetUnitLimitInstruction);
    });

    test('Should [return SolanaUnknownInstruction] - testing _decodeComputeBudgetProgram() with unknown instruction tag', () {
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
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[1, 0, 45, 49, 1, 0, 0, 0, 0]));

      // Act
      ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[1, 0, 45, 49, 1, 0, 0, 0, 0]));
      const SolanaUnknownInstruction expectedSolanaUnknownInstruction =
      SolanaUnknownInstruction(programId: 'ComputeBudget111111111111111111111111111111');

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

    test('Should [return SolanaSystemTransferInstruction] - testing _decodeSystemProgram() -> SolanaSystemTransferInstruction.fromSerializedData()', () {
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
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 2, accounts: Uint8List.fromList(<int>[0, 1]), data: Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0]));

      // Act
      ASolanaInstructionDecoded actualSolanaSystemTransferInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

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

    test('Should [return SolanaSystemAssignInstruction] - testing _decodeSystemProgram() -> SolanaSystemAssignInstruction.fromSerializedData()', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x51, 0x98, 0x8, 0x5, 0x5d, 0xe3, 0x75, 0xe1, 0x95, 0x18, 0x92, 0xab, 0xb0, 0xb8, 0x34, 0x1f, 0x73, 0x63, 0x2f, 0xf2, 0x3f, 0x96, 0x68, 0x77, 0x3a, 0x30, 0xf4, 0xca, 0x34, 0xcd, 0x7b, 0x5c
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0xc3, 0x3f, 0x1c, 0xbb, 0x48, 0xeb, 0x4b, 0xc1, 0xad, 0xef, 0x59, 0x73, 0x96, 0x42, 0x8f, 0x53, 0x22, 0xf0, 0x77, 0x75, 0xaa, 0xfc, 0x9d, 0x89, 0x5a, 0x3a, 0x51, 0x9f, 0xdd, 0xd2, 0x2a, 0x96
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x3, 0x6, 0x46, 0x6f, 0xe5, 0x21, 0x17, 0x32, 0xff, 0xec, 0xad, 0xba, 0x72, 0xc3, 0x9b, 0xe7, 0xbc, 0x8c, 0xe5, 0xbb, 0xc5, 0xf7, 0x12, 0x6b, 0x2c, 0x43, 0x9b, 0x3a, 0x40, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa1, 0xd8, 0x17, 0x91, 0x37, 0x54, 0x2a, 0x98, 0x34, 0x37, 0xbd, 0xfe, 0x2a, 0x7a, 0xb2, 0x55, 0x7f, 0x53, 0x5c, 0x8a, 0x78, 0x72, 0x2b, 0x68, 0xa4, 0x9d, 0xc0, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x19, 0x2c, 0x5c, 0x51, 0x21, 0x8c, 0xc9, 0x4c, 0x3d, 0x4a, 0xf1, 0x7f, 0x58, 0xda, 0xee, 0x8, 0x9b, 0xa1, 0xfd, 0x44, 0xe3, 0xdb, 0xd9, 0x8a, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0xdd, 0xf4, 0x2a, 0x4, 0x80, 0xa, 0x54, 0xde, 0x2e, 0x58, 0x3f, 0x94, 0xf1, 0x7b, 0x8, 0x97, 0x25, 0xb7, 0x72, 0xd1, 0x33, 0x35, 0x26, 0x27, 0x12, 0x41, 0x53, 0x27, 0x76, 0xd2, 0xff, 0xc6
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x18, 0xc7, 0x74, 0xc9, 0x28, 0x56, 0x63, 0x98, 0x69, 0x1d, 0x5e, 0xb6, 0x8b, 0x5e, 0xb8, 0xa3, 0x9b, 0x4b, 0x6d, 0x5c, 0x73, 0x55, 0x5b, 0x21, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x19, 0x35, 0x84, 0xd0, 0xfe, 0xed, 0x9b, 0xb3, 0x43, 0x1d, 0x13, 0x20, 0x6b, 0xe5, 0x44, 0x28, 0x1b, 0x57, 0xb8, 0x56, 0x6c, 0xc5, 0x37, 0x5f, 0xf4, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa1, 0xd8, 0x17, 0xa5, 0x2, 0x5, 0xb, 0x68, 0x7, 0x91, 0xe6, 0xce, 0x6d, 0xb8, 0x8e, 0x1e, 0x5b, 0x71, 0x50, 0xf6, 0x1f, 0xc6, 0x79, 0xa, 0x4e, 0xb4, 0xd1, 0x0, 0x0, 0x0, 0x0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction = SolanaCompiledInstruction(
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

      // Act
      ASolanaInstructionDecoded actualSolanaSystemAssignInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

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

    test('Should [return SolanaUnknownInstruction] - testing _decodeSystemProgram() with unknown instruction tag', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x51, 0x98, 0x8, 0x5, 0x5d, 0xe3, 0x75, 0xe1, 0x95, 0x18, 0x92, 0xab, 0xb0, 0xb8, 0x34, 0x1f, 0x73, 0x63, 0x2f, 0xf2, 0x3f, 0x96, 0x68, 0x77, 0x3a, 0x30, 0xf4, 0xca, 0x34, 0xcd, 0x7b, 0x5c
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0xc3, 0x3f, 0x1c, 0xbb, 0x48, 0xeb, 0x4b, 0xc1, 0xad, 0xef, 0x59, 0x73, 0x96, 0x42, 0x8f, 0x53, 0x22, 0xf0, 0x77, 0x75, 0xaa, 0xfc, 0x9d, 0x89, 0x5a, 0x3a, 0x51, 0x9f, 0xdd, 0xd2, 0x2a, 0x96
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x3, 0x6, 0x46, 0x6f, 0xe5, 0x21, 0x17, 0x32, 0xff, 0xec, 0xad, 0xba, 0x72, 0xc3, 0x9b, 0xe7, 0xbc, 0x8c, 0xe5, 0xbb, 0xc5, 0xf7, 0x12, 0x6b, 0x2c, 0x43, 0x9b, 0x3a, 0x40, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa1, 0xd8, 0x17, 0x91, 0x37, 0x54, 0x2a, 0x98, 0x34, 0x37, 0xbd, 0xfe, 0x2a, 0x7a, 0xb2, 0x55, 0x7f, 0x53, 0x5c, 0x8a, 0x78, 0x72, 0x2b, 0x68, 0xa4, 0x9d, 0xc0, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x19, 0x2c, 0x5c, 0x51, 0x21, 0x8c, 0xc9, 0x4c, 0x3d, 0x4a, 0xf1, 0x7f, 0x58, 0xda, 0xee, 0x8, 0x9b, 0xa1, 0xfd, 0x44, 0xe3, 0xdb, 0xd9, 0x8a, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0xdd, 0xf4, 0x2a, 0x4, 0x80, 0xa, 0x54, 0xde, 0x2e, 0x58, 0x3f, 0x94, 0xf1, 0x7b, 0x8, 0x97, 0x25, 0xb7, 0x72, 0xd1, 0x33, 0x35, 0x26, 0x27, 0x12, 0x41, 0x53, 0x27, 0x76, 0xd2, 0xff, 0xc6
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x18, 0xc7, 0x74, 0xc9, 0x28, 0x56, 0x63, 0x98, 0x69, 0x1d, 0x5e, 0xb6, 0x8b, 0x5e, 0xb8, 0xa3, 0x9b, 0x4b, 0x6d, 0x5c, 0x73, 0x55, 0x5b, 0x21, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x19, 0x35, 0x84, 0xd0, 0xfe, 0xed, 0x9b, 0xb3, 0x43, 0x1d, 0x13, 0x20, 0x6b, 0xe5, 0x44, 0x28, 0x1b, 0x57, 0xb8, 0x56, 0x6c, 0xc5, 0x37, 0x5f, 0xf4, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa1, 0xd8, 0x17, 0xa5, 0x2, 0x5, 0xb, 0x68, 0x7, 0x91, 0xe6, 0xce, 0x6d, 0xb8, 0x8e, 0x1e, 0x5b, 0x71, 0x50, 0xf6, 0x1f, 0xc6, 0x79, 0xa, 0x4e, 0xb4, 0xd1, 0x0, 0x0, 0x0, 0x0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction = SolanaCompiledInstruction(
        programIdIndex: 3,
        accounts: Uint8List.fromList(<int>[0, 1]),
        data: Uint8List.fromList(<int>[
          1, 0, 0, 0,
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92,
          7, 0, 0, 0, 0, 0, 0, 0,
          115, 116, 97, 107, 101, 58, 48,
          200, 8, 153, 59, 0, 0, 0, 0,
          200, 0, 0, 0, 0, 0, 0, 0,
          6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178, 85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0
        ]),
      );

      // Act
      ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction = SolanaCompiledInstruction(
        programIdIndex: 3,
        accounts: Uint8List.fromList(<int>[0, 1]),
        data: Uint8List.fromList(<int>[
          1, 0, 0, 0,
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92,
          7, 0, 0, 0, 0, 0, 0, 0,
          115, 116, 97, 107, 101, 58, 48,
          200, 8, 153, 59, 0, 0, 0, 0,
          200, 0, 0, 0, 0, 0, 0, 0,
          6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178, 85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0
        ]),
      );
      const SolanaUnknownInstruction expectedSolanaUnknownInstruction =
      SolanaUnknownInstruction(programId: '11111111111111111111111111111111');

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

    test('Should [return SolanaStakeInitializeInstruction] - testing _decodeStakeProgram() -> SolanaStakeInitializeInstruction.fromSerializedData()', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x51, 0x98, 0x8, 0x5, 0x5d, 0xe3, 0x75, 0xe1, 0x95, 0x18, 0x92, 0xab, 0xb0, 0xb8, 0x34, 0x1f, 0x73, 0x63, 0x2f, 0xf2, 0x3f, 0x96, 0x68, 0x77, 0x3a, 0x30, 0xf4, 0xca, 0x34, 0xcd, 0x7b, 0x5c
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0xc3, 0x3f, 0x1c, 0xbb, 0x48, 0xeb, 0x4b, 0xc1, 0xad, 0xef, 0x59, 0x73, 0x96, 0x42, 0x8f, 0x53, 0x22, 0xf0, 0x77, 0x75, 0xaa, 0xfc, 0x9d, 0x89, 0x5a, 0x3a, 0x51, 0x9f, 0xdd, 0xd2, 0x2a, 0x96
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x3, 0x6, 0x46, 0x6f, 0xe5, 0x21, 0x17, 0x32, 0xff, 0xec, 0xad, 0xba, 0x72, 0xc3, 0x9b, 0xe7, 0xbc, 0x8c, 0xe5, 0xbb, 0xc5, 0xf7, 0x12, 0x6b, 0x2c, 0x43, 0x9b, 0x3a, 0x40, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa1, 0xd8, 0x17, 0x91, 0x37, 0x54, 0x2a, 0x98, 0x34, 0x37, 0xbd, 0xfe, 0x2a, 0x7a, 0xb2, 0x55, 0x7f, 0x53, 0x5c, 0x8a, 0x78, 0x72, 0x2b, 0x68, 0xa4, 0x9d, 0xc0, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x19, 0x2c, 0x5c, 0x51, 0x21, 0x8c, 0xc9, 0x4c, 0x3d, 0x4a, 0xf1, 0x7f, 0x58, 0xda, 0xee, 0x8, 0x9b, 0xa1, 0xfd, 0x44, 0xe3, 0xdb, 0xd9, 0x8a, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0xdd, 0xf4, 0x2a, 0x4, 0x80, 0xa, 0x54, 0xde, 0x2e, 0x58, 0x3f, 0x94, 0xf1, 0x7b, 0x8, 0x97, 0x25, 0xb7, 0x72, 0xd1, 0x33, 0x35, 0x26, 0x27, 0x12, 0x41, 0x53, 0x27, 0x76, 0xd2, 0xff, 0xc6
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x18, 0xc7, 0x74, 0xc9, 0x28, 0x56, 0x63, 0x98, 0x69, 0x1d, 0x5e, 0xb6, 0x8b, 0x5e, 0xb8, 0xa3, 0x9b, 0x4b, 0x6d, 0x5c, 0x73, 0x55, 0x5b, 0x21, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x19, 0x35, 0x84, 0xd0, 0xfe, 0xed, 0x9b, 0xb3, 0x43, 0x1d, 0x13, 0x20, 0x6b, 0xe5, 0x44, 0x28, 0x1b, 0x57, 0xb8, 0x56, 0x6c, 0xc5, 0x37, 0x5f, 0xf4, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa1, 0xd8, 0x17, 0xa5, 0x2, 0x5, 0xb, 0x68, 0x7, 0x91, 0xe6, 0xce, 0x6d, 0xb8, 0x8e, 0x1e, 0x5b, 0x71, 0x50, 0xf6, 0x1f, 0xc6, 0x79, 0xa, 0x4e, 0xb4, 0xd1, 0x0, 0x0, 0x0, 0x0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction = SolanaCompiledInstruction(
        programIdIndex: 4,
        accounts: Uint8List.fromList(<int>[1, 6, 7, 8, 9, 0]),
        data: Uint8List.fromList(<int>[
          0, 0, 0, 0,
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92,
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92
        ]),
      );

      // Act
      ASolanaInstructionDecoded actualSolanaStakeInitializeInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction = SolanaCompiledInstruction(
        programIdIndex: 4,
        accounts: Uint8List.fromList(<int>[1, 6, 7, 8, 9, 0]),
        data: Uint8List.fromList(<int>[
          0, 0, 0, 0,
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92,
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92
        ]),
      );
      const SolanaStakeInitializeInstruction expectedSolanaStakeInitializeInstruction =
      SolanaStakeInitializeInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        recipient: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaStakeInitializeInstruction, expectedSolanaStakeInitializeInstruction);
    });

    test('Should [return SolanaStakeDelegateInstruction] - testing _decodeStakeProgram() ->  SolanaStakeDelegateInstruction.fromSerializedData()', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x51, 0x98, 0x8, 0x5, 0x5d, 0xe3, 0x75, 0xe1, 0x95, 0x18, 0x92, 0xab, 0xb0, 0xb8, 0x34, 0x1f, 0x73, 0x63, 0x2f, 0xf2, 0x3f, 0x96, 0x68, 0x77, 0x3a, 0x30, 0xf4, 0xca, 0x34, 0xcd, 0x7b, 0x5c
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0xc3, 0x3f, 0x1c, 0xbb, 0x48, 0xeb, 0x4b, 0xc1, 0xad, 0xef, 0x59, 0x73, 0x96, 0x42, 0x8f, 0x53, 0x22, 0xf0, 0x77, 0x75, 0xaa, 0xfc, 0x9d, 0x89, 0x5a, 0x3a, 0x51, 0x9f, 0xdd, 0xd2, 0x2a, 0x96
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x3, 0x6, 0x46, 0x6f, 0xe5, 0x21, 0x17, 0x32, 0xff, 0xec, 0xad, 0xba, 0x72, 0xc3, 0x9b, 0xe7, 0xbc, 0x8c, 0xe5, 0xbb, 0xc5, 0xf7, 0x12, 0x6b, 0x2c, 0x43, 0x9b, 0x3a, 0x40, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa1, 0xd8, 0x17, 0x91, 0x37, 0x54, 0x2a, 0x98, 0x34, 0x37, 0xbd, 0xfe, 0x2a, 0x7a, 0xb2, 0x55, 0x7f, 0x53, 0x5c, 0x8a, 0x78, 0x72, 0x2b, 0x68, 0xa4, 0x9d, 0xc0, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x19, 0x2c, 0x5c, 0x51, 0x21, 0x8c, 0xc9, 0x4c, 0x3d, 0x4a, 0xf1, 0x7f, 0x58, 0xda, 0xee, 0x8, 0x9b, 0xa1, 0xfd, 0x44, 0xe3, 0xdb, 0xd9, 0x8a, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0xdd, 0xf4, 0x2a, 0x4, 0x80, 0xa, 0x54, 0xde, 0x2e, 0x58, 0x3f, 0x94, 0xf1, 0x7b, 0x8, 0x97, 0x25, 0xb7, 0x72, 0xd1, 0x33, 0x35, 0x26, 0x27, 0x12, 0x41, 0x53, 0x27, 0x76, 0xd2, 0xff, 0xc6
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x18, 0xc7, 0x74, 0xc9, 0x28, 0x56, 0x63, 0x98, 0x69, 0x1d, 0x5e, 0xb6, 0x8b, 0x5e, 0xb8, 0xa3, 0x9b, 0x4b, 0x6d, 0x5c, 0x73, 0x55, 0x5b, 0x21, 0x0, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa7, 0xd5, 0x17, 0x19, 0x35, 0x84, 0xd0, 0xfe, 0xed, 0x9b, 0xb3, 0x43, 0x1d, 0x13, 0x20, 0x6b, 0xe5, 0x44, 0x28, 0x1b, 0x57, 0xb8, 0x56, 0x6c, 0xc5, 0x37, 0x5f, 0xf4, 0x0, 0x0, 0x0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          0x6, 0xa1, 0xd8, 0x17, 0xa5, 0x2, 0x5, 0xb, 0x68, 0x7, 0x91, 0xe6, 0xce, 0x6d, 0xb8, 0x8e, 0x1e, 0x5b, 0x71, 0x50, 0xf6, 0x1f, 0xc6, 0x79, 0xa, 0x4e, 0xb4, 0xd1, 0x0, 0x0, 0x0, 0x0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 4, accounts: Uint8List.fromList(<int>[1, 6, 7, 8, 9, 0]), data: Uint8List.fromList(<int>[2, 0, 0, 0]));

      // Act
      ASolanaInstructionDecoded actualSolanaStakeDelegateInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 4, accounts: Uint8List.fromList(<int>[1, 6, 7, 8, 9, 0]), data: Uint8List.fromList(<int>[2, 0, 0, 0]));
      const SolanaStakeDelegateInstruction expectedSolanaStakeDelegateInstruction =
      SolanaStakeDelegateInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        sender: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        recipient: 'E9AKSDnvxFcUrvMqRVrANNZ2qdidh4AC1niGhQ6vGZxR',
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaStakeDelegateInstruction, expectedSolanaStakeDelegateInstruction);
    });

    test('Should [return SolanaStakeDeactivateInstruction] - testing _decodeStakeProgram() -> SolanaStakeDeactivateInstruction.fromSerializedData()', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          174, 145, 249, 183, 28, 188, 51, 182, 241, 4, 242, 35, 144, 122, 69, 173, 250, 180, 225, 202, 242, 56, 169, 233, 31, 100, 162, 62, 204, 40, 2, 99
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178, 85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 24, 199, 116, 201, 40, 86, 99, 152, 105, 29, 94, 182, 139, 94, 184, 163, 155, 75, 109, 92, 115, 85, 91, 33, 0, 0, 0, 0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List.fromList(<int>[1, 4, 0]), data: Uint8List.fromList(<int>[5, 0, 0, 0]));

      // Act
      ASolanaInstructionDecoded actualSolanaStakeDeactivateInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List.fromList(<int>[1, 4, 0]), data: Uint8List.fromList(<int>[5, 0, 0, 0]));
      const SolanaStakeDeactivateInstruction expectedSolanaStakeDeactivateInstruction =
      SolanaStakeDeactivateInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        sender: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        recipient: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaStakeDeactivateInstruction, expectedSolanaStakeDeactivateInstruction);
    });

    test('Should [return SolanaStakeWithdrawInstruction] - testing _decodeStakeProgram() -> SolanaStakeWithdrawInstruction.fromSerializedData()', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          174, 145, 249, 183, 28, 188, 51, 182, 241, 4, 242, 35, 144, 122, 69, 173, 250, 180, 225, 202, 242, 56, 169, 233, 31, 100, 162, 62, 204, 40, 2, 99
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178, 85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 24, 199, 116, 201, 40, 86, 99, 152, 105, 29, 94, 182, 139, 94, 184, 163, 155, 75, 109, 92, 115, 85, 91, 33, 0, 0, 0, 0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction = SolanaCompiledInstruction(
          programIdIndex: 3, accounts: Uint8List.fromList(<int>[1, 0, 4, 5, 0]), data: Uint8List.fromList(<int>[4, 0, 0, 0, 128, 159, 189, 59, 0, 0, 0, 0]));

      // Act
      ASolanaInstructionDecoded actualSolanaStakeWithdrawInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction = SolanaCompiledInstruction(
          programIdIndex: 3, accounts: Uint8List.fromList(<int>[1, 0, 4, 5, 0]), data: Uint8List.fromList(<int>[4, 0, 0, 0, 128, 159, 189, 59, 0, 0, 0, 0]));
      const SolanaStakeWithdrawInstruction expectedSolanaStakeWithdrawInstruction =
      SolanaStakeWithdrawInstruction(
        programId: 'Stake11111111111111111111111111111111111111',
        sender: 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k',
        recipient: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        amount: 1002282880,
      );

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaStakeWithdrawInstruction, expectedSolanaStakeWithdrawInstruction);
    });

    test('Should [return SolanaUnknownInstruction] - testing _decodeStakeProgram() with unknown instruction tag', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          174, 145, 249, 183, 28, 188, 51, 182, 241, 4, 242, 35, 144, 122, 69, 173, 250, 180, 225, 202, 242, 56, 169, 233, 31, 100, 162, 62, 204, 40, 2, 99
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178, 85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0
        ])),
        SolanaPubKey.fromBytes(Uint8List.fromList(<int>[
          6, 167, 213, 23, 24, 199, 116, 201, 40, 86, 99, 152, 105, 29, 94, 182, 139, 94, 184, 163, 155, 75, 109, 92, 115, 85, 91, 33, 0, 0, 0, 0
        ])),
      ];
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List.fromList(<int>[1, 4, 0]), data: Uint8List.fromList(<int>[1, 0, 0, 0]));

      // Act
      ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List.fromList(<int>[1, 4, 0]), data: Uint8List.fromList(<int>[1, 0, 0, 0]));
      const SolanaUnknownInstruction expectedSolanaUnknownInstruction =
      SolanaUnknownInstruction(programId: 'Stake11111111111111111111111111111111111111');

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

    test('Should [return SolanaTokenTransferInstruction] - testing _decodeTokenProgram() -> SolanaTokenTransferInstruction.fromSerializedData()', () {
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

    test('Should [return SolanaUnknownInstruction] - testing _decodeTokenProgram() with unknown instruction tag', () {
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
      SolanaCompiledInstruction(programIdIndex: 5, accounts: Uint8List.fromList(<int>[2, 3, 1, 0]), data: Uint8List.fromList(<int>[11, 64, 66, 15, 0, 0, 0, 0, 0, 6]));

      // Act
      ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 5, accounts: Uint8List.fromList(<int>[2, 3, 1, 0]), data: Uint8List.fromList(<int>[11, 64, 66, 15, 0, 0, 0, 0, 0, 6]));
      const SolanaUnknownInstruction expectedSolanaUnknownInstruction =
      SolanaUnknownInstruction(programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

    test('Should [return SolanaSwapInstruction] - testing SolanaSwapInstruction.fromSerializedData()', () {
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

    test('Should [return SolanaUnknownInstruction] - testing ASolanaInstructionDecoded.decode() with unknown programId', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[
        // (same as previous test)
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
      SolanaCompiledInstruction(programIdIndex: 11, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1]));

      // Act
      ASolanaInstructionDecoded actualSolanaUnknownInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 11, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1]));
      const SolanaUnknownInstruction expectedSolanaUnknownInstruction =
      SolanaUnknownInstruction(programId: '6YawcNeZ74tRyCv4UfGydYMr7eho7vbUR6ScVffxKAb3');

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });

    test('Should [return SolanaInvalidInstruction] - testing ASolanaInstructionDecoded.decode() with empty accountKeys', () {
      // Arrange
      List<SolanaPubKey> actualAccountKeys = <SolanaPubKey>[];
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 11, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1]));

      // Act
      ASolanaInstructionDecoded actualSolanaInvalidInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 11, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1]));
      const SolanaInvalidInstruction expectedSolanaInvalidInstruction = SolanaInvalidInstruction();

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaInvalidInstruction, expectedSolanaInvalidInstruction);
    });

    test('Should [return SolanaInvalidInstruction] - testing ASolanaInstructionDecoded.decode() with programIdIndex out of bounds', () {
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
      SolanaCompiledInstruction actualSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 25, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1]));

      // Act
      ASolanaInstructionDecoded actualSolanaInvalidInstruction = ASolanaInstructionDecoded.decode(actualSolanaCompiledInstruction, actualAccountKeys);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction =
      SolanaCompiledInstruction(programIdIndex: 25, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1]));
      const SolanaInvalidInstruction expectedSolanaInvalidInstruction = SolanaInvalidInstruction();

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
      expect(actualSolanaInvalidInstruction, expectedSolanaInvalidInstruction);
    });
  });
}
