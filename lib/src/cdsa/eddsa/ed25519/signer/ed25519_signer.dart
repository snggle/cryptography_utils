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
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';
import 'package:cryptography_utils/src/hash/sha/hash/a_hash.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';

/// This class implements the functionality necessary to generate digital signatures using the EdDSA algorithm.
class ED25519Signer {
  /// The hash function used for generating the message digest.
  final AHash hashFunction;

  /// The EdDSA private key used for signing the message.
  final ED25519PrivateKey privateKey;

  ED25519Signer({
    required this.hashFunction,
    required this.privateKey,
  });

  /// Generates a deterministic signature for a given message using [ED25519PrivateKey].
  EDSignature sign(Uint8List message) {
    Uint8List publicKey = privateKey.publicKey.bytes;
    Uint8List h = hashFunction.convert(privateKey.bytes).byteList;
    Uint8List prefix = h.sublist(privateKey.length);

    BigInt r = BigIntUtils.decode(hashFunction.convert(<int>[...prefix, ...message]).byteList, order: Endian.little);
    Uint8List R = (CurvePoints.generatorED25519 * r).toBytes();

    BigInt k = BigIntUtils.decode(hashFunction.convert(<int>[...R, ...publicKey, ...message]).byteList, order: Endian.little);
    k %= CurvePoints.generatorED25519.n;

    BigInt s = (r + k * privateKey.edPrivateKey.a) % CurvePoints.generatorED25519.n;
    return EDSignature(
      r: R,
      s: BigIntUtils.changeToBytes(s, length: privateKey.length, order: Endian.little),
    );
  }

  /// Verifies an ED25519 signature against given message.
  bool verifySignature(Uint8List message, EDSignature edSignature) {
    ED25519PublicKey publicKey = privateKey.publicKey;
    EDPoint R = EDPoint.fromBytes(CurvePoints.generatorED25519, edSignature.r);
    BigInt S = BigIntUtils.decode(edSignature.s, order: Endian.little);
    if (S >= CurvePoints.generatorED25519.n) {
      throw Exception('Invalid signature');
    }

    List<int> digest = hashFunction.convert(<int>[...R.toBytes(), ...publicKey.bytes, ...message]).byteList;
    BigInt k = BigIntUtils.decode(digest, order: Endian.little);
    EDPoint gs = (CurvePoints.generatorED25519 * S).scaleToAffineCoordinates();
    EDPoint rka = (publicKey.edPublicKey.A * k + R).scaleToAffineCoordinates();
    if (gs != rka) {
      return false;
    }
    return true;
  }
}
