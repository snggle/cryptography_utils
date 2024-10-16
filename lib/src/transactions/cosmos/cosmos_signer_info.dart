import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/cosmos/mode_info/cosmos_mode_info.dart';
import 'package:cryptography_utils/src/transactions/cosmos/public_key/cosmos_public_key.dart';

/// [CosmosSignerInfo] describes the public key and signing mode of a single top-level signer.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L169
class CosmosSignerInfo extends AProtobufObject {
  /// The public key of the signer. It is optional for accounts that already exist in state.
  /// If unset, the verifier can use the required signer address for this position and lookup the public key.
  final CosmosPublicKey publicKey;

  /// Describes the signing mode of the signer and is a nested structure to support nested multisig pubkey's
  final CosmosModeInfo modeInfo;

  /// Sequence of the account, which describes the number of committed transactions signed by a given address.
  /// It is used to prevent replay attacks.
  final int sequence;

  /// Constructs a [CosmosSignerInfo] with the provided public key, mode info, and sequence.
  const CosmosSignerInfo({
    required this.publicKey,
    required this.modeInfo,
    required this.sequence,
  });

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField?>{
      1: publicKey,
      2: modeInfo,
      3: ProtobufInt32(sequence),
    });
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'public_key': publicKey.toProtoJson(),
      'mode_info': modeInfo.toProtoJson(),
      'sequence': sequence.toString(),
    };
  }

  @override
  List<Object?> get props => <Object>[publicKey, modeInfo, sequence];
}
