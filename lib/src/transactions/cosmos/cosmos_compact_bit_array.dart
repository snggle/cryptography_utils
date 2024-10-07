import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';

/// [CosmosCompactBitArray] is an implementation of a space efficient bit array.
/// This is used to ensure that the encoded data takes up a minimal amount of space after proto encoding.
/// This is not thread safe, and is not intended for concurrent usage.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/crypto/multisig/v1beta1/multisig.proto#L20
class CosmosCompactBitArray extends AProtobufObject {
  /// The number of extra bits stored in the compact bit array.
  final int extraBitsStored;

  /// The byte elements of the compact bit array.
  final Uint8List elems;

  CosmosCompactBitArray({
    required this.extraBitsStored,
    required this.elems,
  });

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: ProtobufInt32(extraBitsStored),
      2: ProtobufBytes(elems),
    });
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'extra_bits_stored': extraBitsStored,
      'elems': base64Encode(elems),
    };
  }

  @override
  List<Object?> get props => <Object?>[extraBitsStored, elems];
}
