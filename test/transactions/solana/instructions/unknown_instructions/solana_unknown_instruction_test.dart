import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaUnknownInstruction', () {
    test('Should [return SolanaUnknownInstruction] from serialized data', () {
      // Arrange
      String actualProgramId = 'SomeProgram1111111111111111111111111111111';

      // Act
      SolanaUnknownInstruction actualSolanaUnknownInstruction = SolanaUnknownInstruction.fromSerializedData(actualProgramId);

      // Assert
      SolanaUnknownInstruction expectedSolanaUnknownInstruction = SolanaUnknownInstruction(programId: actualProgramId);

      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });
  });
}
