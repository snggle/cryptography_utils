import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/ecdsa/signer/ecdsa_verifier.dart';

/// Provides functionality for verifying Cosmos-compatible digital signatures using an ECDSA public key.
/// This class is used to confirm that a given signature corresponds to a specific [CosmosSignDoc] and was created using
/// the private key associated with the provided public key, thereby verifying the authenticity of the signature.
class CosmosVerifier {
  /// The ECDSA public key used to verify signatures.
  final ECPublicKey _ecPublicKey;

  /// Constructs an [CosmosVerifier] with the provided ECDSA public key.
  /// This public key will be used for all signature verifications performed by instances of this class.
  CosmosVerifier(this._ecPublicKey);

  /// Verifies a signature against a provided digest and the public key stored in this verifier.
  bool isSignatureValid(CosmosSignDoc signDoc, CosmosSignature cosmosSignature) {
    ECDSAVerifier ecdsaVerifier = ECDSAVerifier(hashFunction: sha256, ecPublicKey: _ecPublicKey);
    ECSignature ecSignature = ECSignature.fromBytes(cosmosSignature.bytes, ecCurve: _ecPublicKey.G.curve);

    Uint8List signBytes = signDoc.getDirectSignBytes();
    Uint8List hashedSignBytes = Uint8List.fromList(sha256.convert(signBytes).bytes);

    return ecdsaVerifier.isSignatureValid(hashedSignBytes, ecSignature);
  }
}
