import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/cosmos/cosmos_fee.dart';
import 'package:cryptography_utils/src/transactions/cosmos/cosmos_signer_info.dart';

/// [CosmosAuthInfo] describes the fee and signer modes that are used to sign a transaction.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L148
class CosmosAuthInfo extends AProtobufObject {
  /// Defines the signing modes for the required signers.
  /// The number and order of elements must match the required signers from TxBody's messages.
  /// The first element is the primary signer and the one which pays the fee.
  final List<CosmosSignerInfo> signerInfos;

  /// Defines the fee and gas limit for the transaction. The first signer is the
  /// primary signer and the one which pays the fee. The fee can be calculated
  /// based on the cost of evaluating the body and doing signature verification
  /// of the signers. This can be estimated via simulation.
  final CosmosFee fee;

  /// Constructs an [CosmosAuthInfo] with the provided signer infos and fee.
  const CosmosAuthInfo({
    required this.signerInfos,
    required this.fee,
  });

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: ProtobufList(signerInfos),
      2: fee,
    });
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'signer_infos': signerInfos.map((CosmosSignerInfo e) => e.toProtoJson()).toList(),
      'fee': fee.toProtoJson(),
    };
  }

  @override
  List<Object?> get props => <Object?>[signerInfos, fee];
}
