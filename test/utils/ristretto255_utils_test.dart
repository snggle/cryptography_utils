import 'dart:convert';

import 'package:cryptography_utils/src/utils/ristretto255_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Ristretto255Utils.calcSqrtUV()', () {
    test('Should [return value] of sqrt(u, v) operation', () {
      // Arrange
      BigInt actualU = BigInt.parse('1');
      BigInt actualV = BigInt.parse('53639021874097354088418816760693924697132866381050633690285931464056258264223');

      // Act
      BigInt actualSqrtUV = Ristretto255Utils.calcSqrtUV(actualU, actualV);

      // Assert
      BigInt expectedSqrtUV = BigInt.parse('42211231769166319230299834437277029791232603390553368698854193127119172970406');

      expect(actualSqrtUV, expectedSqrtUV);
    });
  });

  group('Tests of Ristretto255Utils.divideScalarByCofactor()', () {
    test('Should [return scalar] divided by its cofactor', () {
      // Arrange
      List<int> actualScalar = base64Decode('AHihHQJ8DpCvqt1tKv7D0XMe6xgp3exKqhBEfBXjnnM=');

      // Act
      List<int> actualDividedScalar = Ristretto255Utils.divideScalarByCofactor(actualScalar);

      // Assert
      List<int> expectedDividedScalar = base64Decode('AC+0Q4DPAfJVtbtNxX84es5jHSOlm11JFYKIr2Lccw4=');

      expect(actualDividedScalar, expectedDividedScalar);
    });
  });

  group('Tests of Ristretto255Utils.isOdd()', () {
    test('Should [return TRUE] if number is odd', () {
      // Arrange
      BigInt actualNum = BigInt.parse(
          '550151953139474385478876595315777041972720855532741049611103440256004187812016515963786017381609533104554591247860926983169467780654008995216094278354660');
      BigInt actualModulo = BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819949');

      // Act
      bool actualOddBool = Ristretto255Utils.isOdd(actualNum, actualModulo);

      // Assert
      bool expectedOddBool = true;

      expect(actualOddBool, expectedOddBool);
    });

    test('Should [return FALSE] if number is even', () {
      // Arrange
      BigInt actualNum = BigInt.parse(
          '550151953139474385478876595315777041972720855532741049611103440256004187812016515963786017381609533104554591247860926983169467780654008995216094278354660');
      BigInt actualModulo = BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819948');

      // Act
      bool actualOddBool = Ristretto255Utils.isOdd(actualNum, actualModulo);

      // Assert
      bool expectedOddBool = false;

      expect(actualOddBool, expectedOddBool);
    });
  });

  group('Tests of Ristretto255Utils.positiveMod()', () {
    test('Should [return remainder] of two BigInt values', () {
      // Arrange
      BigInt actualA = BigInt.parse('63350861593150250027166760661066931577131565540673914264497032359434911573166');
      BigInt actualB = BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819949');

      // Act
      BigInt actualPositiveMod = Ristretto255Utils.positiveMod(actualA, actualB);

      // Assert
      BigInt expectedPositiveMod = BigInt.parse('5454816974492152315381268156722977650496573207853632244768240355478346753217');

      expect(actualPositiveMod, expectedPositiveMod);
    });
  });
}
