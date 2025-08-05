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

/// [ED25519Derivator] is a class that implements the derivation of [ED25519PrivateKey] objects.
class ED25519Derivator extends ALegacyDerivator<ED25519PrivateKey> {
  static const List<int> _hardenedPrivateKeyPrefix = <int>[0x00];

  @override
  DerivatorType get derivatorType => DerivatorType.ed25519;

  /// Derives a [ED25519PrivateKey] from a mnemonic phrase and full derivation path
  @override
  Future<ED25519PrivateKey> derivePath(Mnemonic mnemonic, LegacyDerivationPath legacyDerivationPath) async {
    ED25519PrivateKey masterPrivateKey = await deriveMasterKey(mnemonic);
    ED25519PrivateKey childPrivateKey = masterPrivateKey;
    for (LegacyDerivationPathElement derivationPathElement in legacyDerivationPath.pathElements) {
      childPrivateKey = deriveChildKey(childPrivateKey, derivationPathElement);
    }

    return childPrivateKey;
  }

  /// Derives a master [ED25519PrivateKey] from a mnemonic phrase
  @override
  Future<ED25519PrivateKey> deriveMasterKey(Mnemonic mnemonic) async {
    LegacyMnemonicSeedGenerator seedGenerator = LegacyMnemonicSeedGenerator(seedLength: 64);
    Uint8List seedUint8List = await seedGenerator.generateSeed(mnemonic);
    Uint8List hmacHashUint8List = HMAC(hash: Sha512(), key: Bip32HMACKeys.hmacKeyED25519Bytes).process(seedUint8List);

    Uint8List privateKeyUint8List = hmacHashUint8List.sublist(0, 32);
    Uint8List chainCodeUint8List = hmacHashUint8List.sublist(32);

    EDPrivateKey edPrivateKey = EDPrivateKey.fromBytes(privateKeyUint8List);
    BigInt masterFingerprint = ABip32PublicKey.calcFingerprint(edPrivateKey.edPublicKey.bytes);

    ED25519PrivateKey ed25519privateKey = ED25519PrivateKey(
      metadata: Bip32KeyMetadata(
        depth: 0,
        chainCode: chainCodeUint8List,
        fingerprint: masterFingerprint,
        parentFingerprint: BigInt.from(0x00000000),
        masterFingerprint: masterFingerprint,
      ),
      edPrivateKey: edPrivateKey,
    );

    return ed25519privateKey;
  }

  /// Derives a child [ED25519PrivateKey] from a parent [ED25519PrivateKey] and a single element of a derivation path
  @override
  ED25519PrivateKey deriveChildKey(ED25519PrivateKey ed25519privateKey, LegacyDerivationPathElement derivationPathElement) {
    return _deriveHard(ed25519privateKey, derivationPathElement);
  }

  /// Derives a child [ED25519PrivateKey] from a parent [ED25519PrivateKey] and a single hardened element of a derivation path
  ED25519PrivateKey _deriveHard(ED25519PrivateKey parentEd25519PrivateKey, LegacyDerivationPathElement legacyDerivationPathElement) {
    Bip32KeyMetadata parentBip32KeyMetadata = parentEd25519PrivateKey.metadata;
    if (parentBip32KeyMetadata.chainCode == null) {
      throw Exception('Cannot derive hardened key without chain code');
    }

    Uint8List dataUint8List =
        Uint8List.fromList(<int>[..._hardenedPrivateKeyPrefix, ...parentEd25519PrivateKey.bytes, ...legacyDerivationPathElement.toBytes()]);

    Uint8List hmacHashUint8List = HMAC(hash: Sha512(), key: parentBip32KeyMetadata.chainCode!).process(dataUint8List);
    Uint8List scalarUint8List = hmacHashUint8List.sublist(0, 32);
    Uint8List chainCodeUint8List = hmacHashUint8List.sublist(32);

    EDPrivateKey edPrivateKey = EDPrivateKey.fromBytes(scalarUint8List);

    return ED25519PrivateKey(
      metadata: parentBip32KeyMetadata.deriveNext(
        newChainCode: chainCodeUint8List,
        newCompressedPublicKey: edPrivateKey.edPublicKey.bytes,
        newShiftedIndex: legacyDerivationPathElement.shiftedIndex,
      ),
      edPrivateKey: edPrivateKey,
    );
  }
}
