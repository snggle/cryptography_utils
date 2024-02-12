import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Ristretto255Scalar.fromBytes() constructor', () {
    test('Should [return Ristretto255Scalar] constructed from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode('T638LP9QwSABfXnIrVRkHXSCek2xdRS6f1du8wh9Yg4=');

      // Act
      Ristretto255Scalar actualRistretto255Scalar = Ristretto255Scalar.fromBytes(actualBytes);

      // Assert
      Ristretto255Scalar expectedRistretto255Scalar = Ristretto255Scalar(
        BigInt.parse('6506393852123212115354415942638225927812991982421560299733944100042854673743'),
      );

      expect(actualRistretto255Scalar, expectedRistretto255Scalar);
    });

    test('Should [return ZERO Ristretto255Scalar] constructed from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=');

      // Act
      Ristretto255Scalar actualRistretto255Scalar = Ristretto255Scalar.fromBytes(actualBytes);

      // Assert
      Ristretto255Scalar expectedRistretto255Scalar = Ristretto255Scalar(BigInt.zero);

      expect(actualRistretto255Scalar, expectedRistretto255Scalar);
    });

    test('Should [return ONE Ristretto255Scalar] constructed from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode('AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=');

      // Act
      Ristretto255Scalar actualRistretto255Scalar = Ristretto255Scalar.fromBytes(actualBytes);

      // Assert
      Ristretto255Scalar expectedRistretto255Scalar = Ristretto255Scalar(BigInt.one);

      expect(actualRistretto255Scalar, expectedRistretto255Scalar);
    });
  });

  group('Tests of Ristretto255Scalar.fromUniformBytes() constructor', () {
    test('Should [return Ristretto255Scalar] constructed from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode('qgxx8ANH4DiQB1pCHEPsIqurBVHK5VIbEcdplt2LK2CB+jis10ARTZG0o6sufqks1HVfyb4qMMr/hJNlE9lNXA==');

      // Act
      Ristretto255Scalar actualRistretto255Scalar = Ristretto255Scalar.fromUniformBytes(actualBytes);

      // Assert
      Ristretto255Scalar expectedRistretto255Scalar =
          Ristretto255Scalar(BigInt.parse('1246545078343952652086387159301389716512964651843988398700061377136094873709'));

      expect(actualRistretto255Scalar, expectedRistretto255Scalar);
    });

    test('Should [return ZERO Ristretto255Scalar] constructed from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==');

      // Act
      Ristretto255Scalar actualRistretto255Scalar = Ristretto255Scalar.fromUniformBytes(actualBytes);

      // Assert
      Ristretto255Scalar expectedRistretto255Scalar = Ristretto255Scalar(BigInt.zero);

      expect(actualRistretto255Scalar, expectedRistretto255Scalar);
    });

    test('Should [return ONE Ristretto255Scalar] constructed from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode('7tP1XBpjEljWnPei3vneFAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==');

      // Act
      Ristretto255Scalar actualRistretto255Scalar = Ristretto255Scalar.fromUniformBytes(actualBytes);

      // Assert
      Ristretto255Scalar expectedRistretto255Scalar = Ristretto255Scalar(BigInt.one);

      expect(actualRistretto255Scalar, expectedRistretto255Scalar);
    });
  });

  group('Tests of Ristretto255Scalar + (addition) operator overload', () {
    test('Should [return Ristretto255Scalar] sum of two given Ristretto255Scalar', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949821'));
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949821'));

      // Act
      Ristretto255Scalar actualResult = actualScalarA + actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(BigInt.parse('300792162314458398262332320337554298616645166341549105025694758429525899642'));

      expect(actualResult, expectedResult);
    });

    test('Should [return Ristretto255Scalar] sum of two given Ristretto255Scalar (scalarA == 1)', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.one);
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949821'));

      // Act
      Ristretto255Scalar actualResult = actualScalarA + actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949822'));

      expect(actualResult, expectedResult);
    });

    test('Should [return Ristretto255Scalar] sum of two given Ristretto255Scalar (scalarB == 1)', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949821'));
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.one);

      // Act
      Ristretto255Scalar actualResult = actualScalarA + actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949822'));

      expect(actualResult, expectedResult);
    });

    test('Should [return Ristretto255Scalar] sum of two given Ristretto255Scalar (scalarA == 0)', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.zero);
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949821'));

      // Act
      Ristretto255Scalar actualResult = actualScalarA + actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949821'));

      expect(actualResult, expectedResult);
    });

    test('Should [return Ristretto255Scalar] sum of two given Ristretto255Scalar (scalarB == 0)', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949821'));
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.zero);

      // Act
      Ristretto255Scalar actualResult = actualScalarA + actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949821'));

      expect(actualResult, expectedResult);
    });
  });

  group('Tests of Ristretto255Scalar * (multiplication) operator overload', () {
    test('Should [return Ristretto255Scalar] product of two given Ristretto255Scalar', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.parse('6506393852123212115354415942638225927812991982421560299733944100042854673743'));
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.parse('1246545078343952652086387159301389716512964651843988398700061377136094873709'));

      // Act
      Ristretto255Scalar actualResult = actualScalarA * actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(
        BigInt.parse('150396081157229199131166160168777149308322583170774552512847379214762949821'),
      );

      expect(actualResult, expectedResult);
    });

    test('Should [return Ristretto255Scalar] product of two given Ristretto255Scalar (scalarA == 1)', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.one);
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.parse('1246545078343952652086387159301389716512964651843988398700061377136094873709'));

      // Act
      Ristretto255Scalar actualResult = actualScalarA * actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(BigInt.parse('1246545078343952652086387159301389716512964651843988398700061377136094873709'));

      expect(actualResult, expectedResult);
    });

    test('Should [return Ristretto255Scalar] product of two given Ristretto255Scalar (scalarB == 1)', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.parse('6506393852123212115354415942638225927812991982421560299733944100042854673743'));
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.one);

      // Act
      Ristretto255Scalar actualResult = actualScalarA * actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(BigInt.parse('6506393852123212115354415942638225927812991982421560299733944100042854673743'));

      expect(actualResult, expectedResult);
    });

    test('Should [return Ristretto255Scalar] product of two given Ristretto255Scalar (scalarA == 0)', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.zero);
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.parse('1246545078343952652086387159301389716512964651843988398700061377136094873709'));

      // Act
      Ristretto255Scalar actualResult = actualScalarA * actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(BigInt.zero);

      expect(actualResult, expectedResult);
    });

    test('Should [return Ristretto255Scalar] product of two given Ristretto255Scalar (scalarB == 0)', () {
      // Arrange
      Ristretto255Scalar actualScalarA = Ristretto255Scalar(BigInt.parse('6506393852123212115354415942638225927812991982421560299733944100042854673743'));
      Ristretto255Scalar actualScalarB = Ristretto255Scalar(BigInt.zero);

      // Act
      Ristretto255Scalar actualResult = actualScalarA * actualScalarB;

      // Assert
      Ristretto255Scalar expectedResult = Ristretto255Scalar(BigInt.zero);

      expect(actualResult, expectedResult);
    });
  });

  group('Tests of Ristretto255Scalar.toBytes() method', () {
    test('Should [return BYTES] representing given Ristretto255Scalar', () {
      // Arrange
      Ristretto255Scalar actualRistretto255Scalar = Ristretto255Scalar(
        BigInt.parse('6506393852123212115354415942638225927812991982421560299733944100042854673743'),
      );

      // Act
      Uint8List actualBytes = actualRistretto255Scalar.toBytes();

      // Assert
      Uint8List expectedBytes = base64Decode('T638LP9QwSABfXnIrVRkHXSCek2xdRS6f1du8wh9Yg4=');

      expect(actualBytes, expectedBytes);
    });

    test('Should [return BYTES] representing ZERO Ristretto255Scalar', () {
      // Arrange
      Ristretto255Scalar actualRistretto255Scalar = Ristretto255Scalar(BigInt.zero);

      // Act
      Uint8List actualBytes = actualRistretto255Scalar.toBytes();

      // Assert
      Uint8List expectedBytes = base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=');

      expect(actualBytes, expectedBytes);
    });

    test('Should [return BYTES] representing ONE Ristretto255Scalar', () {
      // Arrange
      Ristretto255Scalar actualRistretto255Scalar = Ristretto255Scalar(BigInt.one);

      // Act
      Uint8List actualBytes = actualRistretto255Scalar.toBytes();

      // Assert
      Uint8List expectedBytes = base64Decode('AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=');

      expect(actualBytes, expectedBytes);
    });
  });
}
