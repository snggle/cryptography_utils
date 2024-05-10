import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ABip32PublicKey extends Equatable {
  final Bip32KeyMetadata metadata;

  const ABip32PublicKey({
    required this.metadata,
  });

  String getExtendedPublicKey([Uint8List? keyNetVerBytes]) {
    Uint8List serializedPublicKey = Uint8List.fromList(<int>[
      ...keyNetVerBytes ?? Bip32NetworkVersion.mainnet.public,
      ...BigIntUtils.changeToBytes(BigInt.from(metadata.depth), length: 1),
      ...BigIntUtils.changeToBytes(metadata.parentFingerprint),
      ...LegacyDerivationPathElement.fromShiftedIndex(metadata.shiftedIndex ?? 0).toBytes(),
      ...metadata.chainCode,
      ...bytes
    ]);

    return Base58Encoder.encodeWithChecksum(serializedPublicKey);
  }

  Uint8List get bytes;
}
