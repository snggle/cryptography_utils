import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [SR25519PublicKey] represents [EDPublicKey] constructed with specific Curve (SR25519) and chain code.
class SR25519PublicKey extends ABip32PublicKey {
  final Ristretto255Point P;

  const SR25519PublicKey({
    required super.metadata,
    required this.P,
  });

  /// Returns the compressed form of the public key.
  @override
  Uint8List get compressed => bytes;

  /// Returns the uncompressed form of the public key.
  @override
  Uint8List get uncompressed => bytes;

  /// Returns the length of the public key.
  Uint8List get bytes {
    return P.toBytes();
  }

  @override
  List<Object?> get props => <Object?>[P];
}
