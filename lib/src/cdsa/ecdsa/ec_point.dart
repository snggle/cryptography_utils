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
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// `ECPoint` represents a point on an elliptic curve in the context of elliptic curve cryptography (ECC).
/// Points on an elliptic curve are fundamental in cryptographic operations such as key generation, encryption, and digital signatures.
///
/// An `ECPoint` is often defined by its coordinates (x, y) in affine form on the elliptic curve.
/// However, to optimize certain computations, especially in environments with limited resources, projective coordinates are used which are represented as (x, y, z),
class ECPoint extends Equatable {
  /// The elliptic curve that the point is on.
  final ECCurve curve;

  /// The order of an elliptic curve group.
  /// It is the total number of points on the curve that satisfy the elliptic curve equation (typically a large prime number)
  final BigInt n;

  /// The x-coordinate of the point on the elliptic curve.
  /// Used for both affine and projective ECPoint representation.
  final BigInt x;

  /// The y-coordinate of the point on the elliptic curve.
  /// Used for both affine and projective ECPoint representation.
  final BigInt y;

  /// The z-coordinate of the point on the elliptic curve.
  /// Used only for projective ECPoint representation. In case of affine ECPoint, the value is always one.
  final BigInt z;

  ECPoint({
    required this.curve,
    required this.n,
    BigInt? x,
    BigInt? y,
    BigInt? z,
  })  : x = x ?? BigInt.zero,
        y = y ?? BigInt.zero,
        z = z ?? BigInt.one;

  factory ECPoint.infinityFrom(ECPoint ecPoint) {
    return ECPoint(curve: ecPoint.curve, n: ecPoint.n);
  }

  ECPoint copyWith({ECCurve? curve, BigInt? n, BigInt? x, BigInt? y, BigInt? z}) {
    return ECPoint(
      curve: curve ?? this.curve,
      n: n ?? this.n,
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
    );
  }

  /// Negation operator overload
  ///
  /// In ECDSA (Elliptic Curve Digital Signature Algorithm), point negation refers to the process of inverting the y-coordinate
  /// of a point on the elliptic curve, while the x-coordinate remains the same.
  ///
  /// If the original point is represented as P(x,y), the negated point becomes −P(x,−y), following the curve's symmetry about the x-axis.
  ECPoint operator -() {
    return copyWith(y: -y);
  }

  /// Addition operator overload
  ///
  /// In ECDSA (Elliptic Curve Digital Signature Algorithm), point addition involves adding two points on the elliptic curve.
  ECPoint operator +(ECPoint other) {
    if (isInfinity) {
      return other;
    }
    if (other.isInfinity) {
      return this;
    }

    ECPoint result = ECPointUtils.addPoints(this, other);

    if (result.isInfinity) {
      return ECPoint.infinityFrom(result);
    }

    return result;
  }

  /// Multiplication operator overload
  ///
  /// In ECDSA (Elliptic Curve Digital Signature Algorithm), point multiplication involves multiplying a point on the elliptic curve by a scalar value.
  /// If the point is P and the scalar is k, the operation k∗P is essentially adding the point P to itself k times.
  ///
  /// This implementation utilizes the Double-and-Add algorithm combined with the wNAF (windowed Non-Adjacent Form) method for point multiplication in ECDSA.
  /// The Double-and-Add algorithm is an efficient iterative method that doubles the point and adds it to the total in each iteration, with the index decreasing.
  /// The incorporation of the wNAF method further optimizes this process by minimizing the number of required point additions.
  ///
  /// These algorithms significantly reduce the number of computations compared to straightforward addition.
  ECPoint operator *(BigInt scalar) {
    if (y == BigInt.zero || scalar == BigInt.zero) {
      return ECPoint.infinityFrom(this);
    }
    if (scalar == BigInt.one) {
      return this;
    }
    BigInt modScalar = scalar % (n * BigInt.two);

    ECPoint affinePoint = _scaleToAffineCoordinates();
    ECPoint multipliedPoint = ECPoint.infinityFrom(this);

    List<BigInt> nafList = BigIntUtils.computeNAF(modScalar).reversed.toList();
    for (BigInt naf in nafList) {
      multipliedPoint = ECPointUtils.doublePoint(multipliedPoint);

      if (naf < BigInt.zero) {
        multipliedPoint = ECPointUtils.addPoints(multipliedPoint, -affinePoint);
      } else if (naf > BigInt.zero) {
        multipliedPoint = ECPointUtils.addPoints(multipliedPoint, affinePoint);
      }
    }

    if (multipliedPoint.y == BigInt.zero || multipliedPoint.z == BigInt.zero) {
      return ECPoint.infinityFrom(this);
    }

    return multipliedPoint;
  }

  /// Gets scaled affine x-coordinate from projective x-coordinate
  BigInt get affineX {
    if (z == BigInt.one) {
      return x;
    }

    BigInt zInverse = z.modInverse(curve.p);
    return (x * zInverse * zInverse) % curve.p;
  }

  /// Gets scaled affine y-coordinate from projective y-coordinate
  BigInt get affineY {
    if (z == BigInt.one) {
      return y;
    }

    BigInt zInverse = z.modInverse(curve.p);
    return (y * zInverse * zInverse * zInverse) % curve.p;
  }

  /// Checks if the point is an infinity point
  bool get isInfinity {
    return y == BigInt.zero || z == BigInt.zero;
  }

  /// Returns ECPoint as compressed/uncompressed bytes
  Uint8List toBytes({required bool compressedBool}) {
    if (compressedBool) {
      return _encodeAsCompressedBytes();
    } else {
      return _encodeAsUncompressedBytes();
    }
  }

  /// Scales an elliptic curve point back to affine coordinates from projective coordinates.
  ///
  /// If the z-coordinate is already one, indicating that the point is in affine coordinates, the method returns the point as is.
  /// Otherwise, it scales the x and y coordinates using the inverse of z, and sets z to one, converting the point to affine coordinates.
  ECPoint _scaleToAffineCoordinates() {
    if (z == BigInt.one) {
      return this;
    }
    return copyWith(x: affineX, y: affineY, z: BigInt.one);
  }

  /// Returns ECPoint as compressed bytes
  Uint8List _encodeAsCompressedBytes() {
    List<int> xStr = BigIntUtils.changeToBytes(affineX, length: BigIntUtils.calculateByteLength(curve.p));
    List<int> prefix;
    if (affineY & BigInt.one != BigInt.zero) {
      prefix = List<int>.from(<int>[0x03]);
    } else {
      prefix = List<int>.from(<int>[0x02]);
    }

    List<int> result = List<int>.filled(prefix.length + xStr.length, 0)
      ..setAll(0, prefix)
      ..setAll(prefix.length, xStr);

    return Uint8List.fromList(result);
  }

  /// Returns ECPoint as uncompressed bytes
  Uint8List _encodeAsUncompressedBytes() {
    final List<int> xBytes = BigIntUtils.changeToBytes(affineX, length: BigIntUtils.calculateByteLength(curve.p));
    final List<int> yBytes = BigIntUtils.changeToBytes(affineY, length: BigIntUtils.calculateByteLength(curve.p));
    return Uint8List.fromList(<int>[0x04, ...xBytes, ...yBytes]);
  }

  @override
  List<Object?> get props => <Object?>[curve, n, x, y, z];
}
