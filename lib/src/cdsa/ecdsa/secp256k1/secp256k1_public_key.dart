import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:cryptography_utils/src/utils/bytes_utils.dart';

/// [Secp256k1PublicKey] represents [ECPublicKey] constructed with specific Curve (secp256k1) and chain code.
class Secp256k1PublicKey extends ABip32PublicKey {
  /// ECDSA public key derived from the corresponding private key, following the secp256k1 curve specification.
  /// This public key is used in the verification process of digital signatures, allowing others to verify the authenticity
  /// of transactions or messages signed with the associated private key, without compromising the private key itself.
  final ECPublicKey ecPublicKey;

  const Secp256k1PublicKey({
    required this.ecPublicKey,
    required super.metadata,
  });

  factory Secp256k1PublicKey.fromCompressedBytes(List<int> bytes, {Bip32KeyMetadata? metadata}) {
    ECPublicKey ecPublicKey = ECPublicKey.fromCompressedBytes(bytes, CurvePoints.generatorSecp256k1);
    Bip32KeyMetadata updatedMetadata = metadata ?? Bip32KeyMetadata.fromCompressedPublicKey(compressedPublicKey: ecPublicKey.compressed);
    return Secp256k1PublicKey(ecPublicKey: ecPublicKey, metadata: updatedMetadata);
  }

  factory Secp256k1PublicKey.fromUncompressedBytes(List<int> bytes, {Bip32KeyMetadata? metadata}) {
    ECPublicKey ecPublicKey = ECPublicKey.fromUncompressedBytes(bytes, CurvePoints.generatorSecp256k1);
    Bip32KeyMetadata updatedMetadata = metadata ?? Bip32KeyMetadata.fromCompressedPublicKey(compressedPublicKey: ecPublicKey.compressed);
    return Secp256k1PublicKey(ecPublicKey: ecPublicKey, metadata: updatedMetadata);
  }

  factory Secp256k1PublicKey.fromExtendedPublicKey(String extendedPublicKey) {
    Uint8List decodedXPub = Base58Codec.decode(extendedPublicKey);
    List<Uint8List> decodedXPubParts = BytesUtils.chunkBytes(bytes: decodedXPub, chunkSizes: ABip32PublicKey.xpubChunkSizes);

    BigInt depth = BigIntUtils.decode(decodedXPubParts[1]);
    BigInt parentFingerprint = BigIntUtils.decode(decodedXPubParts[2]);
    BigInt shiftedIndex = BigIntUtils.decode(decodedXPubParts[3]);
    Uint8List chainCode = decodedXPubParts[4];
    Uint8List compressedPublicKey = decodedXPubParts[5];

    return Secp256k1PublicKey.fromCompressedBytes(
      compressedPublicKey,
      metadata: Bip32KeyMetadata.fromCompressedPublicKey(
        compressedPublicKey: compressedPublicKey,
        depth: depth.toInt(),
        chainCode: chainCode,
        parentFingerprint: parentFingerprint,
        shiftedIndex: shiftedIndex.toInt(),
      ),
    );
  }

  /// Returns the compressed form of the public key.
  @override
  Uint8List get compressed => ecPublicKey.compressed;

  /// Returns the uncompressed form of the public key.
  @override
  Uint8List get uncompressed => ecPublicKey.uncompressed;

  @override
  List<Object?> get props => <Object?>[ecPublicKey, metadata];
}
