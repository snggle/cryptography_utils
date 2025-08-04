import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed25519_verifier.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';

class SolanaVerifier {
  final ED25519PrivateKey _ed25519PrivateKey;

  SolanaVerifier(this._ed25519PrivateKey);

  bool isSignatureValid(Uint8List message, SolanaSignature solanaSignature) {
    Uint8List r = solanaSignature.signatureBytes.sublist(0, 32);
    Uint8List s = solanaSignature.signatureBytes.sublist(32, 64);
    EDSignature edSignature = EDSignature(r: r, s: s);

    ED25519Verifier verifier = ED25519Verifier(
      hashFunction: Sha512(),
      publicKey: _ed25519PrivateKey.publicKey,
    );

    return verifier.isSignatureValid(message, edSignature);
  }
}
