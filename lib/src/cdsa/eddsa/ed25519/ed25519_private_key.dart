import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [ED25519PrivateKey] represents [EDPrivateKey] constructed with specific Curve (ED25519) and chain code.
class ED25519PrivateKey extends ABip32PrivateKey {
  /// EdDSA Private key used for cryptographic operations, following the Ed25519 curve specification.
  final EDPrivateKey edPrivateKey;

  const ED25519PrivateKey({
    required super.metadata,
    required this.edPrivateKey,
  });

  /// Returns the private key as a byte array.
  @override
  Uint8List get bytes {
    return Uint8List.fromList(edPrivateKey.bytes);
  }

  /// Returns the length of the private key.
  @override
  int get length => 32;

  /// Returns the public key derived from the private key.
  @override
  ED25519PublicKey get publicKey {
    return ED25519PublicKey(
      edPublicKey: edPrivateKey.edPublicKey,
      metadata: metadata,
    );
  }

  @override
  List<Object?> get props => <Object>[edPrivateKey, metadata];
}