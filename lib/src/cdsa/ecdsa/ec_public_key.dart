import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

class ECPublicKey extends Equatable {
  /// Predefined point on the elliptic curve that serves as a starting point
  /// for generating public keys and performing cryptographic operations.
  final ECPoint G;

  /// Represents the public key derived from the private key through the elliptic curve point multiplication
  /// operation Q = dG, where `d`is the secret exponent (private key) and `G` is the generator point of the curve.
  final ECPoint Q;

  const ECPublicKey(this.G, this.Q);

  factory ECPublicKey.fromCompressedBytes(List<int> bytes, ECPoint G) {
    ECPoint Q = ECPoint.fromCompressedBytes(bytes, G);
    return ECPublicKey(G, Q);
  }

  factory ECPublicKey.fromUncompressedBytes(List<int> bytes, ECPoint G) {
    ECPoint Q = ECPoint.fromUncompressedBytes(bytes.sublist(1), G);
    return ECPublicKey(G, Q);
  }

  Uint8List get compressed {
    return Q.toBytes(compressedBool: true);
  }

  Uint8List get uncompressed {
    return Q.toBytes(compressedBool: false);
  }

  @override
  List<Object?> get props => <Object>[G, Q];
}
