import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed25519_signer.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';

/// Provides functionality for creating Solana-compatible digital signatures using an ED25519 private key.
class SolanaSigner {
  /// The ED25519 private key used for signing messages.
  final ED25519PrivateKey _ed25519PrivateKey;

  /// Constructs an [SolanaSigner] with the provided ED25519 private key.
  SolanaSigner(this._ed25519PrivateKey);

  /// Signs a digest and returns the signature as an [SolanaSignature].
  SolanaSignature sign(Uint8List message) {
    ED25519Signer signer = ED25519Signer(privateKey: _ed25519PrivateKey, hashFunction: Sha512());

    EDSignature edSignature = signer.sign(message);
    return SolanaSignature(r: edSignature.r, s: edSignature.s);
  }
}
