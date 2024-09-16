// Class was shaped by the influence of several key sources including:
// "blockchain_utils" - Copyright (c) 2010 Mohsen
// https://github.com/mrtnetwork/blockchain_utils/.
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
import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:cryptography_utils/src/utils/curve_utils.dart';

/// Class representing a digital signature in the ECDSA algorithm
class ECSignature extends ASignature {
  /// Part of the signature that corresponds to the x-coordinate of the ephemeral public key,
  /// serving as a representation of the signature on the elliptic curve. Typically denoted as 'r'.
  final BigInt r;

  /// Part of the signature representing the scalar component, typically denoted as 's'.
  /// Derived from the signer's private key and the hash of the message, this component serves as the proof of
  /// the signature's authenticity and the signer's agreement with the message content.
  final BigInt s;

  /// The elliptic curve that the signature point is on.
  final ECCurve ecCurve;

  /// Constructs an instance of ECSignature with the specified 'r' and 's' components.
  const ECSignature({
    required this.r,
    required this.s,
    required this.ecCurve,
  });

  /// Constructs an instance of ECSignature from a base64 string.
  factory ECSignature.fromBase64(String base64, {required ECCurve ecCurve}) {
    Uint8List bytes = base64Decode(base64);
    return ECSignature.fromBytes(bytes, ecCurve: ecCurve);
  }

  /// Constructs an instance of ECSignature from a byte array.
  factory ECSignature.fromBytes(Uint8List bytes, {required ECCurve ecCurve}) {
    int halfLength = bytes.length ~/ 2;
    Uint8List rBytes = bytes.sublist(0, halfLength);
    Uint8List sBytes = bytes.sublist(halfLength);

    BigInt r = BigIntUtils.decodeWithSign(1, rBytes);
    BigInt s = BigIntUtils.decodeWithSign(1, sBytes);

    return ECSignature(r: r, s: s, ecCurve: ecCurve);
  }

  /// Returns the signature as a byte array.
  @override
  Uint8List get bytes {
    List<int> rBytes = BigIntUtils.changeToBytes(r, length: ecCurve.baselen);
    List<int> sBytes = BigIntUtils.changeToBytes(s, length: ecCurve.baselen);

    return Uint8List.fromList(rBytes + sBytes);
  }

  /// Recovers potential public keys that could have been used to generate the ECDSA signature
  /// for a given message. This method utilizes the elliptic curve's generator point to derive
  /// possible keys.
  List<ECPublicKey> recoverPublicKeys(List<int> message, ECPoint generator) {
    ECCurve curve = generator.curve;
    BigInt order = generator.n;
    BigInt e = BigIntUtils.decode(message);
    BigInt alpha = (r.modPow(BigInt.from(3), curve.p) + curve.a * r + curve.b) % curve.p;
    BigInt beta = CurveUtils.findModularSquareRoot(a: alpha, p: curve.p);
    BigInt y = (beta % BigInt.two == BigInt.zero) ? beta : (curve.p - beta);

    ECPoint r1 = ECPoint(curve: curve, x: r, y: y, z: BigInt.one, n: order);
    BigInt inverseR = r.modInverse(order);
    ECPoint q1 = ((r1 * s) + (generator * (-e % order))) * inverseR;
    ECPublicKey pk1 = ECPublicKey(generator, q1);

    ECPoint r2 = ECPoint(curve: curve, x: r, y: -y, z: BigInt.one, n: order);
    ECPoint q2 = ((r2 * s) + (generator * (-e % order))) * inverseR;
    ECPublicKey pk2 = ECPublicKey(generator, q2);

    return <ECPublicKey>[pk1, pk2];
  }

  @override
  List<Object?> get props => <Object>[r, s];
}
