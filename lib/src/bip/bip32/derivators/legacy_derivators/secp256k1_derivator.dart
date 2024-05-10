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

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// [Secp256k1Derivator] is a class that implements the derivation of [Secp256k1PrivateKey] objects.
class Secp256k1Derivator implements ILegacyDerivator<Secp256k1PrivateKey> {
  static const List<int> _hardenedPrivateKeyPrefix = <int>[0x00];

  /// Derives a [Secp256k1PrivateKey] from a mnemonic pharse and full derivation path
  @override
  Future<Secp256k1PrivateKey> derivePath(Mnemonic mnemonic, LegacyDerivationPath legacyDerivationPath) async {
    Secp256k1PrivateKey masterPrivateKey = await deriveMasterKey(mnemonic);
    Secp256k1PrivateKey childPrivateKey = masterPrivateKey;
    for (LegacyDerivationPathElement derivationPathElement in legacyDerivationPath.pathElements) {
      childPrivateKey = deriveChildKey(childPrivateKey, derivationPathElement);
    }
    return childPrivateKey;
  }

  /// Derives a master [Secp256k1PrivateKey] from a mnemonic phrase
  @override
  Future<Secp256k1PrivateKey> deriveMasterKey(Mnemonic mnemonic) async {
    LegacyMnemonicSeedGenerator seedGenerator = LegacyMnemonicSeedGenerator();
    Uint8List seed = await seedGenerator.generateSeed(mnemonic);
    Uint8List hmacHash = HMAC(hash: sha512, key: Bip32HMACKeys.hmacKeySecp256k1Bytes).process(seed);

    Uint8List privateKey = hmacHash.sublist(0, 32);
    Uint8List chainCode = hmacHash.sublist(32);

    ECPrivateKey ecPrivateKey = ECPrivateKey.fromBytes(privateKey, CurvePoints.generatorSecp256k1);
    BigInt masterFingerprint = _calcFingerprint(ecPrivateKey.ecPublicKey.compressed);

    return Secp256k1PrivateKey(
        ecPrivateKey: ecPrivateKey,
        metadata: Bip32KeyMetadata(
          depth: 0,
          chainCode: chainCode,
          fingerprint: masterFingerprint,
          parentFingerprint: BigInt.from(0x00000000),
          masterFingerprint: masterFingerprint,
        ));
  }

  /// Derives a child [Secp256k1PrivateKey] from a parent [Secp256k1PrivateKey] and a single element of a derivation path
  @override
  Secp256k1PrivateKey deriveChildKey(Secp256k1PrivateKey privateKey, LegacyDerivationPathElement derivationPathElement) {
    if (derivationPathElement.isHardened) {
      return _deriveHard(privateKey, derivationPathElement);
    } else {
      return _deriveSoft(privateKey, derivationPathElement);
    }
  }

  /// Derives a child [Secp256k1PrivateKey] from a parent [Secp256k1PrivateKey] and a single hardened element of a derivation path
  Secp256k1PrivateKey _deriveHard(Secp256k1PrivateKey secp256k1privateKey, LegacyDerivationPathElement legacyDerivationPathElement) {
    Uint8List data = Uint8List.fromList(<int>[..._hardenedPrivateKeyPrefix, ...secp256k1privateKey.bytes, ...legacyDerivationPathElement.toBytes()]);

    Uint8List hmacHash = HMAC(hash: sha512, key: secp256k1privateKey.metadata.chainCode).process(data);

    Uint8List scalarBytes = hmacHash.sublist(0, 32);
    Uint8List chainCodeBytes = hmacHash.sublist(32);

    BigInt scalar = BigIntUtils.decode(scalarBytes);
    BigInt privateKeyScalar = BigIntUtils.decode(secp256k1privateKey.bytes);
    BigInt privateKey = (scalar + privateKeyScalar) % CurvePoints.generatorSecp256k1.n;
    Uint8List privateKeyBytes = BigIntUtils.changeToBytes(privateKey, length: secp256k1privateKey.length);

    ECPrivateKey ecPrivateKey = ECPrivateKey.fromBytes(privateKeyBytes, CurvePoints.generatorSecp256k1);
    BigInt fingerprint = _calcFingerprint(ecPrivateKey.ecPublicKey.compressed);

    return Secp256k1PrivateKey(
      ecPrivateKey: ecPrivateKey,
      metadata: Bip32KeyMetadata(
        depth: secp256k1privateKey.metadata.depth + 1,
        shiftedIndex: legacyDerivationPathElement.shiftedIndex,
        chainCode: chainCodeBytes,
        fingerprint: fingerprint,
        parentFingerprint: secp256k1privateKey.metadata.fingerprint,
        masterFingerprint: secp256k1privateKey.metadata.masterFingerprint,
      ),
    );
  }

  /// Derives a child [Secp256k1PrivateKey] from a parent [Secp256k1PrivateKey] and a single non-hardened element of a derivation path
  Secp256k1PrivateKey _deriveSoft(Secp256k1PrivateKey secp256k1privateKey, LegacyDerivationPathElement legacyDerivationPathElement) {
    Uint8List data = Uint8List.fromList(<int>[...secp256k1privateKey.publicKey.compressed, ...legacyDerivationPathElement.toBytes()]);

    Uint8List hmacHash = HMAC(hash: sha512, key: secp256k1privateKey.metadata.chainCode).process(data);

    Uint8List scalarBytes = hmacHash.sublist(0, 32);
    Uint8List chainCodeBytes = hmacHash.sublist(32);

    BigInt scalar = BigIntUtils.decode(scalarBytes);
    BigInt privateKeyScalar = BigIntUtils.decode(secp256k1privateKey.bytes);
    BigInt privateKey = (scalar + privateKeyScalar) % CurvePoints.generatorSecp256k1.n;
    Uint8List privateKeyBytes = BigIntUtils.changeToBytes(privateKey, length: secp256k1privateKey.length);

    ECPrivateKey ecPrivateKey = ECPrivateKey.fromBytes(privateKeyBytes, CurvePoints.generatorSecp256k1);
    BigInt fingerprint = _calcFingerprint(ecPrivateKey.ecPublicKey.compressed);

    return Secp256k1PrivateKey(
      ecPrivateKey: ecPrivateKey,
      metadata: Bip32KeyMetadata(
        depth: secp256k1privateKey.metadata.depth + 1,
        shiftedIndex: legacyDerivationPathElement.shiftedIndex,
        chainCode: chainCodeBytes,
        fingerprint: fingerprint,
        parentFingerprint: secp256k1privateKey.metadata.fingerprint,
        masterFingerprint: secp256k1privateKey.metadata.masterFingerprint,
      ),
    );
  }

  BigInt _calcFingerprint(Uint8List publicKeyBytes) {
    Uint8List sha256Fingerprint = Uint8List.fromList(sha256.convert(publicKeyBytes).bytes);
    Uint8List ripemd160Fingerprint = Uint8List.fromList(Ripemd160().process(sha256Fingerprint));
    return BigIntUtils.decode(ripemd160Fingerprint.sublist(0, 4));
  }
}
