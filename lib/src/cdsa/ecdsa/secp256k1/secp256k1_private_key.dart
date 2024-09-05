import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [Secp256k1PrivateKey] represents [ECPrivateKey] constructed with specific Curve (secp256k1) and chain code.
class Secp256k1PrivateKey extends ABip32PrivateKey {
  /// ECDSA Private key used for cryptographic operations, following the secp256k1 curve specification.
  final ECPrivateKey ecPrivateKey;

  const Secp256k1PrivateKey({
    required this.ecPrivateKey,
    required super.metadata,
  });

  factory Secp256k1PrivateKey.fromBytes(Uint8List bytes, {Bip32KeyMetadata? metadata}) {
    ECPrivateKey ecPrivateKey = ECPrivateKey.fromBytes(bytes, CurvePoints.generatorSecp256k1);
    Bip32KeyMetadata updatedMetadata = metadata ?? Bip32KeyMetadata.fromCompressedPublicKey(compressedPublicKey: ecPrivateKey.ecPublicKey.compressed);
    return Secp256k1PrivateKey(ecPrivateKey: ecPrivateKey, metadata: updatedMetadata);
  }

  factory Secp256k1PrivateKey.fromExtendedPrivateKey(String extendedPrivateKey) {
    Uint8List decodedXPrv = Base58Encoder.decode(extendedPrivateKey);
    List<Uint8List> decodedXPubParts = BytesUtils.chunkBytes(bytes: decodedXPrv, chunkSizes: ABip32PrivateKey.xprvChunkSizes);

    BigInt depth = BigIntUtils.decode(decodedXPubParts[1]);
    BigInt parentFingerprint = BigIntUtils.decode(decodedXPubParts[2]);
    BigInt shiftedIndex = BigIntUtils.decode(decodedXPubParts[3]);
    Uint8List chainCode = decodedXPubParts[4];
    Uint8List privateKeyBytes = decodedXPubParts[5];

    Secp256k1PrivateKey privateKey = Secp256k1PrivateKey.fromBytes(privateKeyBytes.sublist(1));

    return Secp256k1PrivateKey.fromBytes(
      privateKey.bytes,
      metadata: Bip32KeyMetadata.fromCompressedPublicKey(
        compressedPublicKey: privateKey.publicKey.compressed,
        depth: depth.toInt(),
        chainCode: chainCode,
        parentFingerprint: parentFingerprint,
        shiftedIndex: shiftedIndex.toInt(),
      ),
    );
  }

  /// Returns the private key as a byte array.
  @override
  Uint8List get bytes => ecPrivateKey.bytes;

  /// Returns the length of the private key.
  @override
  int get length => ECPrivateKey.length;

  /// Returns the public key derived from the private key.
  @override
  Secp256k1PublicKey get publicKey {
    return Secp256k1PublicKey(
      ecPublicKey: ecPrivateKey.ecPublicKey,
      metadata: metadata,
    );
  }

  @override
  List<Object?> get props => <Object?>[ecPrivateKey, metadata];
}
