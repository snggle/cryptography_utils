import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaComputeBudgetSetComputeUnitPriceInstruction.fromSerializedData()', () {
    test('Should [return SolanaComputeBudgetSetComputeUnitPriceInstruction] from serialized data', () {
      // Act
      SolanaComputeBudgetSetComputeUnitPriceInstruction actualSolanaComputeBudgetSetComputeUnitPriceInstruction =
          SolanaComputeBudgetSetComputeUnitPriceInstruction.fromSerializedData(
        SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[3, 0, 45, 49, 1, 0, 0, 0, 0])),
        'ComputeBudget111111111111111111111111111111',
      );

      // Assert
      SolanaComputeBudgetSetComputeUnitPriceInstruction expectedSolanaComputeBudgetSetComputeUnitPriceInstruction =
          const SolanaComputeBudgetSetComputeUnitPriceInstruction(
        discriminator: 3,
        programId: 'ComputeBudget111111111111111111111111111111',
        microLamports: 20000000,
      );

      expect(actualSolanaComputeBudgetSetComputeUnitPriceInstruction, expectedSolanaComputeBudgetSetComputeUnitPriceInstruction);
    });
  });
}
