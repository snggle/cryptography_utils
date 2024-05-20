import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [Secp256k1PrivateKey] represents [ECPrivateKey] constructed with specific Curve (secp256k1) and chain code.
class Secp256k1PrivateKey extends ABip32PrivateKey {
  /// ECDSA Private key used for cryptographic operations, following the secp256k1 curve specification.
  final ECPrivateKey ecPrivateKey;

  const Secp256k1PrivateKey({
    required super.metadata,
    required this.ecPrivateKey,
  });

  /// Returns the private key as a byte array.
  @override
  Uint8List get bytes => ecPrivateKey.bytes;

  /// Returns the length of the private key.
  @override
  int get length => ECPrivateKey.length;

  /// Returns the public key derived from the private key.
  @override
  Secp256k1PublicKey get publicKey {
    return Secp256k1PublicKey(
      ecPublicKey: ecPrivateKey.ecPublicKey,
      metadata: metadata,
    );
  }

  @override
  List<Object?> get props => <Object>[ecPrivateKey, metadata];
}
