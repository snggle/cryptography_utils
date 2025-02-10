// Class was shaped by the influence of several key sources including:
// "pointycastle" - Copyright (c) 2000 - 2019 The Legion of the Bouncy Castle Inc. (https://www.bouncycastle.org)
// https://github.com/bcgit/pc-dart
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

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/hash/sha/hash/a_hash.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';

/// This class implements the functionality necessary to generate and verify digital signatures using
/// the ECDSA algorithm, a cryptographic algorithm used for creating a digital signature of data
/// which can then be verified by others with the signer's public key.
class ECDSASigner {
  /// The hash function used for generating the message digest.
  final AHash hashFunction;

  /// The ECDSA private key used for signing the message.
  final ECPrivateKey ecPrivateKey;

  ECDSASigner({
    required this.hashFunction,
    required this.ecPrivateKey,
  });

  /// Generates a deterministic signature for a given message using [ECPrivateKey].
  /// Uses RFC6979 for 'k' ephemeral key generation to mitigate certain vulnerabilities associated with random 'k' generation.
  ECSignature sign(Uint8List message) {
    BigInt n = ecPrivateKey.G.n;
    BigInt e = BigIntUtils.decodeWithSign(1, message, bitLength: n.bitLength);
    BigInt r;
    BigInt s;

    RFC6979 rfc6979 = RFC6979(n: ecPrivateKey.G.n, hashFunction: hashFunction, d: ecPrivateKey.d, m: message);

    do {
      BigInt? k;
      do {
        k = rfc6979.generateNextK();
        ECPoint p = ecPrivateKey.G * k;
        r = p.affineX % n;
      } while (r == BigInt.zero);
      s = (k.modInverse(n) * (e + (ecPrivateKey.d * r) % n)) % n;
    } while (s == BigInt.zero);

    return ECSignature(r: r, s: s, ecCurve: ecPrivateKey.G.curve);
  }
}
