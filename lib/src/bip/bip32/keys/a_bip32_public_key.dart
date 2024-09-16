import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ABip32PublicKey extends Equatable {
  /// Value sizes for Extended public key (xpub).
  /// Extended private key contains 78 bytes, which are divided into 6 parts.
  static const int _xpubPrefixSize = 4;
  static const int _xpubDepthSize = 1;
  static const int _xpubParentFingerprintSize = 4;
  static const int _xpubShiftedIndexSize = 4;
  static const int _xpubChainCodeSize = 32;
  static const int _xpubPublicKeySize = 33;

  static const List<int> xpubChunkSizes = <int>[
    _xpubPrefixSize,
    _xpubDepthSize,
    _xpubParentFingerprintSize,
    _xpubShiftedIndexSize,
    _xpubChainCodeSize,
    _xpubPublicKeySize,
  ];

  final Bip32KeyMetadata metadata;

  const ABip32PublicKey({
    required this.metadata,
  });

  static BigInt calcFingerprint(Uint8List publicKeyBytes) {
    Uint8List sha256Fingerprint = Uint8List.fromList(sha256.convert(publicKeyBytes).bytes);
    Uint8List ripemd160Fingerprint = Uint8List.fromList(Ripemd160().process(sha256Fingerprint));
    return BigIntUtils.decode(ripemd160Fingerprint.sublist(0, 4));
  }

  String getExtendedPublicKey([Uint8List? keyNetVerBytes]) {
    if (metadata.canBuildExtendedKey == false) {
      throw AssertionError('Cannot generate extended public key without metadata');
    }

    Uint8List serializedPublicKey = Uint8List.fromList(<int>[
      ...keyNetVerBytes ?? Bip32NetworkVersion.mainnet.public,
      metadata.depth!,
      ...BigIntUtils.changeToBytes(metadata.parentFingerprint!, length: _xpubParentFingerprintSize),
      ...LegacyDerivationPathElement.fromShiftedIndex(metadata.shiftedIndex ?? 0).toBytes(),
      ...metadata.chainCode!,
      ...compressed
    ]);

    return Base58Codec.encodeWithChecksum(serializedPublicKey);
  }

  Uint8List get compressed;

  Uint8List get uncompressed;
}
