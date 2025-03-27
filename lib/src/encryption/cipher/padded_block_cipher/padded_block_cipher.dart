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

import 'package:cryptography_utils/src/encryption/cipher/a_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';
import 'package:cryptography_utils/src/encryption/cipher/i_cipher_param.dart';
import 'package:cryptography_utils/src/encryption/cipher/padded_block_cipher/padded_block_cipher_parameters.dart';
import 'package:cryptography_utils/src/encryption/cipher/padded_block_cipher/pkcs7_padding.dart';

/// A cipher implementation that applies PKCS7 padding to a block cipher.
/// This class wraps a [ABlockCipher] and handles both encryption and decryption
/// of data with padding when the input size is not a multiple of the block size.
class PaddedBlockCipher {
  final ABlockCipher blockCipher;
  final int _blockSize;

  CipherMode? _cipherMode;

  PaddedBlockCipher(this.blockCipher) : _blockSize = blockCipher.blockSize;

  void init({required CipherMode cipherMode, required ICipherParam? cipherParameter}) {
    PaddedBlockCipherParameter<ICipherParam?, ICipherParam?> paddedParameter =
        cipherParameter as PaddedBlockCipherParameter<ICipherParam?, ICipherParam?>;
    _cipherMode = cipherMode;
    blockCipher.init(paddedParameter.cipherParam);
  }

  /// Processes a [uint8list] of input data with padding and returns the output.
  /// Applies PKCS7 padding for encryption. For decryption, input must be a
  /// multiple of block size and valid padding must exist.
  Uint8List process(Uint8List uint8list) {
    int input = (uint8list.length + _blockSize - 1) ~/ _blockSize;
    int output;

    if (_cipherMode == CipherMode.encryption) {
      output = (uint8list.length + _blockSize) ~/ _blockSize;
    } else {
      if ((uint8list.length % _blockSize) != 0) {
        throw ArgumentError("Input data length must be a multiple of cipher's block size");
      }
      output = input;
    }

    Uint8List outputUint8List = Uint8List(output * _blockSize);
    for (int i = 0; i < (input - 1); i++) {
      int offset = i * _blockSize;
      _processBlock(uint8list, offset, outputUint8List, offset);
    }
    int lastBlockOffset = (input - 1) * _blockSize;
    int lastBlockSize = _doFinal(uint8list, lastBlockOffset, outputUint8List, lastBlockOffset);

    return outputUint8List.sublist(0, lastBlockOffset + lastBlockSize);
  }

  /// Finishes encryption/decryption and returns the number of bytes written.
  /// For encryption, handles final block padding and possible extra block.
  /// For decryption, strips padding and validates its correctness.
  int _doFinal(Uint8List inputUint8List, int inputOffset, Uint8List outputUint8List, int outputOffset) {
    if (_cipherMode == CipherMode.encryption) {
      Uint8List lastInputBlockUint8List = Uint8List(_blockSize)..setAll(0, inputUint8List.sublist(inputOffset));
      Pkcs7Padding().addPadding(lastInputBlockUint8List, inputUint8List.length - inputOffset);
      _processBlock(lastInputBlockUint8List, 0, outputUint8List, outputOffset);

      return _blockSize;
    } else {
      _processBlock(inputUint8List, inputOffset, outputUint8List, outputOffset);
      int paddedCount = Pkcs7Padding().paddingCount(outputUint8List.sublist(outputOffset));
      int paddedOffsetInBlock = _blockSize - paddedCount;
      outputUint8List.fillRange(outputOffset + paddedOffsetInBlock, outputUint8List.length, 0);

      return paddedOffsetInBlock;
    }
  }

  int _processBlock(Uint8List inputUint8List, int inputOffset, Uint8List outputUint8List, int outputOffset) {
    return blockCipher.processBlock(inputUint8List, inputOffset, outputUint8List, outputOffset);
  }
}
