import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// Mode info for a multisig public key
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L206
class CosmosModeInfoMulti extends AProtobufObject {
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
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: bitArray,
      2: ProtobufList(modeInfos),
    });
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
