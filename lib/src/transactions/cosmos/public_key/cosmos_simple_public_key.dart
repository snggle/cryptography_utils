import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// Data object holding the SIMPLE public key component of an account or signature.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/crypto/secp256k1/keys.proto#L14
class CosmosSimplePublicKey extends CosmosPublicKey {
  /// Represents public key bytes.
  final Uint8List key;

  /// Constructs a [CosmosSimplePublicKey] with the given key.
  const CosmosSimplePublicKey(this.key) : super(typeUrl: '/cosmos.crypto.secp256k1.PubKey');

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: ProtobufBytes(key),
    });
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
