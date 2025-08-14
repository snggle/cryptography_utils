import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ComputeBudgetUnitLimitInstruction.fromSerializedData()', () {
    test('Should [return ComputeBudgetUnitLimitInstruction] from serialized data', () {
      // Act
      SolanaComputeBudgetUnitLimitInstruction actualSolanaComputeBudgetUnitLimitInstruction =
          SolanaComputeBudgetUnitLimitInstruction.fromSerializedData(
              SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[2, 239, 1, 0, 0])),
              'ComputeBudget111111111111111111111111111111');

      // Assert
      SolanaComputeBudgetUnitLimitInstruction expectedSolanaComputeBudgetUnitLimitInstruction = const SolanaComputeBudgetUnitLimitInstruction(
        programId: 'ComputeBudget111111111111111111111111111111',
        units: 495,
      );

      expect(actualSolanaComputeBudgetUnitLimitInstruction, expectedSolanaComputeBudgetUnitLimitInstruction);
    });
  });
}
