import 'package:cryptography_utils/src/utils/ed25519_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ED25519Utils.calcModularSquareRootPrime()', () {
    test('Should [find square root] where if [p % 4 = 3]', () {
      // Act
      BigInt actualModularSquareRoot = ED25519Utils.findModularSquareRoot(
        a: BigInt.parse('4'),
        p: BigInt.parse('7'),
      );

      // Assert
      BigInt expectedModularSquareRoot = BigInt.parse('2');

      expect(actualModularSquareRoot, expectedModularSquareRoot);
    });

    test('Should [find square root] where [p % 8 = 5]', () {
      // Act
      BigInt actualModularSquareRoot = ED25519Utils.findModularSquareRoot(
        a: BigInt.parse('10'),
        p: BigInt.parse('13'),
      );

      // Assert
      BigInt expectedModularSquareRoot = BigInt.parse('7');

      expect(actualModularSquareRoot, expectedModularSquareRoot);
    });

    test('Should [find square root] where [x^2 = a mod p]', () {
      // Act
      BigInt actualModularSquareRoot = ED25519Utils.findModularSquareRoot(
        a: BigInt.parse('25'),
        p: BigInt.parse('41'),
      );

      // Assert
      BigInt expectedModularSquareRoot = BigInt.parse('36');

      expect(actualModularSquareRoot, expectedModularSquareRoot);
    });

    test('Should [find square root] where [a = 0]', () {
      // Act
      BigInt actualModularSquareRoot = ED25519Utils.findModularSquareRoot(
        a: BigInt.parse('0'),
        p: BigInt.parse('11'),
      );

      // Assert
      BigInt expectedModularSquareRoot = BigInt.parse('0');

      expect(actualModularSquareRoot, expectedModularSquareRoot);
    });

    test('Should [find square root] where [a = p - 1]', () {
      // Act
      BigInt actualModularSquareRoot = ED25519Utils.findModularSquareRoot(
        a: BigInt.parse('16'),
        p: BigInt.parse('17'),
      );

      // Assert
      BigInt expectedModularSquareRoot = BigInt.parse('13');

      expect(actualModularSquareRoot, expectedModularSquareRoot);
    });

    test('Should [find square root] where parameters are larger numbers', () {
      // Act
      BigInt actualModularSquareRoot = ED25519Utils.findModularSquareRoot(
        a: BigInt.parse('123456789'),
        p: BigInt.parse('1000000007'),
      );

      // Assert
      BigInt expectedModularSquareRoot = BigInt.parse('151347102');

      expect(actualModularSquareRoot, expectedModularSquareRoot);
    });

    test('Should [find square root] where parameters are larger numbers', () {
      // Act
      BigInt actualModularSquareRoot = ED25519Utils.findModularSquareRoot(
        a: BigInt.parse('17732832541123001036019990679150092111822642384727112811704228629262802952098'),
        p: BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819949'),
      );

      // Assert
      BigInt expectedModularSquareRoot = BigInt.parse('35747017703550611212035021907870961965630890711630954962468208729293799748073');

      expect(actualModularSquareRoot, expectedModularSquareRoot);
    });

    test('Should [throw Exception] if [jacobi symbol NOT EXISTS] (p is odd)', () {
      // Assert
      expect(
        () => ED25519Utils.findModularSquareRoot(
          a: BigInt.parse('3'),
          p: BigInt.parse('8'),
        ),
        throwsException,
      );
    });

    test('Should [throw Exception] if [jacobi symbol NOT EXISTS] (p is smaller than 2)', () {
      // Assert
      expect(
        () => ED25519Utils.findModularSquareRoot(
          a: BigInt.parse('9'),
          p: BigInt.parse('1'),
        ),
        throwsException,
      );
    });

    test('Should [throw Exception] if [solution NOT EXISTS]', () {
      // Assert
      expect(
        () => ED25519Utils.findModularSquareRoot(
          a: BigInt.parse('5'),
          p: BigInt.parse('13'),
        ),
        throwsException,
      );
    });
  });
}
