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
import 'package:cryptography_utils/src/bip/bip32/derivators/derivator_type.dart';
import 'package:cryptography_utils/src/encoder/substrate/substrate_scale_encoder.dart';

/// [SubstrateED25519Derivator] is a class that implements the derivation of [ED25519PrivateKey] objects.
class SubstrateED25519Derivator extends ASubstrateDerivator<ED25519PrivateKey> {
  static final Uint8List _prefixBytes = SubstrateScaleEncoder.encodeString('Ed25519HDKD');

  @override
  DerivatorType get derivatorType => DerivatorType.substrateED25519;

  /// Derives a [ED25519PrivateKey] from a SURI
  @override
  Future<ED25519PrivateKey> derivePath(SubstrateDerivationPath derivationPath) async {
    ED25519PrivateKey masterPrivateKey = await deriveMasterKey(derivationPath);
    ED25519PrivateKey childPrivateKey = masterPrivateKey;
    for (SubstrateDerivationPathElement derivationPathElement in derivationPath.derivationPathElements) {
      childPrivateKey = deriveChildKey(childPrivateKey, derivationPathElement);
    }

    return childPrivateKey;
  }

  /// Derives a master [ED25519PrivateKey] from a mnemonic phrase contained in a [SubstrateDerivationPath]
  @override
  Future<ED25519PrivateKey> deriveMasterKey(SubstrateDerivationPath derivationPath) async {
    SubstrateSeedGenerator seedGenerator = SubstrateSeedGenerator();
    Uint8List seed = await seedGenerator.calculateSeed(derivationPath);

    EDPrivateKey edPrivateKey = EDPrivateKey.fromBytes(seed);
    BigInt masterFingerprint = ABip32PublicKey.calcFingerprint(edPrivateKey.edPublicKey.bytes);

    ED25519PrivateKey ed25519privateKey = ED25519PrivateKey(
      metadata: Bip32KeyMetadata(
        depth: 0,
        fingerprint: masterFingerprint,
        parentFingerprint: BigInt.from(0x00000000),
        masterFingerprint: masterFingerprint,
      ),
      edPrivateKey: edPrivateKey,
    );

    return ed25519privateKey;
  }

  /// Derives a child [ED25519PrivateKey] from a parent [ED25519PrivateKey] and a single element of a SURI
  @override
  ED25519PrivateKey deriveChildKey(ED25519PrivateKey ed25519privateKey, SubstrateDerivationPathElement derivationPathElement) {
    if (derivationPathElement.hardenedBool) {
      return _deriveHard(ed25519privateKey, derivationPathElement);
    } else {
      throw ArgumentError('Soft junctions are not supported in ED25519 algorithm');
    }
  }

  /// Derives a child [ED25519PrivateKey] from a parent [ED25519PrivateKey] and a single hardened element of a derivation path
  ED25519PrivateKey _deriveHard(ED25519PrivateKey parentEd25519PrivateKey, SubstrateDerivationPathElement derivationPathElement) {
    Bip32KeyMetadata? parentBip32KeyMetadata = parentEd25519PrivateKey.metadata;

    Uint8List privateKeyBytes = parentEd25519PrivateKey.bytes;
    Uint8List data = Uint8List.fromList(<int>[..._prefixBytes, ...privateKeyBytes, ...derivationPathElement.id]);

    Uint8List output = Blake2d(digestSize: 32).process(data);
    EDPrivateKey edPrivateKey = EDPrivateKey.fromBytes(output);

    ED25519PrivateKey derivedED25519privateKey = ED25519PrivateKey(
      edPrivateKey: edPrivateKey,
      metadata: parentBip32KeyMetadata.deriveNext(
        newCompressedPublicKey: edPrivateKey.edPublicKey.bytes,
      ),
    );
    return derivedED25519privateKey;
  }
}
