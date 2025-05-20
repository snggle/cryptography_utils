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

import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes.dart';
import 'package:cryptography_utils/src/utils/binary_utils.dart';

/// PKCS#7 padding is used to ensure that the input to a block cipher
/// is a multiple of the block size. This class supports both padding
/// and unpadding (removal) operations.
class Pkcs7Padding implements ICipherPadding {
  const Pkcs7Padding();

  /// Adds PKCS#7 padding to the given [uint8list] starting from [offset].
  /// The value written into each padded byte is the number of padding
  /// bytes added. This makes it possible to identify and remove padding later.
  /// Returns the number of bytes added as padding.
  @override
  int addPadding(Uint8List uint8list, int offset) {
    int index = offset;
    int code = uint8list.length - index;

    while (index < uint8list.length) {
      uint8list[index] = code;
      index++;
    }
    return code;
  }

  /// Calculates the number of padding bytes at the end of [uint8list].
  /// Verifies that all padding bytes are valid. Throws [ArgumentError]
  /// if the padding is corrupted or inconsistent with PKCS#7 format.
  @override
  int calcPaddingCount(Uint8List uint8list) {
    int count = BinaryUtils.maskTo8Bits(uint8list[uint8list.length - 1]);

    if (count > uint8list.length || count == 0) {
      throw ArgumentError('Invalid or corrupted pad block a');
    }

    for (int i = 1; i <= count; i++) {
      if (uint8list[uint8list.length - i] != count) {
        throw ArgumentError('Invalid or corrupted pad block b');
      }
    }
    return count;
  }
}
