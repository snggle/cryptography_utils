import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ABip32PrivateKey extends Equatable {
  /// Value sizes for Extended private key (xprv).
  /// Extended private key contains 78 bytes, which are divided into 6 parts.
  static const int _xprvPrefixSize = 4;
  static const int _xprvDepthSize = 1;
  static const int _xprvParentFingerprintSize = 4;
  static const int _xprvShiftedIndexSize = 4;
  static const int _xprvChainCodeSize = 32;
  static const int _xprvPrivateKeySize = 33;

  static const List<int> xprvChunkSizes = <int>[
    _xprvPrefixSize,
    _xprvDepthSize,
    _xprvParentFingerprintSize,
    _xprvShiftedIndexSize,
    _xprvChainCodeSize,
    _xprvPrivateKeySize,
  ];

  final Bip32KeyMetadata metadata;

  const ABip32PrivateKey({
    required this.metadata,
  });

  String getExtendedPrivateKey([Uint8List? keyNetVerBytes]) {
    if (metadata.canBuildExtendedKey == false) {
      throw AssertionError('Cannot generate extended public key without metadata');
    }

    Uint8List serializedPrivateKey = Uint8List.fromList(<int>[
      ...keyNetVerBytes ?? Bip32NetworkVersion.mainnet.private,
      metadata.depth!,
      ...BigIntUtils.changeToBytes(metadata.parentFingerprint!, length: _xprvParentFingerprintSize),
      ...LegacyDerivationPathElement.fromShiftedIndex(metadata.shiftedIndex ?? 0).toBytes(),
      ...metadata.chainCode!,
      ...<int>[0x00, ...bytes],
    ]);

    return Base58Encoder.encodeWithChecksum(serializedPrivateKey);
  }

  int get length => bytes.length;

  Uint8List get bytes;

  ABip32PublicKey get publicKey;
}
