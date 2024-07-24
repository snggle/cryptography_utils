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

/// Provides functionality for creating Cosmos-compatible digital signatures using an ECDSA private key.
class CosmosSigner {
  /// The ECDSA private key used for signing messages.
  final ECPrivateKey _ecPrivateKey;

  /// Constructs an [CosmosSigner] with the provided ECDSA private key.
  CosmosSigner(this._ecPrivateKey);

  /// Signs given [CosmosSignDoc] using SIGN_MODE_DIRECT and returns the signature as an [CosmosSignature].
  CosmosSignature signDirect(CosmosSignDoc signDoc) {
    ECDSASigner ecdsaSigner = ECDSASigner(hashFunction: sha256, ecPrivateKey: _ecPrivateKey);
    CosmosVerifier cosmosVerifier = CosmosVerifier(_ecPrivateKey.ecPublicKey);

    Uint8List signBytes = signDoc.getDirectSignBytes();
    Uint8List hashedSignBytes = Uint8List.fromList(sha256.convert(signBytes).bytes);

    ECSignature ecSignature = ecdsaSigner.sign(hashedSignBytes);

    if (ecSignature.s > (_ecPrivateKey.G.n >> 1)) {
      ecSignature = ECSignature(r: ecSignature.r, s: _ecPrivateKey.G.n - ecSignature.s, ecCurve: ecSignature.ecCurve);
    }

    CosmosSignature cosmosSignature = CosmosSignature(r: ecSignature.r, s: ecSignature.s);

    bool signatureValidBool = cosmosVerifier.isSignatureValid(signDoc, cosmosSignature);
    if (signatureValidBool) {
      return cosmosSignature;
    } else {
      throw StateError('The created signature (${cosmosSignature.base64}) does not pass verification.');
    }
  }
}
