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

import 'package:cryptography_utils/src/utils/int32_utils.dart';
import 'package:equatable/equatable.dart';

///[Register64] serve as abstractions for managing the 64-bit lanes and the state matrix of the algorithm, ensuring clean and modular handling
/// of the algorithm’s 1600-bit internal state. Register64 is object represented by two 32-bit integers, together represent a 64-bit value.
class Register64 with EquatableMixin {
  static const int _mask6Bits = 0x3F;
  static const int _mask32Bits = 0xFFFFFFFF;

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
      _upperHalf = Int32Utils.shiftLeft(_lowerHalf, maskedN - 32);
      _lowerHalf = 0;
    } else {
      _upperHalf = Int32Utils.shiftLeft(_upperHalf, maskedN);
      _upperHalf |= _lowerHalf >> (32 - maskedN);
      _lowerHalf = Int32Utils.shiftLeft(_lowerHalf, maskedN);
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
      _lowerHalf |= Int32Utils.shiftLeft(_upperHalf, 32 - maskedN);
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

  @override
  List<int> get props => <int>[_upperHalf, _lowerHalf];
}
