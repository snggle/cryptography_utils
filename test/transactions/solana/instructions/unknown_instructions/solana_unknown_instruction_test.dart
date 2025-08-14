import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaUnknownInstruction', () {
    test('Should [return SolanaUnknownInstruction] from serialized data', () {
      // Act
      SolanaUnknownInstruction actualSolanaUnknownInstruction =
          SolanaUnknownInstruction.fromSerializedData('SomeProgram1111111111111111111111111111111');

      // Assert
      SolanaUnknownInstruction expectedSolanaUnknownInstruction =
          const SolanaUnknownInstruction(programId: 'SomeProgram1111111111111111111111111111111');

      expect(actualSolanaUnknownInstruction, expectedSolanaUnknownInstruction);
    });
  });
}
