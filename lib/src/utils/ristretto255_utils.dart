import 'package:cryptography_utils/cryptography_utils.dart';

class Ristretto255Utils {
  /// The square root of -1 in the Ristretto255 curve field.
  static final BigInt sqrtM1 = BigInt.parse('19681161376707505956807079304988542015446066515923890162744021073123829784752');

  /// The modular inverse of the square root (1/sqrt(a*d)) in the Ristretto255 curve field.
  static final BigInt invSqrt = BigInt.parse('54469307008909316920995813868745141605393597292927456921205312896311721017578');

  /// sqrt u/v
  static BigInt calcSqrtUV(BigInt u, BigInt v) {
    BigInt P = Curves.ed25519.p;
    BigInt v3 = positiveMod(v * v * v, P);
    BigInt v7 = positiveMod(v3 * v3 * v, P);
    BigInt pow = _calcPow252(u * v7);
    BigInt x = positiveMod(u * v3 * pow, P);
    BigInt vx2 = positiveMod(v * x * x, P);
    BigInt root1 = x;

    BigInt root2 = positiveMod(x * sqrtM1, P);
    bool useRoot1 = vx2 == u;
    bool useRoot2 = vx2 == positiveMod(-u, P);
    bool noRoot = vx2 == positiveMod(-u * sqrtM1, P);

    if (useRoot1) {
      x = root1;
    }
    if (useRoot2 || noRoot) {
      x = root2;
    }

    if (isOdd(x, P)) {
      x = positiveMod(-x, P);
    }
    return x;
  }

  static List<int> divideScalarByCofactor(List<int> scalar) {
    int low = 0;
    for (int i = scalar.length - 1; i >= 0; i--) {
      int r = scalar[i] & 0x07;
      scalar[i] >>= 3;
      scalar[i] += low;
      low = r << 5;
    }

    return scalar;
  }

  /// Check if a BigInt number is odd with respect to a given modulo.
  ///
  /// This function determines whether a BigInt 'num' is an odd number
  /// when computed within the modular arithmetic defined by 'modulo'.
  /// It calculates the remainder of 'num' when divided by 'modulo' and checks
  /// if the least significant bit is set to 1 (i.e., it's an odd number).
  static bool isOdd(BigInt num, BigInt modulo) {
    return (positiveMod(num, modulo) & BigInt.one) == BigInt.one;
  }

  /// Calculates the positive remainder of two BigInt values.
  ///
  /// This function takes two BigInt values, `a` and `b`, and computes `a % b`.
  /// If the result is greater than or equal to zero, it returns the result.
  /// If the result is negative, it adds `b` to the result to make it positive.
  static BigInt positiveMod(BigInt a, BigInt b) {
    BigInt result = a % b;
    return result >= BigInt.zero ? result : b + result;
  }

  /// Calculate values relevant to the Ed25519 elliptic curve for pow(2, 252 - 3).
  ///
  /// This function takes a BigInt value 'x' and computes various intermediate values
  /// necessary for the Ed25519 elliptic curve, specifically for pow(2, 252 - 3).
  /// It involves several modular exponentiation and modular multiplications.
  static BigInt _calcPow252(BigInt x) {
    BigInt P = Curves.ed25519.p;
    BigInt xSquared = (x * x) % P;
    BigInt xCubed = (xSquared * x) % P;
    BigInt xTo4th = (_calcModularExp(xCubed, BigInt.two, P) * xCubed) % P;
    BigInt xTo5th = (_calcModularExp(xTo4th, BigInt.one, P) * x) % P;
    BigInt xTo10th = (_calcModularExp(xTo5th, BigInt.from(5), P) * xTo5th) % P;
    BigInt xTo20th = (_calcModularExp(xTo10th, BigInt.from(10), P) * xTo10th) % P;
    BigInt xTo40th = (_calcModularExp(xTo20th, BigInt.from(20), P) * xTo20th) % P;
    BigInt xTo80th = (_calcModularExp(xTo40th, BigInt.from(40), P) * xTo40th) % P;
    BigInt xTo160th = (_calcModularExp(xTo80th, BigInt.from(80), P) * xTo80th) % P;
    BigInt xTo240th = (_calcModularExp(xTo160th, BigInt.from(80), P) * xTo80th) % P;
    BigInt xTo250th = (_calcModularExp(xTo240th, BigInt.from(10), P) * xTo10th) % P;
    BigInt result = (_calcModularExp(xTo250th, BigInt.two, P) * x) % P;
    return result;
  }

  /// Computes modular exponentiation for BigInt values.
  ///
  /// This function calculates 'x' raised to the power 'power', modulo 'modulo'.
  /// It uses a modular exponentiation algorithm to efficiently compute
  /// large powers while keeping the result within the range of 'modulo'.
  static BigInt _calcModularExp(BigInt x, BigInt power, BigInt modulo) {
    BigInt tmpPower = power;
    BigInt res = x;
    while (tmpPower > BigInt.zero) {
      res *= res;
      res %= modulo;
      tmpPower -= BigInt.one;
    }
    return res;
  }
}
