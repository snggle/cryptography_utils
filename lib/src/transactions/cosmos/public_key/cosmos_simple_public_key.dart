import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';

/// Data object holding the SIMPLE public key component of an account or signature.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/crypto/secp256k1/keys.proto#L15
class CosmosSimplePublicKey extends CosmosPublicKey {
  /// Represents public key bytes.
  final Uint8List key;

  /// Constructs a [SimplePublicKey] with the given key.
  const CosmosSimplePublicKey(this.key) : super(typeUrl: '/cosmos.crypto.secp256k1.PubKey');

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, key),
    ]);
  }

  /// Converts the object to a JSON object compatible with Protobuf.
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
