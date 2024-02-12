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
import 'package:cryptography_utils/src/utils/ristretto255_utils.dart';

/// `Ristretto255Point` represents a point on the Ristretto255 curve, a variant
/// of EDPoint designed for safer and more uniform elliptic curve cryptography.
class Ristretto255Point extends EDPoint {
  Ristretto255Point({
    required super.curve,
    required super.n,
    super.x,
    super.y,
    super.z,
    super.t,
  });

  /// Constructs an instance of Ristretto255Point from given EDPoint.
  factory Ristretto255Point.fromEDPoint(EDPoint edPoint) {
    return Ristretto255Point(
      curve: edPoint.curve,
      n: edPoint.n,
      x: edPoint.x,
      y: edPoint.y,
      z: edPoint.z,
      t: edPoint.t,
    );
  }

  /// Constructs an instance of Ristretto255Point from a byte array.
  factory Ristretto255Point.fromBytes(EDPoint generator, Uint8List bytes) {
    EDPoint edPoint = EDPoint.fromBytes(generator, bytes);
    return Ristretto255Point.fromEDPoint(edPoint);
  }

  /// Constructs an instance of Ristretto255Point representing the point at infinity.
  factory Ristretto255Point.infinityFrom(EDPoint edPoint) {
    return Ristretto255Point(curve: edPoint.curve, n: edPoint.n);
  }

  @override
  Ristretto255Point operator -() {
    return Ristretto255Point.fromEDPoint(-super);
  }

  @override
  Ristretto255Point operator +(EDPoint other) {
    return Ristretto255Point.fromEDPoint(super + other);
  }

  @override
  Ristretto255Point operator *(BigInt scalar) {
    return Ristretto255Point.fromEDPoint(super * scalar);
  }

  /// Serializes the Ristretto255 point to a 32-byte, little-endian format.
  /// This method overrides the serialization process for a Ristretto255 point, converting
  /// it into a uniformly distributed 32-byte array.
  @override
  Uint8List toBytes() {
    BigInt primeP = curve.p;

    BigInt u1 = Ristretto255Utils.positiveMod(Ristretto255Utils.positiveMod(z + y, primeP) * Ristretto255Utils.positiveMod(z - y, primeP), primeP);
    BigInt u2 = Ristretto255Utils.positiveMod(x * y, primeP);

    BigInt u2Squared = Ristretto255Utils.positiveMod(u2 * u2, primeP);
    BigInt invSqrt = Ristretto255Utils.calcSqrtUV(BigInt.one, Ristretto255Utils.positiveMod(u1 * u2Squared, primeP));

    BigInt d1 = Ristretto255Utils.positiveMod(invSqrt * u1, primeP);
    BigInt d2 = Ristretto255Utils.positiveMod(invSqrt * u2, primeP);

    BigInt zInverse = Ristretto255Utils.positiveMod(d1 * d2 * t, primeP);
    BigInt D;

    BigInt tmpX = x;
    BigInt tmpY = y;

    if (Ristretto255Utils.isOdd(t * zInverse, primeP)) {
      tmpX = Ristretto255Utils.positiveMod(y * Ristretto255Utils.sqrtM1, primeP);
      tmpY = Ristretto255Utils.positiveMod(x * Ristretto255Utils.sqrtM1, primeP);
      D = Ristretto255Utils.positiveMod(d1 * Ristretto255Utils.invSqrt, primeP);
    } else {
      D = d2;
    }

    if (Ristretto255Utils.isOdd(tmpX * zInverse, primeP)) {
      tmpY = Ristretto255Utils.positiveMod(-tmpY, primeP);
    }

    BigInt s = Ristretto255Utils.positiveMod((z - tmpY) * D, primeP);
    if (Ristretto255Utils.isOdd(s, primeP)) {
      s = Ristretto255Utils.positiveMod(-s, primeP);
    }

    return BigIntUtils.changeToBytes(s, order: Endian.little, length: 32);
  }

  @override
  Ristretto255Point scaleToAffineCoordinates() {
    EDPoint edPoint = super.scaleToAffineCoordinates();
    return Ristretto255Point.fromEDPoint(edPoint);
  }
}
