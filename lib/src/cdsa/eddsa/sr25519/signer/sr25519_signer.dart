// Class was shaped by the influence of several key sources including:
// "blockchain_utils" Copyright (c) 2010 Mohsen
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

import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:cryptography_utils/src/utils/secure_random.dart';

class SR25519Signer {
  final SR25519PrivateKey privateKey;

  SR25519Signer({
    required this.privateKey,
  });

  /// Generates a non-deterministic signature for a given message using [SR25519PrivateKey].
  SRSignature sign(Uint8List message, {Uint8List? nonce}) {
    MerlinTranscript signingScript = MerlinTranscript('SigningContext')
      ..appendMessage('', utf8.encode('substrate'))
      ..appendMessage('sign-bytes', message)
      ..appendMessage('proto-name', utf8.encode('Schnorr-sig'))
      ..appendMessage('sign:pk', privateKey.publicKey.bytes);

    Uint8List nonceRand = nonce ?? SecureRandom.getBytes(length: 64, max: 255);
    Ristretto255Scalar nonceScalar = Ristretto255Scalar.fromUniformBytes(nonceRand);
    Ristretto255Point r = Ristretto255Point.fromEDPoint(CurvePoints.generatorED25519 * nonceScalar.scalar);
    signingScript.appendMessage('sign:R', r.toBytes());

    Uint8List k = signingScript.extractBytes('sign:c', 64);
    Ristretto255Scalar kScalar = Ristretto255Scalar.fromUniformBytes(k);

    Ristretto255Scalar prvScalar = Ristretto255Scalar.fromBytes(privateKey.bytes);
    Ristretto255Scalar km = prvScalar * kScalar;
    Ristretto255Scalar s = km + nonceScalar;
    SRSignature sig = SRSignature(r: r.toBytes(), s: s.toBytes());
    return sig;
  }

  /// Verifies an SRSignature signature against given message.
  bool verifySignature(Uint8List message, SRSignature signature) {
    MerlinTranscript verifyingScript = MerlinTranscript('SigningContext')
      ..appendMessage('', utf8.encode('substrate'))
      ..appendMessage('sign-bytes', message)
      ..appendMessage('proto-name', utf8.encode('Schnorr-sig'))
      ..appendMessage('sign:pk', privateKey.publicKey.bytes)
      ..appendMessage('sign:R', signature.r);

    Uint8List k = verifyingScript.extractBytes('sign:c', 64);
    Ristretto255Scalar kScalar = Ristretto255Scalar.fromUniformBytes(k);

    BigInt s = BigIntUtils.decode(signature.s, order: Endian.little);
    Ristretto255Point r = (-privateKey.publicKey.P * kScalar.scalar) + (CurvePoints.generatorED25519 * s);
    return const ListEquality<int>().equals(r.toBytes(), signature.r);
  }
}
