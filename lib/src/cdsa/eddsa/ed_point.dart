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
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:cryptography_utils/src/utils/ed25519_utils.dart';
import 'package:equatable/equatable.dart';

/// [EDPoint] represents a point on an Edwards curve in the context of elliptic curve cryptography (ECC).
/// Points on an Edwards curve play a crucial role in cryptographic operations such as key generation, encryption, and digital signatures.
///
/// An [EDPoint] is typically defined by its coordinates (x, y) on the Edwards curve, adhering to the curve's equation.
/// For efficiency in computations and to support environments with constrained resources, extended coordinates may be used,
/// represented as (X, Y, Z) or more complex forms like (X, Y, Z, T), where T is an auxiliary variable for certain optimizations.
class EDPoint extends Equatable {
  /// The elliptic curve that the point is on.
  final EDCurve curve;

  /// The order of an Edwards curve group.
  /// It is the total number of points on the curve that satisfy the elliptic curve equation (typically a large prime number)
  final BigInt n;

  /// The x-coordinate of the point on the Edwards curve.
  /// Used for both affine and extended [EDPoint] representation.
  final BigInt x;

  /// The y-coordinate of the point on the Edwards curve.
  /// Used for both affine and extended [EDPoint] representation.
  final BigInt y;

  /// The z-coordinate of the point on the Edwards curve.
  /// Used only for extended [EDPoint] representation. In case of affine [EDPoint], the value is always zero.
  final BigInt z;

  /// The t auxiliary variable
  /// Used only for extended [EDPoint] representation. In case of affine [EDPoint], the value is always zero.
  final BigInt t;

  EDPoint({
    required this.curve,
    required this.n,
    BigInt? x,
    BigInt? y,
    BigInt? z,
    BigInt? t,
  })  : x = x ?? BigInt.zero,
        y = y ?? BigInt.zero,
        z = z ?? BigInt.zero,
        t = t ?? ((x ?? BigInt.zero) * (y ?? BigInt.zero));

  /// Constructs an instance of EDPoint from a byte array.
  factory EDPoint.fromBytes(EDPoint generator, Uint8List bytes) {
    Uint8List editableBytes = Uint8List.fromList(bytes);
    EDCurve curve = generator.curve;
    BigInt p = curve.p;
    int expLen = (p.bitLength + 8) ~/ 8;

    if (editableBytes.length != expLen) {
      throw const FormatException("AffinePoint length doesn't match the curve.");
    }

    int x0 = (editableBytes[expLen - 1] & 0x80) >> 7;
    editableBytes[expLen - 1] &= 0x80 - 1;

    BigInt y = BigIntUtils.decode(editableBytes, order: Endian.little);

    BigInt x2 = (y * y - BigInt.from(1)) * (curve.d * y * y - curve.a).modInverse(p) % p;
    BigInt x = ED25519Utils.findModularSquareRoot(a: x2, p: p);
    if (x.isOdd != (x0 == 1)) {
      x = (-x) % p;
    }

    return EDPoint(curve: curve, n: generator.n, x: x, y: y, z: BigInt.one, t: x * y);
  }

  /// Constructs an instance of [EDPoint] representing the point at infinity.
  factory EDPoint.infinityFrom(EDPoint edPoint) {
    return EDPoint(curve: edPoint.curve, n: edPoint.n);
  }

  EDPoint copyWith({
    EDCurve? curve,
    BigInt? n,
    BigInt? x,
    BigInt? y,
    BigInt? z,
    BigInt? t,
  }) {
    return EDPoint(
      curve: curve ?? this.curve,
      n: n ?? this.n,
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
      t: t ?? this.t,
    );
  }

  /// Negation operator overload
  ///
  /// In EdDSA (Edwards Curve Digital Signature Algorithm), point negation refers to the process of inverting the x-coordinate and t auxiliary variable
  /// of a point on the Edwards curve, while the y-coordinate and z-coordinate remain the same.
  ///
  /// If the original point is represented as P(x,y,z,t), the negated point becomes −P(-x,y,z,-t), following the curve's symmetry
  EDPoint operator -() {
    return copyWith(x: -x, t: -t);
  }

  /// Addition operator overload
  ///
  /// In EdDSA (Edwards Curve Digital Signature Algorithm), point addition involves adding two points on the Edwards curve.
  EDPoint operator +(EDPoint other) {
    BigInt A = (x * other.x) % curve.p;
    BigInt b = (y * other.y) % curve.p;
    BigInt c = (z * other.t) % curve.p;
    BigInt d = (t * other.z) % curve.p;
    BigInt e = d + c;
    BigInt f = (((x - y) * (other.x + other.y)) + b - A) % curve.p;
    BigInt g = b + (curve.a * A);
    BigInt h = d - c;

    if (h == BigInt.zero) {
      return _double();
    }

    BigInt x3 = (e * f) % curve.p;
    BigInt y3 = (g * h) % curve.p;
    BigInt z3 = (f * g) % curve.p;
    BigInt t3 = (e * h) % curve.p;

    if (x3 == BigInt.zero || t3 == BigInt.zero) {
      return EDPoint.infinityFrom(other);
    }

    return EDPoint(n: n, curve: curve, x: x3, y: y3, z: z3, t: t3);
  }

  /// Multiplication operator overload
  ///
  /// In EdDSA (Edwards Curve Digital Signature Algorithm), point multiplication involves multiplying a point on the elliptic curve by a scalar value.
  /// If the point is P and the scalar is k, the operation k∗P is essentially adding the point P to itself k times.
  ///
  /// This implementation utilizes the Double-and-Add algorithm combined with the wNAF (windowed Non-Adjacent Form) method for point multiplication in EdDSA.
  /// The Double-and-Add algorithm is an efficient iterative method that doubles the point and adds it to the total in each iteration, with the index decreasing.
  /// The incorporation of the wNAF method further optimizes this process by minimizing the number of required point additions.
  ///
  /// These algorithms significantly reduce the number of computations compared to straightforward addition.
  EDPoint operator *(BigInt scalar) {
    if (x == BigInt.zero || y == BigInt.zero || scalar == BigInt.zero) {
      return EDPoint.infinityFrom(this);
    }

    if (scalar == BigInt.one) {
      return this;
    }

    BigInt modScalar = scalar % (n * BigInt.two);
    EDPoint multipliedPoint = copyWith(
      x: BigInt.zero,
      y: BigInt.one,
      z: BigInt.one,
      t: BigInt.one,
    );

    List<BigInt> nafList = BigIntUtils.computeNAF(modScalar).reversed.toList();
    for (BigInt i in nafList) {
      multipliedPoint = multipliedPoint._double();

      if (i < BigInt.zero) {
        multipliedPoint = multipliedPoint + (-this);
      } else if (i > BigInt.zero) {
        multipliedPoint = multipliedPoint + this;
      }
    }

    if (multipliedPoint.x == BigInt.zero || multipliedPoint.t == BigInt.zero) {
      return EDPoint.infinityFrom(this);
    }

    return multipliedPoint;
  }

  /// Returns EDPoint as bytes
  Uint8List toBytes() {
    EDPoint scaledPoint = scaleToAffineCoordinates();
    int encLen = (curve.p.bitLength + 1 + 7) ~/ 8;
    Uint8List yStr = BigIntUtils.changeToBytes(scaledPoint.y, length: encLen, order: Endian.little);
    if (scaledPoint.x % BigInt.two == BigInt.one) {
      yStr[yStr.length - 1] |= 0x80;
    }
    return yStr;
  }

  /// Scales an Edwards curve point back to affine coordinates from extended coordinates.
  ///
  /// If the z-coordinate is already one, indicating that the point is in affine coordinates, the method returns the point as is.
  /// Otherwise, it scales the x, y coordinates and t auxiliary variable using the inverse of z, and sets z to one, converting the point to affine coordinates.
  EDPoint scaleToAffineCoordinates() {
    if (z == BigInt.one) {
      return this;
    }
    BigInt p = curve.p;

    BigInt zInv = z.modInverse(p);
    BigInt xVal = (x * zInv) % p;
    BigInt yVal = (y * zInv) % p;
    BigInt tVal = (xVal * yVal) % p;

    return EDPoint(curve: curve, n: n, x: xVal, y: yVal, z: BigInt.one, t: tVal);
  }

  /// Doubles a point in on an Edwards curve
  EDPoint _double() {
    BigInt A = (x * x) % curve.p;
    BigInt B = (y * y) % curve.p;
    BigInt C = (z * z * BigInt.two) % curve.p;
    BigInt D = (curve.a * A) % curve.p;
    BigInt E = (((x + y) * (x + y)) - A - B) % curve.p;
    BigInt G = D + B;
    BigInt F = G - C;
    BigInt H = D - B;
    BigInt x3 = (E * F) % curve.p;
    BigInt y3 = (G * H) % curve.p;
    BigInt t3 = (E * H) % curve.p;
    BigInt z3 = (F * G) % curve.p;

    return copyWith(x: x3, y: y3, z: z3, t: t3);
  }

  @override
  List<Object?> get props => <Object?>[curve, n, x, y, z, t];
}
