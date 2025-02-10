// Class was shaped by the influence of several key sources including:
// "blockchain_utils" - Copyright (c) 2010 Mohsen
// https://github.com/mrtnetwork/blockchain_utils/.
//
// BSD 3-Clause License
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
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

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/hash/sha/hash/a_hash.dart';

/// The [PBKDF2] class utilizes the PBKDF2 (Password-Based Key Derivation Function 2) hashing algorithm
/// to generate secure cryptographic keys from passwords. It is frequently applied for hashing passwords
/// within databases and in blockchain technology for seed generation from mnemonics.
class PBKDF2 {
  final int iterations;
  final int outputLength;
  final AHash hash;

  PBKDF2({
    this.iterations = 2048,
    this.outputLength = 64,
    AHash? hash,
  }) : hash = hash ?? Sha512();

  /// Derives a cryptographic key from the provided password and salt using the PBKDF2 algorithm.
  Uint8List process(Uint8List password, Uint8List salt) {
    // Digest length (dlen)
    int dlen = hash.blockSize ~/ 2;

    // Intermediate results calculated during the HMAC operations
    List<int> t = List<int>.filled(dlen, 0);
    List<int> u = List<int>.filled(dlen, 0);
    List<int> ctr = List<int>.filled(4, 0);

    // Derived key (DK)
    List<int> dk = List<int>.filled(outputLength, 0);

    for (int i = 0; i * dlen < outputLength; i++) {
      _writeUint32BE(i + 1, ctr);
      HMAC prf = HMAC(hash: hash, key: password)
        ..update(salt)
        ..update(ctr);
      u = prf.digest;
      for (int j = 0; j < dlen; j++) {
        t[j] = u[j];
      }
      for (int j = 2; j <= iterations; j++) {
        HMAC innerHMAC = HMAC(hash: hash, key: password)..update(u);
        u = innerHMAC.digest;
        for (int k = 0; k < dlen; k++) {
          t[k] ^= u[k];
        }
      }

      for (int j = 0; j < dlen && i * dlen + j < outputLength; j++) {
        dk[i * dlen + j] = t[j];
      }
    }
    return Uint8List.fromList(dk);
  }

  /// Writes a 32-bit unsigned integer value in big-endian byte order to a list.
  void _writeUint32BE(int value, List<int> out, [int offset = 0]) {
    out[offset + 0] = (value >> 24) & 0xFF;
    out[offset + 1] = (value >> 16) & 0xFF;
    out[offset + 2] = (value >> 8) & 0xFF;
    out[offset + 3] = value & 0xFF;
  }
}
