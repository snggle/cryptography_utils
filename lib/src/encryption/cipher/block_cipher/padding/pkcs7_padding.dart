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

import 'package:cryptography_utils/src/encryption/cipher/block_cipher/invalid_length_exception.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/invalid_padding_value_exception.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/padding/i_cipher_padding.dart';
import 'package:cryptography_utils/src/utils/binary_utils.dart';

/// This class provides functionality for:
/// - Adding PKCS7 padding to input data prior to encryption.
/// - Validating and determining the length of PKCS7 padding after decryption.
///
/// In PKCS7, padding completes the encryption block by appending missing bytes, each of which has a value equal
/// to the total number of added bytes. In case of AES algorithm, the block size is 16 bytes.
/// This makes it possible to accurately remove the extra data and verify its correctness during decryption.
///
/// PKCS7 padding is used to ensure that the input to a block cipher is a multiple of the block size.

class Pkcs7Padding implements ICipherPadding {
  /// Adds PKCS7 padding to the given [uint8List] starting from [offset].
  /// The value written into each padded byte is the number of padding bytes added.
  /// This makes it possible to identify and remove padding later.
  /// Returns the number of bytes added as padding.
  @override
  int addPadding(Uint8List uint8List, int offset) {
    int index = offset;
    int code = uint8List.length - index;

    while (index < uint8List.length) {
      uint8List[index] = code;
      index++;
    }
    return code;
  }

  /// Calculates the number of padding bytes at the end of [uint8List].
  /// Verifies that all padding bytes are valid.
  /// Throws [InvalidLengthException] if the padding is corrupted, or [InvalidPaddingValueException] if it is inconsistent with PKCS7 format.
  @override
  int countPadding(Uint8List uint8List) {
    int count = BinaryUtils.maskTo8Bits(uint8List[uint8List.length - 1]);

    if (count > uint8List.length || count == 0) {
      throw InvalidLengthException('Invalid padding length, should be $count is ${uint8List.length}');
    }

    for (int i = 1; i <= count; i++) {
      if (uint8List[uint8List.length - i] != count) {
        throw InvalidPaddingValueException('Invalid padding value, should be: $count is ${uint8List[uint8List.length - i]}');
      }
    }
    return count;
  }
}
