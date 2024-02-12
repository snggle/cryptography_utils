// Class was shaped by the influence of several key sources including:
// "blockchain_utils" Copyright (c) 2010 Mohsen
// https://github.com/mrtnetwork/blockchain_utils/.
//
// BSD 3-Clause License
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

class ED25519Utils {
  static BigInt findModularSquareRoot({required BigInt a, required BigInt p}) {
    BigInt jacobiSymbol = _calcJacobiSymbol(a, p);

    if (jacobiSymbol == BigInt.from(-1)) {
      throw Exception('$a has no square root modulo $p');
    }

    if (p % BigInt.from(4) == BigInt.from(3)) {
      return a.modPow((p + BigInt.one) ~/ BigInt.from(4), p);
    }

    if (p % BigInt.from(8) == BigInt.from(5)) {
      BigInt d = a.modPow((p - BigInt.one) ~/ BigInt.from(4), p);
      if (d == BigInt.one) {
        return a.modPow((p + BigInt.from(3)) ~/ BigInt.from(8), p);
      }
      return (BigInt.from(2) * a * (BigInt.from(4) * a).modPow((p - BigInt.from(5)) ~/ BigInt.from(8), p)) % p;
    }

    for (BigInt b = BigInt.from(2); b < p; b += BigInt.one) {
      if (_calcJacobiSymbol(b * b - BigInt.from(4) * a, p) == BigInt.from(-1)) {
        List<BigInt> quadraticForm = <BigInt>[a, -b, BigInt.one];
        List<BigInt> result = _calcModularPolynomialExponentiation(<BigInt>[BigInt.zero, BigInt.one], (p + BigInt.one) ~/ BigInt.from(2), quadraticForm, p);
        if (result[1] != BigInt.zero) {
          throw Exception('p is not prime');
        }
        return result[0];
      }
    }

    throw Exception("No suitable 'b' found.");
  }

  /// Calculates the Jacobi symbol (a/n) for given integers 'a' and 'n'.
  static BigInt _calcJacobiSymbol(BigInt a, BigInt n) {
    BigInt tmpa = a;
    if (!(n >= BigInt.from(3))) {
      throw const FormatException('n must be larger than 2');
    }
    if (!(n % BigInt.two == BigInt.one)) {
      throw const FormatException('n must be odd');
    }

    tmpa = tmpa % n;
    if (tmpa == BigInt.zero) {
      return BigInt.zero;
    }
    if (tmpa == BigInt.one) {
      return BigInt.one;
    }

    BigInt a1 = tmpa, e = BigInt.zero;
    while (a1 % BigInt.two == BigInt.zero) {
      a1 = a1 ~/ BigInt.two;
      e = e + BigInt.one;
    }

    BigInt s = BigInt.one;

    if (e % BigInt.two == BigInt.zero || n % BigInt.from(8) == BigInt.one || n % BigInt.from(8) == BigInt.from(7)) {
      // s remains 1
    } else {
      s = BigInt.from(-1);
    }

    if (a1 == BigInt.one) {
      return s;
    }

    if (n % BigInt.from(4) == BigInt.from(3) && a1 % BigInt.from(4) == BigInt.from(3)) {
      s = -s;
    }

    return s * _calcJacobiSymbol(n % a1, a1);
  }

  static List<BigInt> _calcModularPolynomialExponentiation(List<BigInt> base, BigInt exponent, List<BigInt> polymod, BigInt p) {
    if (exponent == BigInt.zero) {
      return <BigInt>[BigInt.one];
    }

    List<BigInt> G = List<BigInt>.from(base);
    BigInt k = exponent;
    List<BigInt> s = (k % BigInt.two == BigInt.one) ? List<BigInt>.from(G) : <BigInt>[BigInt.one];

    while (k > BigInt.one) {
      k = k ~/ BigInt.two;
      G = _multiplyModularPolynomial(G, G, polymod, p);
      if (k % BigInt.two == BigInt.one) {
        s = _multiplyModularPolynomial(G, s, polymod, p);
      }
    }

    return s;
  }

  /// Multiply two polynomials represented by lists 'm1' and 'm2', reducing modulo 'polymod' and prime 'p'.
  static List<BigInt> _multiplyModularPolynomial(List<BigInt> m1, List<BigInt> m2, List<BigInt> polymod, BigInt p) {
    List<BigInt> prod = List<BigInt>.filled(m1.length + m2.length - 1, BigInt.zero);

    // Add together all the cross-terms:
    for (int i = 0; i < m1.length; i++) {
      for (int j = 0; j < m2.length; j++) {
        prod[i + j] = (prod[i + j] + m1[i] * m2[j]) % p;
      }
    }

    return _reduceModularPolynomial(prod, polymod, p);
  }

  /// Reduce a polynomial 'poly' modulo 'polymod' using prime 'p'.
  static List<BigInt> _reduceModularPolynomial(List<BigInt> poly, List<BigInt> polymod, BigInt p) {
    // Repeatedly reduce the polynomial while its degree is greater than or equal to 'polymod':
    List<BigInt> tmpPoly = List<BigInt>.from(poly);
    while (tmpPoly.length >= polymod.length) {
      if (tmpPoly.last != BigInt.zero) {
        for (int i = 2; i <= polymod.length; i++) {
          tmpPoly[tmpPoly.length - i] = (tmpPoly[tmpPoly.length - i] - tmpPoly.last * polymod[polymod.length - i]) % p;
        }
      }
      tmpPoly.removeLast();
    }

    return tmpPoly;
  }
}
