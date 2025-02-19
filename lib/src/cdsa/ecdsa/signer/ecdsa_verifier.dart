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
import 'package:cryptography_utils/src/utils/ec_point_utils.dart';

/// This class implements the functionality necessary to verify digital signatures using
/// the ECDSA (Elliptic Curve Digital Signature Algorithm). By using the public key associated with
/// the signature, this verifier can confirm whether the signature was indeed created by the holder
/// of the corresponding private key and that the data has not been altered since it was signed.
class ECDSAVerifier {
  /// The hash function used for generating the message digest.
  final AHash hashFunction;

  /// The ECDSA public key which will be used to verification.
  final ECPublicKey ecPublicKey;

  /// Constructs an [ECDSAVerifier] with the provided hash function and ECDSA public key.
  ECDSAVerifier({
    required this.hashFunction,
    required this.ecPublicKey,
  });

  /// Verifies an ECDSA signature against given message.
  bool isSignatureValid(Uint8List message, ECSignature signature) {
    BigInt n = ecPublicKey.G.n;
    BigInt e = BigIntUtils.decodeWithSign(1, message, bitLength: n.bitLength);

    BigInt r = signature.r;
    BigInt s = signature.s;

    if (_isValidSignatureRange(r, n) == false || _isValidSignatureRange(s, n) == false) {
      return false;
    }

    BigInt c = s.modInverse(n);

    BigInt u1 = (e * c) % n;
    BigInt u2 = (r * c) % n;

    ECPoint point = ECPointUtils.sumTwoMultiplies(ecPublicKey.G, u1, ecPublicKey.Q, u2);

    if (point.isInfinity) {
      return false;
    }

    BigInt v = point.affineX % n;

    return v == r;
  }

  /// Checks if the given value is in the range [0, n) which is required for processing ECDSA signature verification.
  bool _isValidSignatureRange(BigInt value, BigInt n) {
    return value.compareTo(BigInt.zero) >= 0 && value.compareTo(n) < 0;
  }
}
