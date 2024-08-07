import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [Secp256k1PublicKey] represents [ECPublicKey] constructed with specific Curve (secp256k1) and chain code.
class Secp256k1PublicKey extends ABip32PublicKey {
  /// ECDSA public key derived from the corresponding private key, following the secp256k1 curve specification.
  /// This public key is used in the verification process of digital signatures, allowing others to verify the authenticity
  /// of transactions or messages signed with the associated private key, without compromising the private key itself.
  final ECPublicKey ecPublicKey;

  const Secp256k1PublicKey({
    required this.ecPublicKey,
    super.metadata,
  });

  factory Secp256k1PublicKey.fromCompressedBytes(List<int> bytes, {Bip32KeyMetadata? metadata}) {
    ECPublicKey ecPublicKey = ECPublicKey.fromCompressedBytes(bytes, CurvePoints.generatorSecp256k1);
    return Secp256k1PublicKey(ecPublicKey: ecPublicKey, metadata: metadata);
  }

  factory Secp256k1PublicKey.fromUncompressedBytes(List<int> bytes, {Bip32KeyMetadata? metadata}) {
    ECPublicKey ecPublicKey = ECPublicKey.fromUncompressedBytes(bytes, CurvePoints.generatorSecp256k1);
    return Secp256k1PublicKey(ecPublicKey: ecPublicKey, metadata: metadata);
  }

  @override
  Uint8List get bytes => compressed;

  /// Returns the compressed form of the public key.
  Uint8List get compressed => ecPublicKey.compressed;

  /// Returns the uncompressed form of the public key.
  Uint8List get uncompressed => ecPublicKey.uncompressed;

  @override
  List<Object?> get props => <Object?>[ecPublicKey, metadata];
}
