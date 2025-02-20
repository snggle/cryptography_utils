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

import 'package:equatable/equatable.dart';

///[Register64] serve as abstractions for managing the 64-bit lanes and the state matrix of the algorithm, ensuring clean and modular handling
/// of the algorithm’s 1600-bit internal state. Register64 is object represented by two 32-bit integers, together represent a 64-bit value.
class Register64 with EquatableMixin {
  static const int _mask5Bits = 0x1F;
  static const int _mask6Bits = 0x3F;
  static const int _mask32Bits = 0xFFFFFFFF;

  static const List<int> _mask32BitsList = <int>[
    0xFFFFFFFF,
    0x7FFFFFFF,
    0x3FFFFFFF,
    0x1FFFFFFF,
    0x0FFFFFFF,
    0x07FFFFFF,
    0x03FFFFFF,
    0x01FFFFFF,
    0x00FFFFFF,
    0x007FFFFF,
    0x003FFFFF,
    0x001FFFFF,
    0x000FFFFF,
    0x0007FFFF,
    0x0003FFFF,
    0x0001FFFF,
    0x0000FFFF,
    0x00007FFF,
    0x00003FFF,
    0x00001FFF,
    0x00000FFF,
    0x000007FF,
    0x000003FF,
    0x000001FF,
    0x000000FF,
    0x0000007F,
    0x0000003F,
    0x0000001F,
    0x0000000F,
    0x00000007,
    0x00000003,
    0x00000001,
    0x00000000
  ];

  late int _lowerHalf;
  late int _upperHalf;

  Register64([int initialValue = 0, int? lower32Bits]) {
    setInt(initialValue, lower32Bits);
  }

  int get lowerHalf => _lowerHalf;

  int get upperHalf => _upperHalf;

  void setRegister64(Register64 initialRegister64) {
    _upperHalf = initialRegister64._upperHalf;
    _lowerHalf = initialRegister64._lowerHalf;
  }

  void performAnd(Register64 otherRegister64) {
    _upperHalf &= otherRegister64._upperHalf;
    _lowerHalf &= otherRegister64._lowerHalf;
  }

  void performNot() {
    _upperHalf = ~_upperHalf & _mask32Bits;
    _lowerHalf = ~_lowerHalf & _mask32Bits;
  }

  void performOr(Register64 otherRegister64) {
    _upperHalf |= otherRegister64._upperHalf;
    _lowerHalf |= otherRegister64._lowerHalf;
  }

  void performXor(Register64 otherRegister64) {
    _upperHalf ^= otherRegister64._upperHalf;
    _lowerHalf ^= otherRegister64._lowerHalf;
  }

  int rotateLeft32Bits(int chunk32Bits, int offset) {
    int maskedOffset = offset & _mask5Bits;
    return _shiftLeft32Bits(chunk32Bits, maskedOffset) | (chunk32Bits >> (32 - maskedOffset));
  }

  void setInt(int initialValue, [int? lower32Bits]) {
    if (lower32Bits != null) {
      _upperHalf = initialValue;
      _lowerHalf = lower32Bits;
    } else {
      _upperHalf = 0;
      _lowerHalf = initialValue;
    }
  }

  void shiftLeft(int shiftValue) {
    int maskedN = shiftValue & _mask6Bits;
    if (maskedN == 0) {
      return;
    } else if (maskedN >= 32) {
      _upperHalf = _shiftLeft32Bits(_lowerHalf, maskedN - 32);
      _lowerHalf = 0;
    } else {
      _upperHalf = _shiftLeft32Bits(_upperHalf, maskedN);
      _upperHalf |= _lowerHalf >> (32 - maskedN);
      _lowerHalf = _shiftLeft32Bits(_lowerHalf, maskedN);
    }
  }

  void shiftRight(int shiftValue) {
    int maskedN = shiftValue & _mask6Bits;
    if (maskedN == 0) {
      return;
    } else if (maskedN >= 32) {
      _lowerHalf = _upperHalf >> (maskedN - 32);
      _upperHalf = 0;
    } else {
      _lowerHalf = _lowerHalf >> maskedN;
      _lowerHalf |= _shiftLeft32Bits(_upperHalf, 32 - maskedN);
      _upperHalf = upperHalf >> maskedN;
    }
  }

  void sumInt(int chunk32Bits) {
    int maskedChunk32Bits = chunk32Bits & _mask32Bits;
    int sumLowerHalf = _lowerHalf + maskedChunk32Bits;
    _lowerHalf = sumLowerHalf & _mask32Bits;
    if (sumLowerHalf != _lowerHalf) {
      _upperHalf++;
      _upperHalf &= _mask32Bits;
    }
  }

  int _shiftLeft32Bits(int chunk32Bits, int shiftValue) {
    int maskedN = shiftValue & _mask5Bits;
    int maskedX = chunk32Bits & _mask32BitsList[maskedN];
    return (maskedX << maskedN) & _mask32Bits;
  }

  @override
  List<int> get props => <int>[_upperHalf, _lowerHalf];
}
