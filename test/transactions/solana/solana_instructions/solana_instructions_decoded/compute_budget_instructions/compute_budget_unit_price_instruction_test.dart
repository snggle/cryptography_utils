import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ComputeBudgetUnitPriceInstruction constructor', () {
    test('Should [construct] with all fields set', () {
      // Act
      ComputeBudgetUnitPriceInstruction actualComputeBudgetUnitPriceInstruction = const ComputeBudgetUnitPriceInstruction(
        programIdString: 'ComputeBudget111111111111111111111111111111',
        unitPriceInt: 9876543210,
      );

      // Assert
      String expectedProgramId = 'ComputeBudget111111111111111111111111111111';
      int expectedUnitPrice = 9876543210;

      expect(actualComputeBudgetUnitPriceInstruction.programIdString, expectedProgramId);
      expect(actualComputeBudgetUnitPriceInstruction.unitPriceInt, expectedUnitPrice);
      expect(actualComputeBudgetUnitPriceInstruction.programId, expectedProgramId);
      expect(actualComputeBudgetUnitPriceInstruction.unitPrice, expectedUnitPrice);
    });
  });

  group('Tests of ComputeBudgetUnitPriceInstruction.fromSerializedData()', () {
    test('Should [return ComputeBudgetUnitPriceInstruction] from serialized data', () {
      // Arrange
      List<Uint8List> actualAccountKeys = <Uint8List>[Uint8List.fromList(<int>[29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244]), Uint8List.fromList(<int>[81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92]), Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), Uint8List.fromList(<int>[3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0])];
      SolanaInstructionRaw actualSolanaInstruction =
      SolanaInstructionRaw(programIdIndex: 3, accountIndices: <int>[], data: Uint8List.fromList(<int>[3, 0, 45, 49, 1, 0, 0, 0, 0]));
      String actualProgramId = Base58Codec.encode(actualAccountKeys[actualSolanaInstruction.programIdIndex]);

      // Act
      ComputeBudgetUnitPriceInstruction actualSolanaInstructionDecoded = ComputeBudgetUnitPriceInstruction.fromSerializedData(actualSolanaInstruction, actualProgramId);

      // Assert
      expect(actualSolanaInstruction.data, Uint8List.fromList(<int>[3, 0, 45, 49, 1, 0, 0, 0, 0]));
      expect(actualSolanaInstruction.accountIndices, <int>[]);
      expect(actualSolanaInstruction.programIdIndex, 3);
      expect(actualSolanaInstructionDecoded.programId, 'ComputeBudget111111111111111111111111111111');
      expect(actualSolanaInstructionDecoded.unitPrice, 20000000);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      // Arrange
      List<Uint8List> actualAccountKeys = <Uint8List>[Uint8List.fromList(<int>[29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244]), Uint8List.fromList(<int>[81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92]), Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), Uint8List.fromList(<int>[3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0])];
      SolanaInstructionRaw actualSolanaInstruction =
      SolanaInstructionRaw(programIdIndex: 3, accountIndices: <int>[], data: Uint8List.fromList(<int>[3, 0]));
      String actualProgramId = Base58Codec.encode(actualAccountKeys[actualSolanaInstruction.programIdIndex]);

      // Assert
      expect(() => ComputeBudgetUnitPriceInstruction.fromSerializedData(actualSolanaInstruction, actualProgramId),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
