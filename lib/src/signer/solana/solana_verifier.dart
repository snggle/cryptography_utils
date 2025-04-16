import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed25519_signer.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';

class SolanaVerifier {
  final ED25519PrivateKey _privateKey;

  SolanaVerifier(this._privateKey);

  bool isSignatureValid(Uint8List message, SolanaSignature signature) {
    Uint8List r = signature.signatureBytes.sublist(0, 32);
    Uint8List s = signature.signatureBytes.sublist(32, 64);
    EDSignature edSignature = EDSignature(r: r, s: s);

    ED25519Signer signer = ED25519Signer(
      privateKey: _privateKey,
      hashFunction: Sha512(),
    );

    return signer.verifySignature(message, edSignature);
  }
}
