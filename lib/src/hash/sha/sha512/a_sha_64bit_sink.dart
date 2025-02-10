//This class was primarily influenced by:
// Copyright 2015, the Dart project authors.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
// * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following
// disclaimer in the documentation and/or other materials provided
// with the distribution.
// * Neither the name of Google LLC nor the names of its
// contributors may be used to endorse or promote products derived
// from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/a_hash_sink.dart';
import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';

///[ASha64BitSink] is an abstract class responsible for managing the internal state of the SHA-64 bit algorithm, using a 1600-bit state and multiple intermediate variables. It processes data through a series of transformations, including rotations, shifts, and bitwise operations, to generate the hash output.
abstract class ASha64BitSink extends AHashSink {
  static const int _hashVarAIndex = _sigmaIndex4 + 2;
  static const int _hashVarBIndex = _hashVarAIndex + 2;
  static const int _hashVarCIndex = _hashVarBIndex + 2;
  static const int _hashVarDIndex = _hashVarCIndex + 2;
  static const int _hashVarEIndex = _hashVarDIndex + 2;
  static const int _hashVarFIndex = _hashVarEIndex + 2;
  static const int _hashVarGIndex = _hashVarFIndex + 2;
  static const int _hashVarHIndex = _hashVarGIndex + 2;
  static const int _rotateRightIndex1 = 0;
  static const int _rotateRightIndex2 = _rotateRightIndex1 + 2;
  static const int _sigmaIndex1 = _rotateRightIndex2 + 2;
  static const int _sigmaIndex2 = _sigmaIndex1 + 2;
  static const int _sigmaIndex3 = _sigmaIndex2 + 2;
  static const int _sigmaIndex4 = _sigmaIndex3 + 2;
  static const int _tmp1Index = _hashVarHIndex + 2;
  static const int _tmp2Index = _tmp1Index + 2;
  static const int _tmp3Index = _tmp2Index + 2;
  static const int _tmp4Index = _tmp3Index + 2;
  static const int _tmp5Index = _tmp4Index + 2;
  static const int digestBytes = 16;

  final Uint32List _digestUint32List;
  final Uint32List _extendedUint32List = Uint32List(160);
  final Uint32List _numUint32List = Uint32List(12 + 16 + 10);
  final Uint32List _roundConstUint32List = Uint32List.fromList(<int>[
    0x428a2f98, 0xd728ae22, 0x71374491, 0x23ef65cd, //
    0xb5c0fbcf, 0xec4d3b2f, 0xe9b5dba5, 0x8189dbbc,
    0x3956c25b, 0xf348b538, 0x59f111f1, 0xb605d019,
    0x923f82a4, 0xaf194f9b, 0xab1c5ed5, 0xda6d8118,
    0xd807aa98, 0xa3030242, 0x12835b01, 0x45706fbe,
    0x243185be, 0x4ee4b28c, 0x550c7dc3, 0xd5ffb4e2,
    0x72be5d74, 0xf27b896f, 0x80deb1fe, 0x3b1696b1,
    0x9bdc06a7, 0x25c71235, 0xc19bf174, 0xcf692694,
    0xe49b69c1, 0x9ef14ad2, 0xefbe4786, 0x384f25e3,
    0x0fc19dc6, 0x8b8cd5b5, 0x240ca1cc, 0x77ac9c65,
    0x2de92c6f, 0x592b0275, 0x4a7484aa, 0x6ea6e483,
    0x5cb0a9dc, 0xbd41fbd4, 0x76f988da, 0x831153b5,
    0x983e5152, 0xee66dfab, 0xa831c66d, 0x2db43210,
    0xb00327c8, 0x98fb213f, 0xbf597fc7, 0xbeef0ee4,
    0xc6e00bf3, 0x3da88fc2, 0xd5a79147, 0x930aa725,
    0x06ca6351, 0xe003826f, 0x14292967, 0x0a0e6e70,
    0x27b70a85, 0x46d22ffc, 0x2e1b2138, 0x5c26c926,
    0x4d2c6dfc, 0x5ac42aed, 0x53380d13, 0x9d95b3df,
    0x650a7354, 0x8baf63de, 0x766a0abb, 0x3c77b2a8,
    0x81c2c92e, 0x47edaee6, 0x92722c85, 0x1482353b,
    0xa2bfe8a1, 0x4cf10364, 0xa81a664b, 0xbc423001,
    0xc24b8b70, 0xd0f89791, 0xc76c51a3, 0x0654be30,
    0xd192e819, 0xd6ef5218, 0xd6990624, 0x5565a910,
    0xf40e3585, 0x5771202a, 0x106aa070, 0x32bbd1b8,
    0x19a4c116, 0xb8d2d0c8, 0x1e376c08, 0x5141ab53,
    0x2748774c, 0xdf8eeb99, 0x34b0bcb5, 0xe19b48a8,
    0x391c0cb3, 0xc5c95a63, 0x4ed8aa4a, 0xe3418acb,
    0x5b9cca4f, 0x7763e373, 0x682e6ff3, 0xd6b2b8a3,
    0x748f82ee, 0x5defb2fc, 0x78a5636f, 0x43172f60,
    0x84c87814, 0xa1f0ab72, 0x8cc70208, 0x1a6439ec,
    0x90befffa, 0x23631e28, 0xa4506ceb, 0xde82bde9,
    0xbef9a3f7, 0xb2c67915, 0xc67178f2, 0xe372532b,
    0xca273ece, 0xea26619c, 0xd186b8c7, 0x21c0c207,
    0xeada7dd6, 0xcde0eb1e, 0xf57d4f7f, 0xee6ed178,
    0x06f067aa, 0x72176fba, 0x0a637dc5, 0xa2c898a6,
    0x113f9804, 0xbef90dae, 0x1b710b35, 0x131c471b,
    0x28db77f5, 0x23047d84, 0x32caab7b, 0x40c72493,
    0x3c9ebe0a, 0x15c9bebc, 0x431d67c4, 0x9c100d4c,
    0x4cc5d4be, 0xcb3e42b6, 0x597f299c, 0xfc657e2a,
    0x5fcb6fab, 0x3ad6faec, 0x6c44198c, 0x4a475817,
  ]);

  ASha64BitSink(Sink<Digest> sink, this._digestUint32List) : super(sink, 32, signaturesBytes: 16);

  @override
  Uint32List get digestUint32List {
    return Uint32List.view(_digestUint32List.buffer, 0, digestBytes);
  }

  @override
  void updateHash(Uint32List inputUint32List) {
    for (int i = 0; i < 32; i++) {
      _extendedUint32List[i] = inputUint32List[i];
    }

    for (int i = 32; i < 160; i += 2) {
      _applySmallSigma1(_extendedUint32List, i - 2 * 2, _numUint32List, _tmp1Index);
      _applyAdd(_numUint32List, _tmp1Index, _extendedUint32List, i - 7 * 2, _numUint32List, _tmp2Index);

      _applySmallSigma0(_extendedUint32List, i - 15 * 2, _numUint32List, _tmp1Index);

      _applyAdd(_numUint32List, _tmp1Index, _extendedUint32List, i - 16 * 2, _numUint32List, _tmp3Index);
      _applyAdd(_numUint32List, _tmp2Index, _numUint32List, _tmp3Index, _extendedUint32List, i);
    }

    _numUint32List.setRange(_hashVarAIndex, _hashVarHIndex + 2, _digestUint32List);

    for (int i = 0; i < 160; i += 2) {
      _applyBigSigma1(_numUint32List, _hashVarEIndex, _numUint32List, _tmp1Index);
      _applyAdd(_numUint32List, _hashVarHIndex, _numUint32List, _tmp1Index, _numUint32List, _tmp2Index);

      _applyChoiceBits(_numUint32List, _hashVarEIndex, _numUint32List, _hashVarFIndex, _numUint32List, _hashVarGIndex, _numUint32List, _tmp3Index);

      _applyAdd(_numUint32List, _tmp2Index, _numUint32List, _tmp3Index, _numUint32List, _tmp4Index);
      _applyAdd(_roundConstUint32List, i, _extendedUint32List, i, _numUint32List, _tmp5Index);
      _applyAdd(_numUint32List, _tmp4Index, _numUint32List, _tmp5Index, _numUint32List, _tmp1Index);

      _applyBigSigma0(_numUint32List, _hashVarAIndex, _numUint32List, _tmp3Index);

      _applyMajorityBits(_numUint32List, _hashVarAIndex, _numUint32List, _hashVarBIndex, _numUint32List, _hashVarCIndex, _numUint32List, _tmp4Index);
      _applyAdd(_numUint32List, _tmp3Index, _numUint32List, _tmp4Index, _numUint32List, _tmp2Index);

      _numUint32List[_hashVarHIndex] = _numUint32List[_hashVarGIndex];
      _numUint32List[_hashVarHIndex + 1] = _numUint32List[_hashVarGIndex + 1];
      _numUint32List[_hashVarGIndex] = _numUint32List[_hashVarFIndex];
      _numUint32List[_hashVarGIndex + 1] = _numUint32List[_hashVarFIndex + 1];
      _numUint32List[_hashVarFIndex] = _numUint32List[_hashVarEIndex];
      _numUint32List[_hashVarFIndex + 1] = _numUint32List[_hashVarEIndex + 1];

      _applyAdd(_numUint32List, _hashVarDIndex, _numUint32List, _tmp1Index, _numUint32List, _hashVarEIndex);

      _numUint32List[_hashVarDIndex] = _numUint32List[_hashVarCIndex];
      _numUint32List[_hashVarDIndex + 1] = _numUint32List[_hashVarCIndex + 1];
      _numUint32List[_hashVarCIndex] = _numUint32List[_hashVarBIndex];
      _numUint32List[_hashVarCIndex + 1] = _numUint32List[_hashVarBIndex + 1];
      _numUint32List[_hashVarBIndex] = _numUint32List[_hashVarAIndex];
      _numUint32List[_hashVarBIndex + 1] = _numUint32List[_hashVarAIndex + 1];

      _applyAdd(_numUint32List, _tmp1Index, _numUint32List, _tmp2Index, _numUint32List, _hashVarAIndex);
    }

    _applyAddWithCarry(_digestUint32List, 0, _numUint32List, _hashVarAIndex);
    _applyAddWithCarry(_digestUint32List, 2, _numUint32List, _hashVarBIndex);
    _applyAddWithCarry(_digestUint32List, 4, _numUint32List, _hashVarCIndex);
    _applyAddWithCarry(_digestUint32List, 6, _numUint32List, _hashVarDIndex);
    _applyAddWithCarry(_digestUint32List, 8, _numUint32List, _hashVarEIndex);
    _applyAddWithCarry(_digestUint32List, 10, _numUint32List, _hashVarFIndex);
    _applyAddWithCarry(_digestUint32List, 12, _numUint32List, _hashVarGIndex);
    _applyAddWithCarry(_digestUint32List, 14, _numUint32List, _hashVarHIndex);
  }

  void _applyBigSigma0(Uint32List inputUint32List, int offsetInput, Uint32List outputUint32List, int offsetRightOutput) {
    _rotateRight(28, inputUint32List, offsetInput, _numUint32List, _sigmaIndex1);
    _rotateRight(34, inputUint32List, offsetInput, _numUint32List, _sigmaIndex2);
    _rotateRight(39, inputUint32List, offsetInput, _numUint32List, _sigmaIndex3);

    _applyXor(_numUint32List, _sigmaIndex2, _numUint32List, _sigmaIndex3, _numUint32List, _sigmaIndex4);
    _applyXor(_numUint32List, _sigmaIndex1, _numUint32List, _sigmaIndex4, outputUint32List, offsetRightOutput);
  }

  void _applyBigSigma1(Uint32List inputUint32List, int offsetInput, Uint32List outputUint32List, int offsetRightOutput) {
    _rotateRight(14, inputUint32List, offsetInput, _numUint32List, _sigmaIndex1);
    _rotateRight(18, inputUint32List, offsetInput, _numUint32List, _sigmaIndex2);
    _rotateRight(41, inputUint32List, offsetInput, _numUint32List, _sigmaIndex3);

    _applyXor(_numUint32List, _sigmaIndex2, _numUint32List, _sigmaIndex3, _numUint32List, _sigmaIndex4);
    _applyXor(_numUint32List, _sigmaIndex1, _numUint32List, _sigmaIndex4, outputUint32List, offsetRightOutput);
  }

  void _applySmallSigma0(Uint32List inputUint32List, int offsetInput, Uint32List outputUint32List, int offsetRightOutput) {
    _rotateRight(1, inputUint32List, offsetInput, _numUint32List, _sigmaIndex1);
    _rotateRight(8, inputUint32List, offsetInput, _numUint32List, _sigmaIndex2);

    _shiftRight(7, inputUint32List, offsetInput, _numUint32List, _sigmaIndex3);

    _applyXor(_numUint32List, _sigmaIndex2, _numUint32List, _sigmaIndex3, _numUint32List, _sigmaIndex4);
    _applyXor(_numUint32List, _sigmaIndex1, _numUint32List, _sigmaIndex4, outputUint32List, offsetRightOutput);
  }

  void _applySmallSigma1(Uint32List inputUint32List, int offsetInput, Uint32List outputUint32List, int offsetRightOutput) {
    _rotateRight(19, inputUint32List, offsetInput, _numUint32List, _sigmaIndex1);
    _rotateRight(61, inputUint32List, offsetInput, _numUint32List, _sigmaIndex2);

    _shiftRight(6, inputUint32List, offsetInput, _numUint32List, _sigmaIndex3);

    _applyXor(_numUint32List, _sigmaIndex2, _numUint32List, _sigmaIndex3, _numUint32List, _sigmaIndex4);
    _applyXor(_numUint32List, _sigmaIndex1, _numUint32List, _sigmaIndex4, outputUint32List, offsetRightOutput);
  }

  void _rotateRight(int bits, Uint32List inputUint32List, int offsetInput, Uint32List outputUint32List, int offsetRightOutput) {
    _shiftRight(bits, inputUint32List, offsetInput, _numUint32List, _rotateRightIndex1);
    _shiftLeft(64 - bits, inputUint32List, offsetInput, _numUint32List, _rotateRightIndex2);

    _applyOr(_numUint32List, _rotateRightIndex1, _numUint32List, _rotateRightIndex2, outputUint32List, offsetRightOutput);
  }

  void _applyChoiceBits(Uint32List xInputUint32List, int xOffsetInput, Uint32List yInputUint32List, int yOffsetInput, Uint32List zInputUint32List,
      int zOffsetInput, Uint32List outputUint32List, int offsetRightOutput) {
    outputUint32List[0 + offsetRightOutput] =
        (xInputUint32List[0 + xOffsetInput] & (yInputUint32List[0 + yOffsetInput] ^ zInputUint32List[0 + zOffsetInput])) ^
            zInputUint32List[0 + zOffsetInput];

    outputUint32List[1 + offsetRightOutput] =
        (xInputUint32List[1 + xOffsetInput] & (yInputUint32List[1 + yOffsetInput] ^ zInputUint32List[1 + zOffsetInput])) ^
            zInputUint32List[1 + zOffsetInput];
  }

  void _applyMajorityBits(Uint32List xInputUint32List, int xOffsetInput, Uint32List yInputUint32List, int yOffsetInput, Uint32List zInputUint32List,
      int zOffsetInput, Uint32List outputUint32List, int offsetRightOutput) {
    outputUint32List[0 + offsetRightOutput] =
        (xInputUint32List[0 + xOffsetInput] & (yInputUint32List[0 + yOffsetInput] | zInputUint32List[0 + zOffsetInput])) |
            (yInputUint32List[0 + yOffsetInput] & zInputUint32List[0 + zOffsetInput]);

    outputUint32List[1 + offsetRightOutput] =
        (xInputUint32List[1 + xOffsetInput] & (yInputUint32List[1 + yOffsetInput] | zInputUint32List[1 + zOffsetInput])) |
            (yInputUint32List[1 + yOffsetInput] & zInputUint32List[1 + zOffsetInput]);
  }

  void _shiftRight(int bits, Uint32List inputUint32List, int offsetInput, Uint32List outputUint32List, int offsetRightOutput) {
    outputUint32List[0 + offsetRightOutput] = ((bits < 32) && (bits >= 0)) ? (inputUint32List[0 + offsetInput] >> bits) : 0;

    outputUint32List[1 + offsetRightOutput] = (bits > 32)
        ? (inputUint32List[0 + offsetInput] >> (bits - 32))
        : (bits == 32)
            ? inputUint32List[0 + offsetInput]
            : (bits >= 0)
                ? ((inputUint32List[0 + offsetInput]) << (32 - bits)) | (inputUint32List[1 + offsetInput] >> bits)
                : 0;
  }

  void _shiftLeft(int bits, Uint32List inputUint32List, int offsetInput, Uint32List outputUint32List, int offsetRightOutput) {
    outputUint32List[0 + offsetRightOutput] = (bits > 32)
        ? (inputUint32List[1 + offsetInput] << (bits - 32))
        : (bits == 32)
            ? inputUint32List[1 + offsetInput]
            : (bits >= 0)
                ? ((inputUint32List[0 + offsetInput]) << bits) | (inputUint32List[1 + offsetInput] >> (32 - bits))
                : 0;

    outputUint32List[1 + offsetRightOutput] = ((bits < 32) && (bits >= 0)) ? (inputUint32List[1 + offsetInput] << bits) : 0;
  }

  void _applyOr(Uint32List inputOneUint32List, int offsetOneInput, Uint32List inputTwoUint32List, int offsetTwoInput, Uint32List outputUint32List,
      int offsetRightOutput) {
    outputUint32List[0 + offsetRightOutput] = inputOneUint32List[0 + offsetOneInput] | inputTwoUint32List[0 + offsetTwoInput];

    outputUint32List[1 + offsetRightOutput] = inputOneUint32List[1 + offsetOneInput] | inputTwoUint32List[1 + offsetTwoInput];
  }

  void _applyXor(Uint32List inputOneUint32List, int offsetOneInput, Uint32List inputTwoUint32List, int offsetTwoInput, Uint32List outputUint32List,
      int offsetRightOutput) {
    outputUint32List[0 + offsetRightOutput] = inputOneUint32List[0 + offsetOneInput] ^ inputTwoUint32List[0 + offsetTwoInput];

    outputUint32List[1 + offsetRightOutput] = inputOneUint32List[1 + offsetOneInput] ^ inputTwoUint32List[1 + offsetTwoInput];
  }

  void _applyAdd(Uint32List inputOneUint32List, int offsetOneInput, Uint32List inputTwoUint32List, int offsetTwoInput, Uint32List outputUint32List,
      int offsetRightOutput) {
    outputUint32List[1 + offsetRightOutput] = inputOneUint32List[1 + offsetOneInput] + inputTwoUint32List[1 + offsetTwoInput];

    outputUint32List[0 + offsetRightOutput] = inputOneUint32List[0 + offsetOneInput] +
        inputTwoUint32List[0 + offsetTwoInput] +
        (outputUint32List[1 + offsetRightOutput] < inputOneUint32List[1 + offsetOneInput] ? 1 : 0);
  }

  void _applyAddWithCarry(Uint32List inputOneUint32List, int offsetOneInput, Uint32List inputTwoUint32List, int offsetTwoInput) {
    int addTmp = inputOneUint32List[1 + offsetOneInput];

    inputOneUint32List[1 + offsetOneInput] += inputTwoUint32List[1 + offsetTwoInput];
    inputOneUint32List[0 + offsetOneInput] += inputTwoUint32List[0 + offsetTwoInput] + (inputOneUint32List[1 + offsetOneInput] < addTmp ? 1 : 0);
  }
}
