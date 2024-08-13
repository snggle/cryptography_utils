import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('ADerivator.fromSerializedType()', () {
    test('Should [return Secp256k1Derivator] when type is "secp256k1"', () {
      // Arrange
      String actualType = 'secp256k1';

      // Act
      ADerivator actualDerivator = ADerivator.fromSerializedType(actualType);

      // Assert
      expect(actualDerivator, isA<Secp256k1Derivator>());
    });
  });
}
