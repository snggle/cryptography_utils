import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed25519_signer.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';

/// A signer for Solana Ed25519 signatures.
class SolanaSigner {
  final ED25519PrivateKey _privateKey;

  SolanaSigner(this._privateKey);

  SolanaSignature sign(Uint8List message) {
    ED25519Signer signer = ED25519Signer(
      privateKey: _privateKey,
      hashFunction: Sha512(),
    );

    EDSignature edSignature = signer.sign(message);
    Uint8List combinedSignature = Uint8List.fromList(<int>[...edSignature.r, ...edSignature.s]);
    SolanaSignature solanaSignature = SolanaSignature(combinedSignature);

    SolanaVerifier solanaVerifier = SolanaVerifier(_privateKey);

    bool signatureValidBool = solanaVerifier.isSignatureValid(message, solanaSignature);
    if (signatureValidBool) {
      return solanaSignature;
    }

    throw StateError('Signature verification failed after signing.');
  }
}
