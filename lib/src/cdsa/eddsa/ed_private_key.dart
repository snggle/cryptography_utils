import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:equatable/equatable.dart';

/// Represents an EdDSA private key and provides methods for key operations.
class EDPrivateKey extends Equatable {
  /// Predefined point on the Edwards curve that serves as a starting point
  /// for generating public keys and performing cryptographic operations.
  static EDPoint G = CurvePoints.generatorED25519;

  /// Represents the private key in EdDSA, essential for signing messages and deriving the public key.
  final Uint8List _privateKey;

  const EDPrivateKey.fromBytes(this._privateKey);

  /// Returns the private key as bytes.
  Uint8List get bytes => _privateKey;

  /// Returns the public key derived from the private key.
  EDPublicKey get edPublicKey {
    EDPublicKey edPublicKey = EDPublicKey(G * a);
    return edPublicKey;
  }

  /// Returns the pruned private key as a BigInt.
  BigInt get a {
    Uint8List h = Sha512().convert(_privateKey).byteList;
    Uint8List a = h.sublist(0, _baseLength);
    Uint8List sBytes = _prunePrivateKey(a);
    return BigIntUtils.decode(sBytes, order: Endian.little);
  }

  /// Returns the length of the private key in bytes.
  int get _baseLength => (G.curve.p.bitLength + 8) ~/ 8;

  /// Prunes the key to achieve improved security.
  Uint8List _prunePrivateKey(Uint8List privateKey) {
    BigInt h = G.curve.h;
    int hLog;
    if (h == BigInt.from(4)) {
      hLog = 2;
    } else if (h == BigInt.from(8)) {
      hLog = 3;
    } else {
      throw ArgumentError('Only cofactor 4 and 8 curves are supported');
    }
    privateKey[0] &= ~((1 << hLog) - 1);

    int l = G.curve.p.bitLength;
    if (l % 8 == 0) {
      privateKey[privateKey.length - 1] = 0;
      privateKey[privateKey.length - 2] |= 0x80;
    } else {
      privateKey[privateKey.length - 1] = privateKey[privateKey.length - 1] & ((1 << (l % 8)) - 1) | (1 << (l % 8) - 1);
    }
    return privateKey;
  }

  @override
  List<Object?> get props => <Object?>[_privateKey];
}
