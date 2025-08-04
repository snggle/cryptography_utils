import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('UnknownInstruction', () {
    test('Should [return UnknownInstruction] with programId', () {
      // Act
      UnknownInstruction actualUnknownInstruction = const UnknownInstruction(programIdString: 'SomeProgram1111111111111111111111111111111');

      // Assert
      String expectedProgramId = 'SomeProgram1111111111111111111111111111111';

      expect(actualUnknownInstruction.programId, expectedProgramId);
      expect(actualUnknownInstruction, isA<UnknownInstruction>());
    });

    test('Should [return UnknownInstruction] using fromSerializedData()', () {
      // Arrange
      String expectedProgramId = 'SomeProgram1111111111111111111111111111111';

      // Act
      UnknownInstruction actualUnknownInstruction = UnknownInstruction.fromSerializedData(expectedProgramId);

      // Assert
      expect(actualUnknownInstruction.programId, expectedProgramId);
      expect(actualUnknownInstruction, isA<UnknownInstruction>());
    });
  });
}
