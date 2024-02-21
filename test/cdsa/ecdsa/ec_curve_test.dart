import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of ECCurve.baselen getter', () {
    test('Should [return length] of the base point in the curve (Secp256k1)', () {
      // Arrange
      ECCurve actualECCurve = Curves.secp256k1;

      // Act
      int actualBaseLen = actualECCurve.baselen;

      // Assert
      expect(actualBaseLen, 32);
    });
  });
}
