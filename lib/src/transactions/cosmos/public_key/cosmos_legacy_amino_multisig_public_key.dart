import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';

/// [CosmosLegacyAminoMultisigPublicKey] specifies a public key type which nests multiple public keys and a threshold, it uses legacy amino address rules.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/crypto/multisig/keys.proto
class CosmosLegacyAminoMultisigPublicKey extends CosmosPublicKey {
  /// The threshold number of signatures required for the multisig public key.
  final int threshold;

  /// The list of simple public keys involved in the multisig.
  final List<CosmosSimplePublicKey> publicKeys;

  const CosmosLegacyAminoMultisigPublicKey({
    required this.threshold,
    required this.publicKeys,
  }) : super(typeUrl: '/cosmos.crypto.multisig.LegacyAminoPubKey');

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, threshold),
      ...ProtobufEncoder.encode(2, publicKeys),
    ]);
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'threshold': threshold,
      'public_keys': publicKeys.map((CosmosSimplePublicKey e) => e.toProtoJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object>[threshold, publicKeys];
}
