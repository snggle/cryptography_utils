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

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/hash/keccak/keccak_bit_length.dart';

/// Provides functionality for creating Ethereum-compatible digital signatures using an ECDSA private key.
/// This class supports signing arbitrary messages in a manner that is compliant with Ethereum's standard for
/// handling signed messages outside of transactions (e.g., for authentication or proving ownership of an address).
class EthereumSigner {
  /// The prefix string used for Ethereum's raw message format.
  static const String _ethPersonalSignPrefix = '\u0019Ethereum Signed Message:\n';

  /// The ECDSA private key used for signing messages.
  final ECPrivateKey _ecPrivateKey;

  /// Constructs an [EthereumSigner] with the provided ECDSA private key.
  EthereumSigner(this._ecPrivateKey);

  /// Signs a personal message according to Ethereum's standard. This involves prefixing the message with a
  /// specific format string and the message length before signing, to clearly indicate that the message was
  /// signed in a personal context outside of Ethereum transactions.
  EthereumSignature signPersonalMessage(List<int> digest, {int? payloadLength}) {
    String prefix = _ethPersonalSignPrefix + (payloadLength?.toString() ?? digest.length.toString());
    Uint8List prefixBytes = ascii.encode(prefix);
    EthereumSignature ethereumSignature = sign(Uint8List.fromList(<int>[...prefixBytes, ...digest]));
    return ethereumSignature.copyWith(eip155Bool: true);
  }

  /// Signs a digest and returns the signature as an [EthereumSignature]. This method can optionally hash the
  /// digest before signing, which is typically required when the input is not already a hash.
  EthereumSignature sign(Uint8List digest, {bool hashMessage = true}) {
    ECDSASigner ecdsaSigner = ECDSASigner(hashFunction: sha256, ecPrivateKey: _ecPrivateKey);
    EthereumVerifier ethereumVerifier = EthereumVerifier(_ecPrivateKey.ecPublicKey);

    Uint8List hash = hashMessage ? Keccak(KeccakBitLength.keccak256).process(digest) : digest;
    if (hash.length != _ecPrivateKey.G.curve.baselen) {
      throw FormatException('Invalid digest: Digest length must be ${_ecPrivateKey.G.curve.baselen} got ${digest.length}');
    }

    ECSignature ecSignature = ecdsaSigner.sign(hash);
    if (ecSignature.s > (_ecPrivateKey.G.n >> 1)) {
      ecSignature = ECSignature(r: ecSignature.r, s: _ecPrivateKey.G.n - ecSignature.s, ecCurve: _ecPrivateKey.G.curve);
    }
    EthereumSignature ethereumSignature = EthereumSignature.fromBytes(ecSignature.bytes);

    bool signatureValidBool = ethereumVerifier.isSignatureValid(hash, ethereumSignature, hashMessage: false);
    if (signatureValidBool) {
      List<ECPublicKey> recover = ecSignature.recoverPublicKeys(hash, CurvePoints.generatorSecp256k1);
      for (int i = 0; i < recover.length; i++) {
        if (recover[i].Q == _ecPrivateKey.ecPublicKey.Q) {
          return EthereumSignature(s: ecSignature.s, r: ecSignature.r, v: i + 27);
        }
      }
    }

    throw const FormatException('The created signature does not pass verification.');
  }
}
