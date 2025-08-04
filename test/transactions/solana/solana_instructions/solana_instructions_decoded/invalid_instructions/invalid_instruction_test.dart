import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('InvalidInstruction', () {
    test('Should [return InvalidInstruction]', () {
      // Act
      InvalidInstruction actualInvalidInstruction = const InvalidInstruction();

      // Assert
      expect(actualInvalidInstruction, isA<InvalidInstruction>());
      expect(actualInvalidInstruction.programId, '');
      expect(actualInvalidInstruction.programIdString, '');
    });
  });
}
