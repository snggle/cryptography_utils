import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// [CosmosLegacyAminoMultisigPublicKey] specifies a public key type which nests multiple public keys and a threshold, it uses legacy amino address rules.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/crypto/multisig/keys.proto#L13
class CosmosLegacyAminoMultisigPublicKey extends CosmosPublicKey {
  /// The threshold number of signatures required for the multisig public key.
  final int threshold;

  /// The list of simple public keys involved in the multisig.
  final List<CosmosSimplePublicKey> publicKeys;

  /// Constructs a [CosmosLegacyAminoMultisigPublicKey] with the given key.
  const CosmosLegacyAminoMultisigPublicKey({
    required this.threshold,
    required this.publicKeys,
  }) : super(typeUrl: '/cosmos.crypto.multisig.LegacyAminoPubKey');

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField?>{
      1: ProtobufInt32(threshold),
      2: ProtobufList(publicKeys),
    });
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
