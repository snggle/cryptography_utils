import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaComputeBudgetUnitSetComputeLimitInstruction.fromSerializedData()', () {
    test('Should [return SolanaComputeBudgetUnitSetComputeLimitInstruction] from serialized data', () {
      // Act
      SolanaComputeBudgetSetComputeUnitLimitInstruction actualSolanaComputeBudgetUnitSetComputeLimitInstruction =
          SolanaComputeBudgetSetComputeUnitLimitInstruction.fromSerializedData(
        SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[2, 239, 1, 0, 0])),
        'ComputeBudget111111111111111111111111111111',
      );

      // Assert
      SolanaComputeBudgetSetComputeUnitLimitInstruction expectedSolanaComputeBudgetUnitSetComputeLimitInstruction =
          const SolanaComputeBudgetSetComputeUnitLimitInstruction(
        discriminator: 2,
        programId: 'ComputeBudget111111111111111111111111111111',
        units: 495,
      );

      expect(actualSolanaComputeBudgetUnitSetComputeLimitInstruction, expectedSolanaComputeBudgetUnitSetComputeLimitInstruction);
    });
  });
}
