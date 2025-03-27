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

import 'package:cryptography_utils/src/encryption/cipher/block_cipher/a_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/invalid_length_exception.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/padding/i_cipher_padding.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';

/// A block cipher wrapper that applies padding to input data when its length
/// is not a multiple of the cipher's block size.
///
/// Padding adds extra bytes to the final block to ensure proper alignment with the block cipher.
/// Beyond alignment, padding also helps with length disambiguation,
/// message integrity validation, and resistance to certain cryptographic attacks.
///
/// This class delegates core encryption and decryption operations
/// to an underlying [ABlockCipher] instance, and applies padding and unpadding.
class PaddedBlockCipher extends ABlockCipher {
  final ABlockCipher _blockCipher;
  final ICipherPadding _cipherPadding;

  PaddedBlockCipher({required ABlockCipher blockCipher, required ICipherPadding cipherPadding})
      : _blockCipher = blockCipher,
        _cipherPadding = cipherPadding,
        super(blockSize: blockCipher.blockSize, cipherKeyWithIV: blockCipher.cipherKeyWithIV, cipherMode: blockCipher.cipherMode);

  /// Processes an [uint8List] of input data with padding and returns the output.
  /// Applies padding for encryption.
  /// For decryption, input must be a multiple of block size and valid padding must exist.
  @override
  Uint8List process(Uint8List uint8List) {
    int inputBlocksCount = (uint8List.length + blockSize - 1) ~/ blockSize;
    int outputBlocksCount;

    if (cipherMode == CipherMode.encryption) {
      outputBlocksCount = (uint8List.length + blockSize) ~/ blockSize;
    } else {
      if ((uint8List.length % blockSize) != 0) {
        throw InvalidLengthException("Input data length must be a multiple of cipher's block size - $blockSize is ${uint8List.length}");
      }
      outputBlocksCount = inputBlocksCount;
    }

    Uint8List outputUint8List = Uint8List(outputBlocksCount * blockSize);
    for (int i = 0; i < (inputBlocksCount - 1); i++) {
      int offset = i * blockSize;
      processBlock(uint8List, offset, outputUint8List, offset);
    }
    int lastBlockOffset = (inputBlocksCount - 1) * blockSize;
    int lastBlockSize = _doFinal(uint8List, lastBlockOffset, outputUint8List, lastBlockOffset);

    return outputUint8List.sublist(0, lastBlockOffset + lastBlockSize);
  }

  /// Processes a single block of data from [inputUint8List] at [inputOffset],
  /// writing the result to [outputUint8List] at [outputOffset].
  /// This delegates to the underlying [blockCipher]'s [processBlock] method.
  /// Returns the number of bytes written, which equals [blockSize].
  @override
  int processBlock(Uint8List inputUint8List, int inputOffset, Uint8List outputUint8List, int outputOffset) {
    return _blockCipher.processBlock(inputUint8List, inputOffset, outputUint8List, outputOffset);
  }

  /// Finishes encryption/decryption and returns the number of bytes written.
  /// For encryption, handles final block padding and possible extra block.
  /// For decryption, strips padding and validates its correctness.
  int _doFinal(Uint8List inputUint8List, int inputOffset, Uint8List outputUint8List, int outputOffset) {
    if (cipherMode == CipherMode.encryption) {
      Uint8List lastInputBlockUint8List = Uint8List(blockSize)..setAll(0, inputUint8List.sublist(inputOffset));
      int remainder = inputUint8List.length - inputOffset;
      if (remainder < blockSize) {
        _cipherPadding.addPadding(lastInputBlockUint8List, inputUint8List.length - inputOffset);
        processBlock(lastInputBlockUint8List, 0, outputUint8List, outputOffset);

        return blockSize;
      } else {
        processBlock(inputUint8List, inputOffset, outputUint8List, outputOffset);
        _cipherPadding.addPadding(lastInputBlockUint8List, 0);
        processBlock(lastInputBlockUint8List, 0, outputUint8List, outputOffset + blockSize);

        return 2 * blockSize;
      }
    } else {
      processBlock(inputUint8List, inputOffset, outputUint8List, outputOffset);
      int paddedCount = _cipherPadding.countPadding(outputUint8List.sublist(outputOffset));
      int paddedOffsetInBlock = blockSize - paddedCount;
      outputUint8List.fillRange(outputOffset + paddedOffsetInBlock, outputUint8List.length, 0);

      return paddedOffsetInBlock;
    }
  }
}
