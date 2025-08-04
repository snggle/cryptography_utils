import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed25519_signer.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';

/// A signer for Solana Ed25519 signatures.
class SolanaSigner {
  final ED25519PrivateKey _ed25519PrivateKey;

  SolanaSigner(this._ed25519PrivateKey);

  SolanaSignature sign(Uint8List message) {
    ED25519Signer signer = ED25519Signer(privateKey: _ed25519PrivateKey, hashFunction: Sha512());

    EDSignature edSignature = signer.sign(message);
    return SolanaSignature(r: edSignature.r, s: edSignature.s);
  }
}