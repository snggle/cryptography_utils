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
import 'package:cryptography_utils/src/encryption/cipher/cipher_param_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/i_cipher_param.dart';
import 'package:cryptography_utils/src/encryption/cipher/stream_cipher/a_stream_cipher.dart';
import 'package:cryptography_utils/src/utils/binary_utils.dart';

class CTRStreamCipher extends AStreamCipher {
  final ABlockCipher blockCipher;

  late int _consumed;
  late Uint8List _counterUint8List;
  late Uint8List _counterOutUint8List;

  /// Initializes buffers based on AES block size.
  CTRStreamCipher(this.blockCipher) {
    CipherParamWithIV<ICipherParam> cipherParameter = blockCipher.cipherParameter as CipherParamWithIV<ICipherParam>;
    _counterUint8List = Uint8List.fromList(cipherParameter.ivUint8List);
    _counterOutUint8List = Uint8List(blockCipher.blockSize);
    _consumed = _counterOutUint8List.length;
  }

  /// Processes a slice of input and outputs the XOR'd result to [outputUint8List].
  void processBytes(Uint8List inputUint8List, int inputOffset, Uint8List outputUint8List, int outOffset) {
    for (int i = 0; i < inputUint8List.length; i++) {
      outputUint8List[outOffset + i] = _returnByte(inputUint8List[inputOffset + i]);
    }
  }

  /// XORs a single byte with a byte from the encrypted counter.
  /// Automatically re-feeds the counter when exhausted.
  int _returnByte(int input) {
    if (_consumed >= _counterOutUint8List.length) {
      blockCipher.processBlock(_counterUint8List, 0, _counterOutUint8List, 0);
      _incrementCounter();
      _consumed = 0;
    }
    return BinaryUtils.maskTo8Bits(input) ^ _counterOutUint8List[_consumed++];
  }

  /// Increments the counter value (big endian-style).
  void _incrementCounter() {
    for (int i = _counterUint8List.length - 1; i >= 0; i--) {
      _counterUint8List[i]++;
      if (_counterUint8List[i] != 0) {
        break;
      }
    }
  }
}

