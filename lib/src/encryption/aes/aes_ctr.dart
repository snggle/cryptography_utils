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
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/ctr_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/padded_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/block_cipher/padding/pkcs7_padding.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_key_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_text.dart';

/// AES provides encryption and decryption using the AES algorithm in stream cipher mode (SIC/CTR).
/// This implementation wraps the AES engine with a counter-based stream cipher and
/// uses PKCS7 padding to support data of arbitrary length.
///
/// ****************** implemented modes ******************
///
/// CTR (Counter mode) – transforms a block cipher into a stream cipher.
/// It generates a stream block by encrypting a nonce combined with a counter,
/// then XORs the stream with the plaintext. CTR mode allows parallel encryption,
/// random read/write access, and avoids block dependencies, making it suitable for
/// high-performance applications, secure disk encryption, and network protocols.
///
/// ****************** NOT implemented modes ******************
///
/// - ECB (Electronic Codebook) – the simplest block cipher mode, where each plaintext block is encrypted independently.
/// It is generally **not recommended for practical use** due to security weaknesses, but can be useful for educational or testing purposes.
///
/// - CBC (Cipher Block Chaining) - block cipher mode where each plaintext block is XORed with the previous ciphertext block
/// before encryption. Suitable for encrypting files, messages, or large datasets,
/// providing confidentiality by introducing dependency between blocks.
///
/// - OFB (Output feedback)- operates as a stream cipher by generating keystream blocks independent of the plaintext,
/// which are then XORed with the plaintext blocks. Well-suited for network communications and streaming applications.
///
/// - CFB (Cipher feedback ) - also a stream cipher mode that encrypts small increments of plaintext,
/// allowing for encryption of data in units smaller than the block size. An error in one ciphertext byte propagates
/// to several subsequent plaintext bytes during decryption. Generally less efficient compared to other modes.
///
/// - XTS (XEX-based Tweaked Codebook mode with ciphertext Stealing) - block cipher mode for encrypting data on storage devices.
/// It allows encryption of data whose length is not a multiple of the block size **without padding** by using ciphertext stealing.
/// Provides high performance and protection against ciphertext manipulation,
/// commonly used for encrypting sectors on hard drives, SSDs, and USB drives.

// TODO(Balldyna): To support multiple AES modes in the future, this class should be refactored.
// Consider the following steps:
// - introduce an enum (`AesMode`) to represent supported block cipher modes
// - add appropriate try-catch blocks for mode-specific behavior
// - rename this class to reflect its extended capability (e.g., 'AES').

class AESctr {
  /// Encrypts the given [uint8List] using the specified [aesKey] and [aesIV].
  /// The encryption process uses a padded block cipher with PKCS7 padding
  /// and AES in CTR mode to ensure compatibility with inputs of any size.
  /// Returns an [CipherText] object containing the encrypted bytes.
  static CipherText encrypt(Uint8List uint8List, AESKey aesKey, AESIV aesIV) {
    PaddedBlockCipher paddedBlockCipher = PaddedBlockCipher(
      blockCipher: CTRBlockCipher(
        AESEngine(
          cipherMode: CipherMode.encryption,
          cipherKeyWithIV: CipherKeyWithIV<AESKey>(aesKey, aesIV.uint8List),
        ),
      ),
      cipherPadding: Pkcs7Padding(),
    );
    return CipherText(paddedBlockCipher.process(uint8List));
  }

  /// Decrypts the given [cipherText] data using the specified [aesKey] and [aesIV].
  /// The decryption process matches the encryption configuration,
  /// using PKCS7 padding removal and AES in CTR mode.
  /// Returns the original plaintext as a [Uint8List].
  static Uint8List decrypt(CipherText cipherText, AESKey aesKey, AESIV aesIV) {
    PaddedBlockCipher paddedBlockCipher = PaddedBlockCipher(
      blockCipher: CTRBlockCipher(
        AESEngine(
          cipherMode: CipherMode.decryption,
          cipherKeyWithIV: CipherKeyWithIV<AESKey>(aesKey, aesIV.uint8List),
        ),
      ),
      cipherPadding: Pkcs7Padding(),
    );
    return paddedBlockCipher.process(cipherText.uint8List);
  }
}
