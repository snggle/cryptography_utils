import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:equatable/equatable.dart';

class ECPrivateKey extends Equatable {
  static int length = 32;

  /// Predefined point on the elliptic curve that serves as a starting point
  /// for generating public keys and performing cryptographic operations.
  final ECPoint G;

  /// Represents the secret exponent (private key) in ECDSA, crucial for signing messages and generating the
  /// public key (Q) through the operation Q = dG, where G is the curve's base point and d is this secret exponent.
  /// Chosen from the range [1, n-1], where n is the order of G's subgroup.
  final BigInt d;

  const ECPrivateKey(this.G, this.d);

  factory ECPrivateKey.fromBytes(List<int> bytes, ECPoint G) {
    if (bytes.length != G.curve.baselen) {
      throw const FormatException('Invalid length of private key');
    }

    BigInt d = BigIntUtils.decode(bytes);
    return ECPrivateKey(G, d);
  }

  Uint8List get bytes {
    return BigIntUtils.changeToBytes(d, length: G.curve.baselen);
  }

  ECPublicKey get ecPublicKey {
    ECPublicKey ecPublicKey = ECPublicKey(G, G * d);
    return ecPublicKey;
  }

  @override
  List<Object?> get props => <Object>[G, d];
}
