import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ABip32PrivateKey extends Equatable {
  final Bip32KeyMetadata metadata;

  const ABip32PrivateKey({
    required this.metadata,
  });

  String getExtendedPrivateKey([Uint8List? keyNetVerBytes]) {
    Uint8List serializedPrivateKey = Uint8List.fromList(<int>[
      ...keyNetVerBytes ?? Bip32NetworkVersion.mainnet.private,
      ...BigIntUtils.changeToBytes(BigInt.from(metadata.depth), length: 1),
      ...BigIntUtils.changeToBytes(metadata.parentFingerprint),
      ...LegacyDerivationPathElement.fromShiftedIndex(metadata.shiftedIndex ?? 0).toBytes(),
      ...metadata.chainCode,
      ...<int>[0x00, ...bytes],
    ]);

    return Base58Encoder.encodeWithChecksum(serializedPrivateKey);
  }

  int get length => bytes.length;

  Uint8List get bytes;

  ABip32PublicKey get publicKey;
}
