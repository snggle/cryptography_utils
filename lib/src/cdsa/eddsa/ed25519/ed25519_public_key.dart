import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [ED25519PublicKey] represents [EDPublicKey] constructed with specific Curve (ED25519) and chain code.
class ED25519PublicKey extends ABip32PublicKey {
  /// EdDSA public key derived from the corresponding private key, following the Ed25519 curve specification.
  /// This public key is used in the verification process of digital signatures, allowing others to verify the authenticity
  /// of transactions or messages signed with the associated private key, without compromising the private key itself.
  final EDPublicKey edPublicKey;

  const ED25519PublicKey({
    required super.metadata,
    required this.edPublicKey,
  });

  /// Returns the compressed form of the public key.
  @override
  Uint8List get compressed => bytes;

  /// Returns the uncompressed form of the public key.
  @override
  Uint8List get uncompressed => bytes;

  /// Returns the public key as bytes.
  Uint8List get bytes => edPublicKey.bytes;

  /// Returns the length of the public key.
  int get length => edPublicKey.length;

  @override
  List<Object?> get props => <Object?>[edPublicKey];
}
