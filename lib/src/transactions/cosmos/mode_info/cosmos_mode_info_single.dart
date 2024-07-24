import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_mixin.dart';
import 'package:equatable/equatable.dart';

/// Mode info for a single signer. It is structured as a message to allow
/// for additional fields such as locale for SIGN_MODE_TEXTUAL in the future
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L195
class CosmosModeInfoSingle with ProtobufMixin, EquatableMixin {
  /// Signing mode of the single signer
  final CosmosSignMode signMode;

  /// Constructs a [CosmosModeInfoSingle] with the provided signing mode.
  CosmosModeInfoSingle(this.signMode);

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, signMode),
    ]);
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{'mode': signMode.name};
  }

  @override
  List<Object?> get props => <Object?>[signMode];
}
