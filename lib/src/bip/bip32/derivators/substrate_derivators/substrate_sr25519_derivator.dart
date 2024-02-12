// Class was shaped by the influence of several key sources including:
// "blockchain_utils" - Copyright (c) 2010 Mohsen
// https://github.com/mrtnetwork/blockchain_utils/.
//
// BSD 3-Clause License
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [SubstrateSR25519Derivator] is a class that implements the derivation of [SR25519PrivateKey] objects.
class SubstrateSR25519Derivator implements ISubstrateDerivator<SR25519PrivateKey> {
  
  /// Derives a [SR25519PrivateKey] from a SURI
  @override
  Future<SR25519PrivateKey> derivePath(SubstrateDerivationPath derivationPath) async {
    SR25519PrivateKey masterPrivateKey = await deriveMasterKey(derivationPath);
    SR25519PrivateKey childPrivateKey = masterPrivateKey;
    for (SubstrateDerivationPathElement junction in derivationPath.derivationPathElements) {
      childPrivateKey = deriveChildKey(childPrivateKey, junction);
    }

    return childPrivateKey;
  }

  /// Derives a master [SR25519PrivateKey] from a mnemonic phrase contained in a [SubstrateDerivationPath]
  @override
  Future<SR25519PrivateKey> deriveMasterKey(SubstrateDerivationPath derivationPath) async {
    Uint8List seed = await SubstrateSeedGenerator().calculateSeed(derivationPath);
    EDPrivateKey edPrivateKey = EDPrivateKey.fromBytes(seed);
    SR25519PrivateKey sr25519privateKey = SR25519PrivateKey.fromEDPrivateKey(edPrivateKey);

    return sr25519privateKey;
  }

  /// Derives a child [SR25519PrivateKey] from a parent [SR25519PrivateKey] and a single element of a SURI
  @override
  SR25519PrivateKey deriveChildKey(SR25519PrivateKey sr25519privateKey, SubstrateDerivationPathElement derivationPathElement) {
    if (derivationPathElement.hardenedBool) {
      return _deriveHard(sr25519privateKey, derivationPathElement.id);
    } else {
      return _deriveSoft(sr25519privateKey, derivationPathElement.id);
    }
  }

  /// Derives a child [SR25519PrivateKey] from a parent [SR25519PrivateKey] and a single hardened element of a derivation path
  SR25519PrivateKey _deriveHard(SR25519PrivateKey sr25519privateKey, List<int> derivationBytes) {
    List<int> i = <int>[];
    List<int> cc = List<int>.from(derivationBytes.sublist(0, 32));
    List<int> skenc = sr25519privateKey.key;

    MerlinTranscript script = MerlinTranscript('SchnorrRistrettoHDKD')
      ..appendMessage('sign-bytes', i)
      ..appendMessage('chain-code', cc)
      ..appendMessage('secret-key', skenc);

    Uint8List secret = script.extractBytes('HDKD-hard', 32);
    Uint8List chainCode = script.extractBytes('HDKD-chaincode', 32);

    EDPrivateKey edPrivateKey = EDPrivateKey.fromBytes(secret);

    return SR25519PrivateKey.fromEDPrivateKey(edPrivateKey, chainCode: chainCode);
  }

  /// Derives a child [SR25519PrivateKey] from a parent [SR25519PrivateKey] and a single non-hardened element of a derivation path
  SR25519PrivateKey _deriveSoft(SR25519PrivateKey sr25519PrivateKey, List<int> derivationBytes) {
    List<int> i = <int>[];
    List<int> cc = List<int>.from(derivationBytes.sublist(0, 32));
    List<int> pkenc = sr25519PrivateKey.publicKey.bytes;

    MerlinTranscript script = MerlinTranscript('SchnorrRistrettoHDKD')
      ..appendMessage('sign-bytes', i)
      ..appendMessage('chain-code', cc)
      ..appendMessage('public-key', pkenc);

    Uint8List scalar = script.extractBytes('HDKD-scalar', 64);
    Uint8List chainCode = script.extractBytes('HDKD-chaincode', 32);

    Ristretto255Scalar privateKeyScalar = Ristretto255Scalar.fromBytes(sr25519PrivateKey.key);
    Ristretto255Scalar hdkdScalar = Ristretto255Scalar.fromUniformBytes(scalar);
    Ristretto255Scalar privateKey = privateKeyScalar + hdkdScalar;
    Uint8List nonce = SecureRandom.getBytes(length: 32, max: 255);

    return SR25519PrivateKey(key: privateKey.toBytes(), nonce: nonce, chainCode: chainCode);
  }
}
