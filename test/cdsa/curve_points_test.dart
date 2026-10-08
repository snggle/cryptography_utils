
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CurvePoints.generatorSecp256r1', () {
    test('Should [return generator point] that belongs to secp256r1 curve', () {
      // Arrange
      ECPoint generator = CurvePoints.generatorSecp256r1;
      ECCurve curve = generator.curve;

      // Act
      BigInt left = generator.y.modPow(BigInt.two, curve.p);
      BigInt right = (
          generator.x.modPow(BigInt.from(3), curve.p) +
              curve.a * generator.x +
              curve.b
      ) % curve.p;

      // Assert
      expect(left, right);
    });

    test('Should [return infinity ECPoint] when generator is multiplied by its order', () {
      // Arrange
      ECPoint generator = CurvePoints.generatorSecp256r1;

      // Act
      ECPoint actualECPoint = generator * generator.n;

      // Assert
      expect(actualECPoint.isInfinity, true);
    });
  });
}
