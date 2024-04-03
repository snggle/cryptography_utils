import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed25519_verifier.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';

/// Provides functionality for verifying Solana-compatible digital signatures using an ED25519 public key.
/// This class is used to confirm that a given signature corresponds to a specific message and was created using
/// the private key associated with the provided public key, thereby verifying the authenticity of the signature.
class SolanaVerifier {
  /// The ED25519 public key used to verify signatures.
  final ED25519PublicKey _ed25519PublicKey;

  /// Constructs an [SolanaVerifier] with the provided ED25519 public key.
  /// This public key will be used for all signature verifications performed by instances of this class.
  SolanaVerifier(this._ed25519PublicKey);

  /// Verifies a signature against a provided digest and the public key stored in this verifier.
  bool isSignatureValid(Uint8List message, SolanaSignature solanaSignature) {
    Uint8List r = solanaSignature.r;
    Uint8List s = solanaSignature.s;
    EDSignature edSignature = EDSignature(r: r, s: s);

    ED25519Verifier verifier = ED25519Verifier(
      hashFunction: Sha512(),
      publicKey: _ed25519PublicKey,
    );

    return verifier.isSignatureValid(message, edSignature);
  }
}
