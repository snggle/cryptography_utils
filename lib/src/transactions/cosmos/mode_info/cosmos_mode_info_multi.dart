import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_mixin.dart';
import 'package:equatable/equatable.dart';

/// Mode info for a multisig public key
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L201
class CosmosModeInfoMulti with ProtobufMixin, EquatableMixin {
  /// Specifies which keys within the multisig are signing
  final CosmosCompactBitArray bitArray;

  /// Modes of the signers of the multisig which could include nested multisig public keys
  final List<CosmosModeInfo> modeInfos;

  /// Constructs a [CosmosModeInfoMulti] with the provided bit array and mode infos.
  CosmosModeInfoMulti({
    required this.bitArray,
    required this.modeInfos,
  });

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, bitArray),
      ...ProtobufEncoder.encode(2, modeInfos),
    ]);
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'bitarray': bitArray.toProtoJson(),
      'mode_infos': modeInfos.map((CosmosModeInfo e) => e.toProtoJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object?>[bitArray, modeInfos];
}
