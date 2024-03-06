// Class was shaped by the influence of several key sources including:
// "python-ecdsa" Copyright (c) 2010 Brian Warner, adapted to Dart by "blockchain_utils" Copyright (c) 2010 Mohsen
// https://github.com/tlsfuzzer/python-ecdsa.
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

import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';

class ECPointUtils {
  /// Sums the results of multiplication of two points on the elliptic curve (`P` and `Q`) by two different scalars (`k` and `l`).
  /// This operation uses Strauss-Shamir trick, which allows to reduce the number of required point operations on the curve.
  static ECPoint sumTwoMultiplies(ECPoint P, BigInt k, ECPoint Q, BigInt l) {
    int m = max(k.bitLength, l.bitLength);

    ECPoint Z = P + Q;
    ECPoint R = ECPoint.infinityFrom(P);

    for (int i = m - 1; i >= 0; --i) {
      R = doublePoint(R);

      if (BigIntUtils.getBit(k, i)) {
        if (BigIntUtils.getBit(l, i)) {
          R = R + Z;
        } else {
          R = R + P;
        }
      } else {
        if (BigIntUtils.getBit(l, i)) {
          R = R + Q;
        }
      }
    }

    return R;
  }

  /// Adds two points in projective coordinates on an elliptic curve
  static ECPoint addPoints(ECPoint point1, ECPoint point2) {
    // If y1 = 0 or z1 = 0 then Point1 is the point at infinity, and the result is Point2
    if (point1.isInfinity) {
      return point2;
    }

    // If y2 = 0 or z2 = 0 then Point2 is the point at infinity, and the result is Point1
    if (point2.isInfinity) {
      return point1;
    }

    // If z1 = z2 proceed to the regular affine point addition.
    if (point1.z == BigInt.one && point2.z == BigInt.one) {
      return _addAffinePoints(point1, point2);
    }

    // If z1 = z2 proceed to the projective point addition with z equal
    if (point1.z == point2.z) {
      return _addProjectivePointsWithZEqual(point1, point2);
    }

    // If z1 = 1 convert Point1 to projective coordinates by scaling Point2 appropriately
    if (point1.z == BigInt.one) {
      return _addProjectivePointToAffinePoint(point2, point1);
    }

    // If z2 = 1 convert Point2 to projective coordinates by scaling Point1 appropriately
    if (point2.z == BigInt.one) {
      return _addProjectivePointToAffinePoint(point1, point2);
    }

    // If z1 = z2 proceed to the regular projective point addition
    return _addProjectivePointsWithZNotEqual(point1, point2);
  }

  /// Doubles a point on an elliptic curve
  static ECPoint doublePoint(ECPoint point) {
    if (point.z == BigInt.one) {
      return _doubleAffinePoints(point);
    }

    if (point.isInfinity) {
      return ECPoint.infinityFrom(point);
    }

    BigInt xSquared = (point.x * point.x) % point.curve.p;
    BigInt ySquared = (point.y * point.y) % point.curve.p;

    if (ySquared == BigInt.zero) {
      return ECPoint.infinityFrom(point);
    }

    BigInt ySquaredSquared = (ySquared * ySquared) % point.curve.p;
    BigInt zSquared = (point.z * point.z) % point.curve.p;

    BigInt s = (BigInt.two * ((point.x + ySquared) * (point.x + ySquared) - xSquared - ySquaredSquared)) % point.curve.p;
    BigInt m = (BigInt.from(3) * xSquared + point.curve.a * zSquared * zSquared) % point.curve.p;
    BigInt t = (m * m - BigInt.from(2) * s) % point.curve.p;

    BigInt yResult = (m * (s - t) - BigInt.from(8) * ySquaredSquared) % point.curve.p;
    BigInt zResult = ((point.y + point.z) * (point.y + point.z) - ySquared - zSquared) % point.curve.p;

    return ECPoint(curve: point.curve, n: point.n, x: t, y: yResult, z: zResult);
  }

  /// Doubles affine point on an elliptic curve
  static ECPoint _doubleAffinePoints(ECPoint affinePoint) {
    BigInt xSquared = (affinePoint.x * affinePoint.x) % affinePoint.curve.p;
    BigInt ySquared = (affinePoint.y * affinePoint.y) % affinePoint.curve.p;

    if (ySquared == BigInt.zero) {
      return ECPoint.infinityFrom(affinePoint);
    }

    BigInt ySquaredSquared = (ySquared * ySquared) % affinePoint.curve.p;

    BigInt s = (BigInt.two * ((affinePoint.x + ySquared) * (affinePoint.x + ySquared) - xSquared - ySquaredSquared)) % affinePoint.curve.p;
    BigInt m = (BigInt.from(3) * xSquared + affinePoint.curve.a) % affinePoint.curve.p;
    BigInt t = (m * m - BigInt.from(2) * s) % affinePoint.curve.p;

    BigInt yResult = (m * (s - t) - BigInt.from(8) * ySquaredSquared) % affinePoint.curve.p;
    BigInt zResult = (BigInt.two * affinePoint.y) % affinePoint.curve.p;

    return ECPoint(curve: affinePoint.curve, n: affinePoint.n, x: t, y: yResult, z: zResult);
  }

  /// Adds two affine points with z-coordinate equal to one on an elliptic curve
  static ECPoint _addAffinePoints(ECPoint affinePoint1, ECPoint affinePoint2) {
    ECCurve curve = affinePoint1.curve;

    BigInt diff = affinePoint2.x - affinePoint1.x;
    BigInt diffSquare = diff * diff;

    BigInt I = (diffSquare * BigInt.from(4)) % curve.p;
    BigInt J = diff * I;

    BigInt affineYDifference = (affinePoint2.y - affinePoint1.y) * BigInt.from(2);

    if (diff == BigInt.zero && affineYDifference == BigInt.zero) {
      return _doubleAffinePoints(affinePoint1);
    }

    BigInt V = affinePoint1.x * I;
    BigInt x3 = (affineYDifference * affineYDifference - J - V * BigInt.from(2)) % curve.p;
    BigInt y3 = (affineYDifference * (V - x3) - affinePoint1.y * J * BigInt.from(2)) % curve.p;
    BigInt z3 = diff * BigInt.from(2) % curve.p;

    return ECPoint(curve: curve, n: affinePoint1.n, x: x3, y: y3, z: z3);
  }

  /// Adds two projective points with the same z-coordinate on an elliptic curve
  static ECPoint _addProjectivePointsWithZEqual(ECPoint projectivePoint1, ECPoint projectivePoint2) {
    ECCurve curve = projectivePoint1.curve;

    BigInt A = (projectivePoint2.x - projectivePoint1.x).modPow(BigInt.from(2), curve.p);
    BigInt B = (projectivePoint1.x * A) % curve.p;
    BigInt C = projectivePoint2.x * A;
    BigInt D = (projectivePoint2.y - projectivePoint1.y).modPow(BigInt.from(2), curve.p);

    if (A == BigInt.zero && D == BigInt.zero) {
      return doublePoint(projectivePoint1);
    }

    BigInt x3 = (D - B - C) % curve.p;
    BigInt y3 = ((projectivePoint2.y - projectivePoint1.y) * (B - x3) - projectivePoint1.y * (C - B)) % curve.p;
    BigInt z3 = (projectivePoint1.z * (projectivePoint2.x - projectivePoint1.x)) % curve.p;

    return ECPoint(curve: curve, n: projectivePoint1.n, x: x3, y: y3, z: z3);
  }

  /// Adds projective point to affine point on an elliptic curve
  static ECPoint _addProjectivePointToAffinePoint(ECPoint projectivePoint, ECPoint affinePoint) {
    ECCurve curve = projectivePoint.curve;

    BigInt z1z1 = (projectivePoint.z * projectivePoint.z) % curve.p;
    BigInt u2 = (affinePoint.x * z1z1) % curve.p;
    BigInt s2 = (affinePoint.y * projectivePoint.z * z1z1) % curve.p;

    BigInt h = (u2 - projectivePoint.x) % curve.p;
    BigInt hh = (h * h) % curve.p;
    BigInt i = (BigInt.from(4) * hh) % curve.p;
    BigInt j = (h * i) % curve.p;
    BigInt r = (BigInt.from(2) * (s2 - projectivePoint.y)) % curve.p;

    if (r == BigInt.zero && h == BigInt.zero) {
      return _doubleAffinePoints(affinePoint);
    }

    BigInt v = (projectivePoint.x * i) % curve.p;
    BigInt x3 = (r * r - j - BigInt.from(2) * v) % curve.p;
    BigInt y3 = (r * (v - x3) - BigInt.from(2) * projectivePoint.y * j) % curve.p;
    BigInt z3 = (((projectivePoint.z + h).modPow(BigInt.from(2), curve.p) - z1z1) - hh) % curve.p;

    return ECPoint(curve: curve, n: projectivePoint.n, x: x3, y: y3, z: z3);
  }

  /// Adds two projective points with different z-coordinates on an elliptic curve
  static ECPoint _addProjectivePointsWithZNotEqual(ECPoint projectivePoint1, ECPoint projectivePoint2) {
    ECCurve curve = projectivePoint1.curve;

    BigInt z1z1 = (projectivePoint1.z * projectivePoint1.z) % curve.p;
    BigInt z2z2 = (projectivePoint2.z * projectivePoint2.z) % curve.p;
    BigInt u1 = (projectivePoint1.x * z2z2) % curve.p;
    BigInt u2 = (projectivePoint2.x * z1z1) % curve.p;
    BigInt s1 = (projectivePoint1.y * projectivePoint2.z * z2z2) % curve.p;
    BigInt s2 = (projectivePoint2.y * projectivePoint1.z * z1z1) % curve.p;

    BigInt h = (u2 - u1) % curve.p;
    BigInt i = (BigInt.from(4) * h * h) % curve.p;
    BigInt j = (h * i) % curve.p;
    BigInt r = (BigInt.from(2) * (s2 - s1)) % curve.p;

    if (h == BigInt.zero && r == BigInt.zero) {
      return doublePoint(projectivePoint1);
    }

    BigInt v = (u1 * i) % curve.p;
    BigInt x3 = (r * r - j - BigInt.from(2) * v) % curve.p;
    BigInt y3 = (r * (v - x3) - BigInt.from(2) * s1 * j) % curve.p;
    BigInt z3 = (((projectivePoint1.z + projectivePoint2.z).modPow(BigInt.from(2), curve.p) - z1z1 - z2z2) * h) % curve.p;

    return ECPoint(curve: curve, n: projectivePoint1.n, x: x3, y: y3, z: z3);
  }
}
