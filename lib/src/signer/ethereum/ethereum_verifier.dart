// Class was shaped by the influence of several key sources including:
// "blockchain_utils" - Copyright (c) 2010 Mohsen
// https://github.com/mrtnetwork/blockchain_utils/.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/ecdsa/signer/ecdsa_verifier.dart';

/// Provides functionality for verifying Ethereum-compatible digital signatures using an ECDSA public key.
/// This class is used to confirm that a given signature corresponds to a specific message and was created using
/// the private key associated with the provided public key, thereby verifying the authenticity of the signature.
class EthereumVerifier {
  /// The ECDSA public key used to verify signatures.
  final ECPublicKey _ecPublicKey;

  /// Constructs an [EthereumVerifier] with the provided ECDSA public key.
  /// This public key will be used for all signature verifications performed by instances of this class.
  EthereumVerifier(this._ecPublicKey);

  /// Verifies a signature against a provided digest and the public key stored in this verifier. This method
  /// supports an option to hash the digest before verification, which should be used if the original message
  /// rather than a precomputed hash was signed.
  bool isSignatureValid(Uint8List digest, EthereumSignature ethereumSignature, {bool hashMessage = true}) {
    Uint8List signature = ethereumSignature.toBytes(eip155Bool: true);
    Uint8List sigBytes = signature.sublist(0, EthereumSignature.ethSignatureLength);
    Uint8List hashDigest = hashMessage ? Keccak(256).process(digest) : digest;

    ECDSAVerifier ecdsaVerifier = ECDSAVerifier(hashFunction: sha256, ecPublicKey: _ecPublicKey);
    ECSignature ecSignature = ECSignature.fromBytes(sigBytes);
    return ecdsaVerifier.isSignatureValid(hashDigest, ecSignature);
  }
}
