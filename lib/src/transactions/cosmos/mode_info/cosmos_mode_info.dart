import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_mixin.dart';
import 'package:equatable/equatable.dart';

/// [CosmosModeInfo] describes the signing mode of a single or nested multisig signer.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L181
class CosmosModeInfo with ProtobufMixin, EquatableMixin {
  /// Represents a single signer
  final CosmosModeInfoSingle? single;

  /// Represents a nested multisig signer
  final CosmosModeInfoMulti? multi;

  CosmosModeInfo._({
    this.single,
    this.multi,
  });

  /// Constructs a [CosmosModeInfo] with the provided single signer.
  factory CosmosModeInfo.single(CosmosSignMode signMode) {
    return CosmosModeInfo._(single: CosmosModeInfoSingle(signMode));
  }

  /// Constructs a [CosmosModeInfo] with the provided multi signer.
  factory CosmosModeInfo.multi({required CosmosCompactBitArray bitArray, required List<CosmosModeInfo> modeInfos}) {
    return CosmosModeInfo._(multi: CosmosModeInfoMulti(bitArray: bitArray, modeInfos: modeInfos));
  }

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, single),
      ...ProtobufEncoder.encode(2, multi),
    ]);
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    if (single != null) {
      return <String, dynamic>{'single': single?.toProtoJson()};
    } else {
      return <String, dynamic>{'multi': multi?.toProtoJson()};
    }
  }

  @override
  List<Object?> get props => <Object?>[single, multi];
}
