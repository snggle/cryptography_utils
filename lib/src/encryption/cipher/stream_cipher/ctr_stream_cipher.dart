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
import 'package:cryptography_utils/src/encryption/cipher/cipher_key_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/i_cipher_key.dart';
import 'package:cryptography_utils/src/utils/binary_utils.dart';

/// A stream cipher implementation using Counter (CTR).
/// This class wraps a block cipher, and turns it into a stream cipher
/// by generating a keystream using encrypted counter values, which are XOR'd with the plaintext.
/// Each counter block is incremented for every processed block of data.
class CTRStreamCipher {
  final ABlockCipher blockCipher;
  late Uint8List _counterUint8List;
  late Uint8List _counterOutUint8List;
  late int _consumed;

  /// Constructs a [CTRStreamCipher] with the given [blockCipher].
  /// The cipher parameter must include an IV. Initializes internal state and prepares buffers.
  CTRStreamCipher(this.blockCipher) {
    CipherKeyWithIV<ICipherKey> cipherKeyWithIV = blockCipher.cipherKeyWithIV;
    _counterUint8List = Uint8List.fromList(cipherKeyWithIV.ivUint8List);
    _counterOutUint8List = Uint8List(blockCipher.blockSize);
    _consumed = _counterOutUint8List.length;
  }

  /// Encrypts or decrypts [length] bytes from [inputUint8List] starting at [inputOffset],
  /// and writes the result to [outputUint8List] starting at [outOffset].
  /// Internally uses the encrypted counter for XOR.
  void processBytes(Uint8List inputUint8List, int inputOffset, int length, Uint8List outputUint8List, int outOffset) {
    for (int i = 0; i < length; i++) {
      outputUint8List[outOffset + i] = _returnByte(inputUint8List[inputOffset + i]);
    }
  }

  /// XORs a single byte with a byte from the encrypted counter.
  /// When all bytes of the current counter are consumed, it encrypts the next counter block.
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
