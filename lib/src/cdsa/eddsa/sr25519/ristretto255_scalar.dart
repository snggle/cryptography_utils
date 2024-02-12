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
import 'package:equatable/equatable.dart';

class Ristretto255Scalar extends Equatable {
  /// A constant representing the value 2097151 as a BigInt used in various scalar operations
  static final BigInt _b2097151 = BigInt.from(2097151);

  /// A constant representing the value 666643 as a BigInt used in various scalar operations
  static final BigInt _b666643 = BigInt.from(666643);

  /// A constant representing the value 470296 as a BigInt used in various scalar operations
  static final BigInt _b470296 = BigInt.from(470296);

  /// A constant representing the value 654183 as a BigInt used in various scalar operations
  static final BigInt _b654183 = BigInt.from(654183);

  /// A constant representing the value 997805 as a BigInt used in various scalar operations
  static final BigInt _b997805 = BigInt.from(997805);

  /// A constant representing the value 136657 as a BigInt used in various scalar operations
  static final BigInt _b136657 = BigInt.from(136657);

  /// A constant representing the value 683901 as a BigInt used in various scalar operations
  static final BigInt _b683901 = BigInt.from(683901);

  final BigInt scalar;

  const Ristretto255Scalar(this.scalar);

  /// Creates a [Ristretto255Scalar] from a byte array.
  /// Converts a 32-byte, little-endian encoded byte array into a scalar within the Ristretto255 group.
  factory Ristretto255Scalar.fromBytes(List<int> bytes) {
    if (bytes.length != 32) {
      throw ArgumentError('Bytes must be 32 bytes long');
    }
    final List<int> parsedBytes = bytes.map((int e) => e & 0xFF).toList();
    BigInt scalar = BigIntUtils.decode(parsedBytes, bitLength: 256, order: Endian.little);
    return Ristretto255Scalar(scalar);
  }

  /// Creates a [Ristretto255Scalar] from a uniform byte array.
  /// Converts a 64-byte, little-endian encoded byte array into a 32-byte scalar within the Ristretto255 group.
  factory Ristretto255Scalar.fromUniformBytes(Uint8List bytes) {
    if (bytes.length != 64) {
      throw ArgumentError('Uniform bytes must be 64 bytes long');
    }

    BigInt scalar = BigIntUtils.decode(bytes, order: Endian.little);
    BigInt reducedScalar = scalar % CurvePoints.generatorED25519.n;
    return Ristretto255Scalar(reducedScalar);
  }

  /// Represents the zero scalar value in the Ristretto255 group.
  /// Provides a convenient way to access a scalar value of zero,
  static Ristretto255Scalar zero = Ristretto255Scalar(BigInt.zero);

  /// Represents the one scalar value in the Ristretto255 group.
  /// Provides a convenient way to access a scalar value of one,
  static Ristretto255Scalar one = Ristretto255Scalar(BigInt.one);

  /// Adds scalar to another scalar within the Ristretto255 group
  Ristretto255Scalar operator +(Ristretto255Scalar other) {
    return _multiplyAndAddScalars(
      scalarA: Ristretto255Scalar.one,
      scalarB: this,
      scalarC: other,
    );
  }

  /// Multiplies scalar with another scalar within the Ristretto255 group
  Ristretto255Scalar operator *(Ristretto255Scalar other) {
    return _multiplyAndAddScalars(
      scalarA: this,
      scalarB: other,
      scalarC: Ristretto255Scalar.zero,
    );
  }

  /// Converts the scalar value to a 32-byte, little-endian format Uint8List.
  ///
  /// This method serializes the scalar value into a sequence of bytes, ensuring
  /// it is compatible with the Ristretto255 scalar field representation.
  Uint8List toBytes() {
    Uint8List bytes = BigIntUtils.changeToBytes(scalar, length: 32, order: Endian.little);
    final List<int> parsedBytes = bytes.map((int e) => e & 0xFF).toList();
    return Uint8List.fromList(parsedBytes);
  }

  /// Performs a complex modular arithmetic operation on three Ristretto255 scalars.
  ///
  /// This method computes the operation `(ab+c) mod l` on three given scalars, where:
  /// - `a`, `b`, and `c` are integers represented by the Ristretto255 scalars [scalarA], [scalarB], and [scalarC].
  /// - Each scalar is represented in a 256-bit little-endian format, such that:
  ///   - `a = a[0]+256*a[1]+...+256^31*a[31]`
  ///   - `b = b[0]+256*b[1]+...+256^31*b[31]`
  ///   - `c = c[0]+256*c[1]+...+256^31*c[31]`
  /// - The result `s` is also in a 256-bit little-endian format:
  ///   - `s = s[0]+256*s[1]+...+256^31*s[31]`
  /// - `l` is the Ristretto255 scalar field prime, `2^252 + 27742317777372353535851937790883648493`.
  ///
  /// https://github.com/orlp/ed25519/blob/master/src/sc.c
  static Ristretto255Scalar _multiplyAndAddScalars({
    required Ristretto255Scalar scalarA,
    required Ristretto255Scalar scalarB,
    required Ristretto255Scalar scalarC,
  }) {
    List<int> s = List<int>.filled(32, 0);

    Uint8List a = scalarA.toBytes();
    Uint8List b = scalarB.toBytes();
    Uint8List c = scalarC.toBytes();

    BigInt a0 = _b2097151 & _extractBigInt(a.sublist(0), 3);
    BigInt a1 = _b2097151 & (_extractBigInt(a.sublist(2), 4) >> 5);
    BigInt a2 = _b2097151 & (_extractBigInt(a.sublist(5), 3) >> 2);
    BigInt a3 = _b2097151 & (_extractBigInt(a.sublist(7), 4) >> 7);
    BigInt a4 = _b2097151 & (_extractBigInt(a.sublist(10), 4) >> 4);
    BigInt a5 = _b2097151 & (_extractBigInt(a.sublist(13), 3) >> 1);
    BigInt a6 = _b2097151 & (_extractBigInt(a.sublist(15), 4) >> 6);
    BigInt a7 = _b2097151 & (_extractBigInt(a.sublist(18), 3) >> 3);
    BigInt a8 = _b2097151 & _extractBigInt(a.sublist(21), 3);
    BigInt a9 = _b2097151 & (_extractBigInt(a.sublist(23), 4) >> 5);
    BigInt a10 = _b2097151 & (_extractBigInt(a.sublist(26), 3) >> 2);
    BigInt a11 = _extractBigInt(a.sublist(28), 4) >> 7;

    BigInt b0 = _b2097151 & _extractBigInt(b.sublist(0), 3);
    BigInt b1 = _b2097151 & (_extractBigInt(b.sublist(2), 4) >> 5);
    BigInt b2 = _b2097151 & (_extractBigInt(b.sublist(5), 3) >> 2);
    BigInt b3 = _b2097151 & (_extractBigInt(b.sublist(7), 4) >> 7);
    BigInt b4 = _b2097151 & (_extractBigInt(b.sublist(10), 4) >> 4);
    BigInt b5 = _b2097151 & (_extractBigInt(b.sublist(13), 3) >> 1);
    BigInt b6 = _b2097151 & (_extractBigInt(b.sublist(15), 4) >> 6);
    BigInt b7 = _b2097151 & (_extractBigInt(b.sublist(18), 3) >> 3);
    BigInt b8 = _b2097151 & _extractBigInt(b.sublist(21), 3);
    BigInt b9 = _b2097151 & (_extractBigInt(b.sublist(23), 4) >> 5);
    BigInt b10 = _b2097151 & (_extractBigInt(b.sublist(26), 3) >> 2);
    BigInt b11 = _extractBigInt(b.sublist(28), 4) >> 7;

    BigInt c0 = _b2097151 & _extractBigInt(c.sublist(0), 3);
    BigInt c1 = _b2097151 & (_extractBigInt(c.sublist(2), 4) >> 5);
    BigInt c2 = _b2097151 & (_extractBigInt(c.sublist(5), 3) >> 2);
    BigInt c3 = _b2097151 & (_extractBigInt(c.sublist(7), 4) >> 7);
    BigInt c4 = _b2097151 & (_extractBigInt(c.sublist(10), 4) >> 4);
    BigInt c5 = _b2097151 & (_extractBigInt(c.sublist(13), 3) >> 1);
    BigInt c6 = _b2097151 & (_extractBigInt(c.sublist(15), 4) >> 6);
    BigInt c7 = _b2097151 & (_extractBigInt(c.sublist(18), 3) >> 3);
    BigInt c8 = _b2097151 & _extractBigInt(c.sublist(21), 3);
    BigInt c9 = _b2097151 & (_extractBigInt(c.sublist(23), 4) >> 5);
    BigInt c10 = _b2097151 & (_extractBigInt(c.sublist(26), 3) >> 2);
    BigInt c11 = _extractBigInt(c.sublist(28), 4) >> 7;
    List<BigInt> carry = List<BigInt>.filled(23, BigInt.zero);
    BigInt s0 = c0 + a0 * b0;
    BigInt s1 = c1 + a0 * b1 + a1 * b0;
    BigInt s2 = c2 + a0 * b2 + a1 * b1 + a2 * b0;
    BigInt s3 = c3 + a0 * b3 + a1 * b2 + a2 * b1 + a3 * b0;
    BigInt s4 = c4 + a0 * b4 + a1 * b3 + a2 * b2 + a3 * b1 + a4 * b0;
    BigInt s5 = c5 + a0 * b5 + a1 * b4 + a2 * b3 + a3 * b2 + a4 * b1 + a5 * b0;
    BigInt s6 = c6 + a0 * b6 + a1 * b5 + a2 * b4 + a3 * b3 + a4 * b2 + a5 * b1 + a6 * b0;
    BigInt s7 = c7 + a0 * b7 + a1 * b6 + a2 * b5 + a3 * b4 + a4 * b3 + a5 * b2 + a6 * b1 + a7 * b0;
    BigInt s8 = c8 + a0 * b8 + a1 * b7 + a2 * b6 + a3 * b5 + a4 * b4 + a5 * b3 + a6 * b2 + a7 * b1 + a8 * b0;
    BigInt s9 = c9 + a0 * b9 + a1 * b8 + a2 * b7 + a3 * b6 + a4 * b5 + a5 * b4 + a6 * b3 + a7 * b2 + a8 * b1 + a9 * b0;
    BigInt s10 = c10 + a0 * b10 + a1 * b9 + a2 * b8 + a3 * b7 + a4 * b6 + a5 * b5 + a6 * b4 + a7 * b3 + a8 * b2 + a9 * b1 + a10 * b0;
    BigInt s11 = c11 + a0 * b11 + a1 * b10 + a2 * b9 + a3 * b8 + a4 * b7 + a5 * b6 + a6 * b5 + a7 * b4 + a8 * b3 + a9 * b2 + a10 * b1 + a11 * b0;
    BigInt s12 = a1 * b11 + a2 * b10 + a3 * b9 + a4 * b8 + a5 * b7 + a6 * b6 + a7 * b5 + a8 * b4 + a9 * b3 + a10 * b2 + a11 * b1;
    BigInt s13 = a2 * b11 + a3 * b10 + a4 * b9 + a5 * b8 + a6 * b7 + a7 * b6 + a8 * b5 + a9 * b4 + a10 * b3 + a11 * b2;
    BigInt s14 = a3 * b11 + a4 * b10 + a5 * b9 + a6 * b8 + a7 * b7 + a8 * b6 + a9 * b5 + a10 * b4 + a11 * b3;
    BigInt s15 = a4 * b11 + a5 * b10 + a6 * b9 + a7 * b8 + a8 * b7 + a9 * b6 + a10 * b5 + a11 * b4;
    BigInt s16 = a5 * b11 + a6 * b10 + a7 * b9 + a8 * b8 + a9 * b7 + a10 * b6 + a11 * b5;
    BigInt s17 = a6 * b11 + a7 * b10 + a8 * b9 + a9 * b8 + a10 * b7 + a11 * b6;
    BigInt s18 = a7 * b11 + a8 * b10 + a9 * b9 + a10 * b8 + a11 * b7;
    BigInt s19 = a8 * b11 + a9 * b10 + a10 * b9 + a11 * b8;
    BigInt s20 = a9 * b11 + a10 * b10 + a11 * b9;
    BigInt s21 = a10 * b11 + a11 * b10;
    BigInt s22 = a11 * b11;
    BigInt s23 = BigInt.zero;
    carry[0] = (s0 + (BigInt.one << 20)) >> 21;
    s1 += carry[0];
    s0 -= carry[0] << 21;
    carry[2] = (s2 + (BigInt.one << 20)) >> 21;
    s3 += carry[2];
    s2 -= carry[2] << 21;
    carry[4] = (s4 + (BigInt.one << 20)) >> 21;
    s5 += carry[4];
    s4 -= carry[4] << 21;
    carry[6] = (s6 + (BigInt.one << 20)) >> 21;
    s7 += carry[6];
    s6 -= carry[6] << 21;
    carry[8] = (s8 + (BigInt.one << 20)) >> 21;
    s9 += carry[8];
    s8 -= carry[8] << 21;
    carry[10] = (s10 + (BigInt.one << 20)) >> 21;
    s11 += carry[10];
    s10 -= carry[10] << 21;
    carry[12] = (s12 + (BigInt.one << 20)) >> 21;
    s13 += carry[12];
    s12 -= carry[12] << 21;
    carry[14] = (s14 + (BigInt.one << 20)) >> 21;
    s15 += carry[14];
    s14 -= carry[14] << 21;
    carry[16] = (s16 + (BigInt.one << 20)) >> 21;
    s17 += carry[16];
    s16 -= carry[16] << 21;
    carry[18] = (s18 + (BigInt.one << 20)) >> 21;
    s19 += carry[18];
    s18 -= carry[18] << 21;
    carry[20] = (s20 + (BigInt.one << 20)) >> 21;
    s21 += carry[20];
    s20 -= carry[20] << 21;
    carry[22] = (s22 + (BigInt.one << 20)) >> 21;
    s23 += carry[22];
    s22 -= carry[22] << 21;
    //
    carry[1] = (s1 + (BigInt.one << 20)) >> 21;
    s2 += carry[1];
    s1 -= carry[1] << 21;
    carry[3] = (s3 + (BigInt.one << 20)) >> 21;
    s4 += carry[3];
    s3 -= carry[3] << 21;
    carry[5] = (s5 + (BigInt.one << 20)) >> 21;
    s6 += carry[5];
    s5 -= carry[5] << 21;
    carry[7] = (s7 + (BigInt.one << 20)) >> 21;
    s8 += carry[7];
    s7 -= carry[7] << 21;
    carry[9] = (s9 + (BigInt.one << 20)) >> 21;
    s10 += carry[9];
    s9 -= carry[9] << 21;
    carry[11] = (s11 + (BigInt.one << 20)) >> 21;
    s12 += carry[11];
    s11 -= carry[11] << 21;
    carry[13] = (s13 + (BigInt.one << 20)) >> 21;
    s14 += carry[13];
    s13 -= carry[13] << 21;
    carry[15] = (s15 + (BigInt.one << 20)) >> 21;
    s16 += carry[15];
    s15 -= carry[15] << 21;
    carry[17] = (s17 + (BigInt.one << 20)) >> 21;
    s18 += carry[17];
    s17 -= carry[17] << 21;
    carry[19] = (s19 + (BigInt.one << 20)) >> 21;
    s20 += carry[19];
    s19 -= carry[19] << 21;
    carry[21] = (s21 + (BigInt.one << 20)) >> 21;
    s22 += carry[21];
    s21 -= carry[21] << 21;

    s11 += s23 * _b666643;
    s12 += s23 * _b470296;
    s13 += s23 * _b654183;
    s14 -= s23 * _b997805;
    s15 += s23 * _b136657;
    s16 -= s23 * _b683901;
    s23 = BigInt.zero;

    s10 += s22 * _b666643;
    s11 += s22 * _b470296;
    s12 += s22 * _b654183;
    s13 -= s22 * _b997805;
    s14 += s22 * _b136657;
    s15 -= s22 * _b683901;
    s22 = BigInt.zero;

    s9 += s21 * _b666643;
    s10 += s21 * _b470296;
    s11 += s21 * _b654183;
    s12 -= s21 * _b997805;
    s13 += s21 * _b136657;
    s14 -= s21 * _b683901;
    s21 = BigInt.zero;

    s8 += s20 * _b666643;
    s9 += s20 * _b470296;
    s10 += s20 * _b654183;
    s11 -= s20 * _b997805;
    s12 += s20 * _b136657;
    s13 -= s20 * _b683901;
    s20 = BigInt.zero;

    s7 += s19 * _b666643;
    s8 += s19 * _b470296;
    s9 += s19 * _b654183;
    s10 -= s19 * _b997805;
    s11 += s19 * _b136657;
    s12 -= s19 * _b683901;
    s19 = BigInt.zero;

    s6 += s18 * _b666643;
    s7 += s18 * _b470296;
    s8 += s18 * _b654183;
    s9 -= s18 * _b997805;
    s10 += s18 * _b136657;
    s11 -= s18 * _b683901;
    s18 = BigInt.zero;

    carry[6] = (s6 + (BigInt.one << 20)) >> 21;
    s7 += carry[6];
    s6 -= carry[6] << 21;
    carry[8] = (s8 + (BigInt.one << 20)) >> 21;
    s9 += carry[8];
    s8 -= carry[8] << 21;
    carry[10] = (s10 + (BigInt.one << 20)) >> 21;
    s11 += carry[10];
    s10 -= carry[10] << 21;
    carry[12] = (s12 + (BigInt.one << 20)) >> 21;
    s13 += carry[12];
    s12 -= carry[12] << 21;
    carry[14] = (s14 + (BigInt.one << 20)) >> 21;
    s15 += carry[14];
    s14 -= carry[14] << 21;
    carry[16] = (s16 + (BigInt.one << 20)) >> 21;
    s17 += carry[16];
    s16 -= carry[16] << 21;

    carry[7] = (s7 + (BigInt.one << 20)) >> 21;
    s8 += carry[7];
    s7 -= carry[7] << 21;
    carry[9] = (s9 + (BigInt.one << 20)) >> 21;
    s10 += carry[9];
    s9 -= carry[9] << 21;
    carry[11] = (s11 + (BigInt.one << 20)) >> 21;
    s12 += carry[11];
    s11 -= carry[11] << 21;
    carry[13] = (s13 + (BigInt.one << 20)) >> 21;
    s14 += carry[13];
    s13 -= carry[13] << 21;
    carry[15] = (s15 + (BigInt.one << 20)) >> 21;
    s16 += carry[15];
    s15 -= carry[15] << 21;

    s5 += s17 * _b666643;
    s6 += s17 * _b470296;
    s7 += s17 * _b654183;
    s8 -= s17 * _b997805;
    s9 += s17 * _b136657;
    s10 -= s17 * _b683901;
    s17 = BigInt.zero;

    s4 += s16 * _b666643;
    s5 += s16 * _b470296;
    s6 += s16 * _b654183;
    s7 -= s16 * _b997805;
    s8 += s16 * _b136657;
    s9 -= s16 * _b683901;
    s16 = BigInt.zero;

    s3 += s15 * _b666643;
    s4 += s15 * _b470296;
    s5 += s15 * _b654183;
    s6 -= s15 * _b997805;
    s7 += s15 * _b136657;
    s8 -= s15 * _b683901;
    s15 = BigInt.zero;

    s2 += s14 * _b666643;
    s3 += s14 * _b470296;
    s4 += s14 * _b654183;
    s5 -= s14 * _b997805;
    s6 += s14 * _b136657;
    s7 -= s14 * _b683901;
    s14 = BigInt.zero;

    s1 += s13 * _b666643;
    s2 += s13 * _b470296;
    s3 += s13 * _b654183;
    s4 -= s13 * _b997805;
    s5 += s13 * _b136657;
    s6 -= s13 * _b683901;
    s13 = BigInt.zero;

    s0 += s12 * _b666643;
    s1 += s12 * _b470296;
    s2 += s12 * _b654183;
    s3 -= s12 * _b997805;
    s4 += s12 * _b136657;
    s5 -= s12 * _b683901;
    s12 = BigInt.zero;

    carry[0] = (s0 + (BigInt.one << 20)) >> 21;
    s1 += carry[0];
    s0 -= carry[0] << 21;
    carry[2] = (s2 + (BigInt.one << 20)) >> 21;
    s3 += carry[2];
    s2 -= carry[2] << 21;
    carry[4] = (s4 + (BigInt.one << 20)) >> 21;
    s5 += carry[4];
    s4 -= carry[4] << 21;
    carry[6] = (s6 + (BigInt.one << 20)) >> 21;
    s7 += carry[6];
    s6 -= carry[6] << 21;
    carry[8] = (s8 + (BigInt.one << 20)) >> 21;
    s9 += carry[8];
    s8 -= carry[8] << 21;
    carry[10] = (s10 + (BigInt.one << 20)) >> 21;
    s11 += carry[10];
    s10 -= carry[10] << 21;

    carry[1] = (s1 + (BigInt.one << 20)) >> 21;
    s2 += carry[1];
    s1 -= carry[1] << 21;
    carry[3] = (s3 + (BigInt.one << 20)) >> 21;
    s4 += carry[3];
    s3 -= carry[3] << 21;
    carry[5] = (s5 + (BigInt.one << 20)) >> 21;
    s6 += carry[5];
    s5 -= carry[5] << 21;
    carry[7] = (s7 + (BigInt.one << 20)) >> 21;
    s8 += carry[7];
    s7 -= carry[7] << 21;
    carry[9] = (s9 + (BigInt.one << 20)) >> 21;
    s10 += carry[9];
    s9 -= carry[9] << 21;
    carry[11] = (s11 + (BigInt.one << 20)) >> 21;
    s12 += carry[11];
    s11 -= carry[11] << 21;

    s0 += s12 * _b666643;
    s1 += s12 * _b470296;
    s2 += s12 * _b654183;
    s3 -= s12 * _b997805;
    s4 += s12 * _b136657;
    s5 -= s12 * _b683901;
    s12 = BigInt.zero;

    carry[0] = s0 >> 21;
    s1 += carry[0];
    s0 -= carry[0] << 21;
    carry[1] = s1 >> 21;
    s2 += carry[1];
    s1 -= carry[1] << 21;
    carry[2] = s2 >> 21;
    s3 += carry[2];
    s2 -= carry[2] << 21;
    carry[3] = s3 >> 21;
    s4 += carry[3];
    s3 -= carry[3] << 21;
    carry[4] = s4 >> 21;
    s5 += carry[4];
    s4 -= carry[4] << 21;
    carry[5] = s5 >> 21;
    s6 += carry[5];
    s5 -= carry[5] << 21;
    carry[6] = s6 >> 21;
    s7 += carry[6];
    s6 -= carry[6] << 21;
    carry[7] = s7 >> 21;
    s8 += carry[7];
    s7 -= carry[7] << 21;
    carry[8] = s8 >> 21;
    s9 += carry[8];
    s8 -= carry[8] << 21;
    carry[9] = s9 >> 21;
    s10 += carry[9];
    s9 -= carry[9] << 21;
    carry[10] = s10 >> 21;
    s11 += carry[10];
    s10 -= carry[10] << 21;
    carry[11] = s11 >> 21;
    s12 += carry[11];
    s11 -= carry[11] << 21;

    s0 += s12 * _b666643;
    s1 += s12 * _b470296;
    s2 += s12 * _b654183;
    s3 -= s12 * _b997805;
    s4 += s12 * _b136657;
    s5 -= s12 * _b683901;
    s12 = BigInt.zero;

    carry[0] = s0 >> 21;
    s1 += carry[0];
    s0 -= carry[0] << 21;
    carry[1] = s1 >> 21;
    s2 += carry[1];
    s1 -= carry[1] << 21;
    carry[2] = s2 >> 21;
    s3 += carry[2];
    s2 -= carry[2] << 21;
    carry[3] = s3 >> 21;
    s4 += carry[3];
    s3 -= carry[3] << 21;
    carry[4] = s4 >> 21;
    s5 += carry[4];
    s4 -= carry[4] << 21;
    carry[5] = s5 >> 21;
    s6 += carry[5];
    s5 -= carry[5] << 21;
    carry[6] = s6 >> 21;
    s7 += carry[6];
    s6 -= carry[6] << 21;
    carry[7] = s7 >> 21;
    s8 += carry[7];
    s7 -= carry[7] << 21;
    carry[8] = s8 >> 21;
    s9 += carry[8];
    s8 -= carry[8] << 21;
    carry[9] = s9 >> 21;
    s10 += carry[9];
    s9 -= carry[9] << 21;
    carry[10] = s10 >> 21;
    s11 += carry[10];
    s10 -= carry[10] << 21;

    s[0] = (s0 >> 0).toInt();
    s[1] = (s0 >> 8).toInt();
    s[2] = ((s0 >> 16) | (s1 << 5)).toInt();
    s[3] = (s1 >> 3).toInt();
    s[4] = (s1 >> 11).toInt();
    s[5] = ((s1 >> 19) | (s2 << 2)).toInt();
    s[6] = (s2 >> 6).toInt();
    s[7] = ((s2 >> 14) | (s3 << 7)).toInt();
    s[8] = (s3 >> 1).toInt();
    s[9] = (s3 >> 9).toInt();
    s[10] = ((s3 >> 17) | (s4 << 4)).toInt();
    s[11] = (s4 >> 4).toInt();
    s[12] = (s4 >> 12).toInt();
    s[13] = ((s4 >> 20) | (s5 << 1)).toInt();
    s[14] = (s5 >> 7).toInt();
    s[15] = ((s5 >> 15) | (s6 << 6)).toInt();
    s[16] = (s6 >> 2).toInt();
    s[17] = (s6 >> 10).toInt();
    s[18] = ((s6 >> 18) | (s7 << 3)).toInt();
    s[19] = (s7 >> 5).toInt();
    s[20] = (s7 >> 13).toInt();
    s[21] = (s8 >> 0).toInt();
    s[22] = (s8 >> 8).toInt();
    s[23] = ((s8 >> 16) | (s9 << 5)).toInt();
    s[24] = (s9 >> 3).toInt();
    s[25] = (s9 >> 11).toInt();
    s[26] = ((s9 >> 19) | (s10 << 2)).toInt();
    s[27] = (s10 >> 6).toInt();
    s[28] = ((s10 >> 14) | (s11 << 7)).toInt();
    s[29] = (s11 >> 1).toInt();
    s[30] = (s11 >> 9).toInt();
    s[31] = (s11 >> 17).toInt();

    return Ristretto255Scalar.fromBytes(s);
  }

  /// Loads integer from a list and returns it as a BigInt.
  ///
  /// This method takes a list of integers and interprets the first 3 integers as
  /// little-endian bytes to form a 3-byte integer. It then converts this integer to
  /// a BigInt and returns it.
  static BigInt _extractBigInt(List<int> input, int byteSize) {
    int r = input[0];
    for (int i = 1; i < byteSize; i++) {
      r |= input[i] << (8 * i);
    }
    return BigInt.from(r);
  }

  @override
  List<Object?> get props => <Object>[scalar];
}
