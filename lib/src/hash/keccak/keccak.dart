// This class was primarily influenced by:
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

import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/keccak/keccak_bit_length.dart';
import 'package:cryptography_utils/src/hash/keccak/keccakf1600.dart';

/// [Keccak256] is an implementation of Keccak algorithm which is a secure hash
/// function that creates fixed-size outputs from variable-length inputs.
class Keccak {
  final Uint8List _hashStateUint8List = Uint8List(200);
  final Uint8List _bufferUint8List = Uint8List(192);
  final KeccakBitLength _inputKeccakBitLength;

  late int _blockSize;
  late int _bufferBits;
  late int _outputBitLength;
  late bool _squeezeActiveBool;

  Keccak(this._inputKeccakBitLength) {
    _initSponge(_inputKeccakBitLength.bitLength);
  }

  int get _digestSize => _outputBitLength ~/ 8;

  Uint8List process(Uint8List inputUint8List) {
    _absorbData(inputUint8List, 0, inputUint8List.length);
    Uint8List outputUint8List = Uint8List(256);
    int length = _complete(outputUint8List, 0);
    return outputUint8List.sublist(0, length);
  }

  void _absorbData(Uint8List inputUint8List, int outputOffset, int inputBitLength) {
    int currentBytes = _bufferBits >> 3;
    int rateBytes = _blockSize >> 3;
    int availableBytes = rateBytes - currentBytes;

    if (inputBitLength < availableBytes) {
      _bufferUint8List.setRange(currentBytes, currentBytes + inputBitLength, inputUint8List, outputOffset);
      _bufferBits += inputBitLength << 3;
      return;
    }

    int processedBytes = 0;
    if (currentBytes > 0) {
      _bufferUint8List.setRange(currentBytes, currentBytes + availableBytes, inputUint8List.sublist(outputOffset));
      processedBytes += availableBytes;
      _absorbBlock(_bufferUint8List, 0);
    }

    int remainingBytes;
    while ((remainingBytes = inputBitLength - processedBytes) >= rateBytes) {
      _absorbBlock(inputUint8List, outputOffset + processedBytes);
      processedBytes += rateBytes;
    }

    _bufferUint8List.setRange(0, remainingBytes, inputUint8List, outputOffset + processedBytes);
    _bufferBits = remainingBytes << 3;
  }

  int _complete(Uint8List outputUint8List, int outputOffset) {
    _squeeze(outputUint8List, outputOffset, _outputBitLength);
    _resetState();
    return _digestSize;
  }

  void _squeeze(Uint8List inputUint8List, int outputOffset, int inputBitLength) {
    if (_squeezeActiveBool == false) {
      _startSqueezingPhase();
    }

    int i = 0;

    while (i < inputBitLength) {
      if (_bufferBits == 0) {
        _extractBlock();
      }

      int activeBlock = min(_bufferBits, inputBitLength - i);

      inputUint8List.setRange(
        outputOffset + (i ~/ 8),
        outputOffset + (i ~/ 8) + (activeBlock ~/ 8),
        _bufferUint8List.sublist((_blockSize - _bufferBits) ~/ 8),
      );

      _bufferBits -= activeBlock;
      i += activeBlock;
    }
  }

  void _resetState() {
    _initSponge(_outputBitLength);
  }

  void _initSponge(int inputBitLength) {
    int rate = 1600 - (inputBitLength << 1);

    _hashStateUint8List.fillRange(0, _hashStateUint8List.length, 0);
    _bufferUint8List.fillRange(0, _bufferUint8List.length, 0);
    _blockSize = rate;
    _outputBitLength = (1600 - rate) ~/ 2;
    _bufferBits = 0;
    _squeezeActiveBool = false;
  }

  void _startSqueezingPhase() {
    _bufferUint8List[_bufferBits >> 3] |= 1 << (_bufferBits & 7);
    if (++_bufferBits == _blockSize) {
      _absorbBlock(_bufferUint8List, 0);
    } else {
      int fullBytes = _bufferBits >> 6, partialBits = _bufferBits & 63;
      for (int i = 0; i < fullBytes * 8; ++i) {
        _hashStateUint8List[i] ^= _bufferUint8List[i];
      }
      if (partialBits > 0) {
        for (int k = 0; k != 8; k++) {
          if (partialBits >= 8) {
            _hashStateUint8List[fullBytes * 8 + k] ^= _bufferUint8List[fullBytes * 8 + k];
          } else {
            _hashStateUint8List[fullBytes * 8 + k] ^= _bufferUint8List[fullBytes * 8 + k] & ((1 << partialBits) - 1);
          }
          partialBits -= 8;
          if (partialBits < 0) {
            partialBits = 0;
          }
        }
      }
    }
    _hashStateUint8List[((_blockSize - 1) >> 3)] ^= 1 << 7;
    _bufferBits = 0;
    _squeezeActiveBool = true;
  }

  void _extractBlock() {
    _applyPermutation();
    _bufferUint8List.setRange(0, _blockSize >> 3, _hashStateUint8List);
    _bufferBits = _blockSize;
  }

  void _absorbBlock(Uint8List inputUint8List, int outputOffset) {
    int count = _blockSize >> 3;
    for (int i = 0; i < count; ++i) {
      _hashStateUint8List[i] ^= inputUint8List[outputOffset + i];
    }
    _applyPermutation();
  }

  void _applyPermutation() {
    KeccakF1600().applyPermutation(_hashStateUint8List);
  }
}
