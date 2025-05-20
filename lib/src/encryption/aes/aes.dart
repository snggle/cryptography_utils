//Copyright (c) 2018, Leo Cavalcante
// All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// * Neither the name of the copyright holder nor the names of its
//   contributors may be used to endorse or promote products derived from
//   this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes_engine.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_iv.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/aes/encrypted.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/ctr_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/padded_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/padding/pkcs7_padding.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_param_with_iv.dart';

enum AESMode { ecb, cbc, cfb, ofb, ctr }

abstract interface class ICipherPadding {
  int addPadding(Uint8List uint8list, int offset);

  int calcPaddingCount(Uint8List uint8list);
}

class AES {
  final AESMode mode;
  final ICipherPadding? padding;

  AES([
    this.mode = AESMode.ctr,
    this.padding = const Pkcs7Padding(),
  ]);

  Encrypted encrypt(Uint8List uint8list, AesKey aesKey, AesIV aesIV) {
    if (mode == AESMode.ctr && padding != null) {
      PaddedBlockCipher paddedBlockCipher = PaddedBlockCipher(
        padding: padding!,
        blockCipher: CTRBlockCipher(AesEngine(
          cipherMode: CipherMode.encryption,
          cipherParameter: CipherParamWithIV<AesKey>(aesKey, aesIV.uint8List),
        )),
      );

      Uint8List encrypted = paddedBlockCipher.process(uint8list);
      return Encrypted(encrypted);
    } else if (padding == null) {
      throw UnimplementedError('Unpadded cipher is not implemented yet.');
    } else {
      throw UnimplementedError('The $mode is not implemented yet. Only CTR is implemented.');
    }
  }

  Uint8List decrypt(Encrypted encrypted, AesKey aesKey, AesIV aesIV) {
    if (mode == AESMode.ctr && padding != null) {
      PaddedBlockCipher paddedBlockCipher = PaddedBlockCipher(
        padding: padding!,
        blockCipher: CTRBlockCipher(AesEngine(
          cipherMode: CipherMode.decryption,
          cipherParameter: CipherParamWithIV<AesKey>(aesKey, aesIV.uint8List),
        )),
      );

      return paddedBlockCipher.process(encrypted.uint8List);
    } else if (padding == null) {
      throw UnimplementedError('Unpadded cipher is not implemented yet.');
    } else {
      throw UnimplementedError('$mode is not implemented yet. Only CTR is implemented.');
    }
  }
}
