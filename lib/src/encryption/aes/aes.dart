//Copyright (c) 2018, Leo Cavalcante
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
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
import 'package:cryptography_utils/src/encryption/cipher/a_key_parameter.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';
import 'package:cryptography_utils/src/encryption/cipher/i_cipher_param.dart';
import 'package:cryptography_utils/src/encryption/cipher/padded_block_cipher/padded_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/padded_block_cipher/padded_block_cipher_parameters.dart';
import 'package:cryptography_utils/src/encryption/cipher/param_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/stream_cipher/sic_stream_cipher_as_block_cipher.dart';

/// AES provides encryption and decryption using the AES algorithm in stream cipher mode (SIC/CTR).
/// This implementation wraps the AES engine with a counter-based stream cipher and
/// uses PKCS7 padding to support data of arbitrary length.
class AES {
  /// Encrypts the given [uint8list] using the specified [aesKey] and [aesIV].
  /// The encryption process uses a padded block cipher with PKCS7 padding
  /// and AES in SIC mode to ensure compatibility with arbitrary-length inputs.
  /// Returns an [Encrypted] object containing the encrypted bytes.
  static Encrypted encryptBytes(Uint8List uint8list, AesKey aesKey, AesIV aesIV) {
    PaddedBlockCipher paddedCipher = PaddedBlockCipher(SicStreamAsBlockCipher(AesEngine()))
      ..init(
          cipherMode: CipherMode.encryption,
          cipherParameter:
              PaddedBlockCipherParameter<ParamWithIV<AKeyParameter>, ICipherParam?>(ParamWithIV<AKeyParameter>(aesKey, aesIV.keyUint8List)));
    Uint8List encrypted = paddedCipher.process(uint8list);
    return Encrypted(encrypted);
  }

  /// Decrypts the given [encrypted] data using the specified [aesKey] and [aesIV].
  /// The decryption process matches the encryption configuration,
  /// using PKCS7 padding removal and AES in SIC mode.
  /// Returns the original plaintext as a [Uint8List].
  static Uint8List decryptBytes(Encrypted encrypted, AesKey aesKey, AesIV aesIV) {
    PaddedBlockCipher paddedCipher = PaddedBlockCipher(SicStreamAsBlockCipher(AesEngine()))
      ..init(
          cipherMode: CipherMode.decryption,
          cipherParameter:
              PaddedBlockCipherParameter<ParamWithIV<AKeyParameter>, ICipherParam?>(ParamWithIV<AKeyParameter>(aesKey, aesIV.keyUint8List)));
    Uint8List decryptUint8List = paddedCipher.process(encrypted.uint8List);
    return decryptUint8List;
  }
}
