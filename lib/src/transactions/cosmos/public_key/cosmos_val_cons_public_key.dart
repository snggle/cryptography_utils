import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';

/// Data object holding the public key component of a validator's account or signature.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/crypto/ed25519/keys.proto#L15
class CosmosValConsPublicKey extends CosmosPublicKey {
  /// Represents public key bytes.
  final Uint8List key;

  /// Constructs a [ValConsPubKey] with the given key.
  const CosmosValConsPublicKey(this.key) : super(typeUrl: '/cosmos.crypto.ed25519.PubKey');

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, key),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'key': base64Encode(key),
    };
  }

  @override
  List<Object?> get props => <Object>[key];
}
