//This class was primarily influenced by:
// "pointycastle" - Copyright (c) 2000 - 2019 The Legion of the Bouncy Castle Inc. (https://www.bouncycastle.org)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:typed_data';

import 'package:cryptography_utils/src/utils/register64/register64.dart';
import 'package:cryptography_utils/src/utils/register64/register64_list.dart';

///[KeccakF1600] This class is essential for processing input data through the sponge construction, ensuring proper diffusion and security
/// in hash computations. It operates on a 1600-bit state, repeatedly applying a series of transformations to mix the input data and produce
/// a secure cryptographic hash.
class KeccakF1600 {
  static final Register64List _roundConstRegister64List = Register64List.from(const <List<int>>[
    <int>[0x00000000, 0x00000001],
    <int>[0x00000000, 0x00008082],
    <int>[0x80000000, 0x0000808a],
    <int>[0x80000000, 0x80008000],
    <int>[0x00000000, 0x0000808b],
    <int>[0x00000000, 0x80000001],
    <int>[0x80000000, 0x80008081],
    <int>[0x80000000, 0x00008009],
    <int>[0x00000000, 0x0000008a],
    <int>[0x00000000, 0x00000088],
    <int>[0x00000000, 0x80008009],
    <int>[0x00000000, 0x8000000a],
    <int>[0x00000000, 0x8000808b],
    <int>[0x80000000, 0x0000008b],
    <int>[0x80000000, 0x00008089],
    <int>[0x80000000, 0x00008003],
    <int>[0x80000000, 0x00008002],
    <int>[0x80000000, 0x00000080],
    <int>[0x00000000, 0x0000800a],
    <int>[0x80000000, 0x8000000a],
    <int>[0x80000000, 0x80008081],
    <int>[0x80000000, 0x00008080],
    <int>[0x00000000, 0x80000001],
    <int>[0x80000000, 0x80008008]
  ]);

  static final List<int> _rotationOffsetsList = <int>[
    0x00000000,
    0x00000001,
    0x0000003e,
    0x0000001c,
    0x0000001b,
    0x00000024,
    0x0000002c,
    0x00000006,
    0x00000037,
    0x00000014,
    0x00000003,
    0x0000000a,
    0x0000002b,
    0x00000019,
    0x00000027,
    0x00000029,
    0x0000002d,
    0x0000000f,
    0x00000015,
    0x00000008,
    0x00000012,
    0x00000002,
    0x0000003d,
    0x00000038,
    0x0000000e
  ];

  void applyPermutation(Uint8List inputUint8List) {
    Register64List wordsRegister64List = Register64List(inputUint8List.length ~/ 8);

    _convertBytesToWords(wordsRegister64List, inputUint8List);
    _performPermutation(wordsRegister64List);
    _convertWordsToBytes(wordsRegister64List, inputUint8List);
  }

  void _convertBytesToWords(Register64List wordsRegister64List, Uint8List inputUint8List) {
    Register64 tmpRegister64 = Register64();

    for (int i = 0; i < (1600 ~/ 64); i++) {
      int byteIndex = i * (64 ~/ 8);
      wordsRegister64List[i].setInt(0);
      for (int j = 0; j < (64 ~/ 8); j++) {
        tmpRegister64
          ..setInt(inputUint8List[byteIndex + j])
          ..shiftLeft(8 * j);
        wordsRegister64List[i].performOr(tmpRegister64);
      }
    }
  }

  void _performPermutation(Register64List wordsRegister64List) {
    for (int numRounds = 0; numRounds < 24; numRounds++) {
      _performTheta(wordsRegister64List);
      _performRho(wordsRegister64List);
      _performPi(wordsRegister64List);
      _performChi(wordsRegister64List);
      _performIota(wordsRegister64List, numRounds);
    }
  }

  void _convertWordsToBytes(Register64List wordsRegister64List, Uint8List inputUint8List) {
    Register64 tmpRegister64 = Register64();

    for (int i = 0; i < (1600 ~/ 64); i++) {
      int byteIndex = i * (64 ~/ 8);

      for (int j = 0; j < (64 ~/ 8); j++) {
        tmpRegister64
          ..setRegister64(wordsRegister64List[i])
          ..shiftRight(8 * j);

        inputUint8List[byteIndex + j] = tmpRegister64.lowerHalf;
      }
    }
  }

  void _performTheta(Register64List wordsRegister64List) {
    Register64List columnRegister64List = Register64List(5);
    Register64 rotatedLeftRegister64 = Register64();
    Register64 rotatedRightRegister64 = Register64();

    for (int x = 0; x < 5; x++) {
      columnRegister64List[x].setInt(0);
      for (int y = 0; y < 5; y++) {
        columnRegister64List[x].performXor(wordsRegister64List[x + 5 * y]);
      }
    }

    for (int x = 0; x < 5; x++) {
      rotatedLeftRegister64
        ..setRegister64(columnRegister64List[(x + 1) % 5])
        ..shiftLeft(1);
      rotatedRightRegister64
        ..setRegister64(columnRegister64List[(x + 1) % 5])
        ..shiftRight(63);
      rotatedLeftRegister64
        ..performXor(rotatedRightRegister64)
        ..performXor(columnRegister64List[(x + 4) % 5]);

      for (int y = 0; y < 5; y++) {
        wordsRegister64List[x + 5 * y].performXor(rotatedLeftRegister64);
      }
    }
  }

  void _performRho(Register64List wordsRegister64List) {
    Register64 tmpRegister64 = Register64();

    for (int x = 0; x < 5; x++) {
      for (int y = 0; y < 5; y++) {
        int index = x + 5 * y;

        if (_rotationOffsetsList[index] != 0) {
          tmpRegister64
            ..setRegister64(wordsRegister64List[index])
            ..shiftRight(64 - _rotationOffsetsList[index]);
          wordsRegister64List[index]
            ..shiftLeft(_rotationOffsetsList[index])
            ..performXor(tmpRegister64);
        }
      }
    }
  }

  void _performPi(Register64List wordsRegister64List) {
    Register64List tmpRegister64List = Register64List(25);

    tmpRegister64List.setRange(0, tmpRegister64List.length, wordsRegister64List);

    for (int x = 0; x < 5; x++) {
      for (int y = 0; y < 5; y++) {
        wordsRegister64List[y + 5 * ((2 * x + 3 * y) % 5)].setRegister64(tmpRegister64List[x + 5 * y]);
      }
    }
  }

  void _performChi(Register64List wordsRegister64List) {
    Register64List tmpRegister64List = Register64List(5);

    for (int y = 0; y < 5; y++) {
      for (int x = 0; x < 5; x++) {
        tmpRegister64List[x].setRegister64(wordsRegister64List[((x + 1) % 5) + 5 * y]);
        tmpRegister64List[x].performNot();
        tmpRegister64List[x].performAnd(wordsRegister64List[((x + 2) % 5) + 5 * y]);
        tmpRegister64List[x].performXor(wordsRegister64List[x + 5 * y]);
      }

      for (int x = 0; x < 5; x++) {
        wordsRegister64List[x + 5 * y].setRegister64(tmpRegister64List[x]);
      }
    }
  }

  void _performIota(Register64List wordsRegister64List, int numRounds) {
    wordsRegister64List[0].performXor(_roundConstRegister64List[numRounds]);
  }
}
