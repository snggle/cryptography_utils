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
import 'package:cryptography_utils/src/encryption/cipher/stream_cipher/ctr_stream_cipher.dart';

/// A block cipher that adapts a stream cipher in Counter (CTR) mode.
/// This class wraps a [CTRStreamCipher], allowing it to be used in
/// contexts where a block cipher interface is expected.
/// Internally, it uses an AES block cipher configured with CTR mode, which turns
/// it into a stream cipher suitable for processing inputs of any size.
class CTRBlockCipher extends ABlockCipher {
  final CTRStreamCipher ctrStreamCipher;

  CTRBlockCipher(ABlockCipher blockCipher)
      : ctrStreamCipher = CTRStreamCipher(blockCipher),
        super(blockSize: blockCipher.blockSize, cipherMode: blockCipher.cipherMode, cipherKeyWithIV: blockCipher.cipherKeyWithIV);

  /// Processes a full [uint8List] input using the underlying stream cipher logic.
  /// Returns a new [Uint8List] with the encrypted or decrypted output.
  /// Input and output lengths are identical.
  @override
  Uint8List process(Uint8List uint8List) {
    Uint8List outputUint8List = Uint8List(uint8List.length);
    ctrStreamCipher.processBytes(uint8List, 0, uint8List.length, outputUint8List, 0);
    return outputUint8List;
  }

  /// Processes a single block of input data from [inputUint8List] starting at [inputOffset],
  /// and writes the result to [outputUint8List] starting at [outputOffset].
  /// This uses the underlying stream cipher's [processBytes] to perform XOR
  /// with the encrypted counter value. Returns the number of bytes written,
  /// always equal to [blockSize].
  @override
  int processBlock(Uint8List inputUint8List, int inputOffset, Uint8List outputUint8List, int outputOffset) {
    ctrStreamCipher.processBytes(inputUint8List, inputOffset, blockSize, outputUint8List, outputOffset);
    return blockSize;
  }
}
