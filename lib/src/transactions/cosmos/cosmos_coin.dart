import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';

/// [CosmosCoin] defines a token with a denomination and an amount.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/base/v1beta1/coin.proto
class CosmosCoin extends AProtobufObject {
  /// Denomination of the token
  final String denom;

  /// Amount of the token
  final BigInt amount;

  /// Constructs a [CosmosCoin] with the provided denomination and amount.
  CosmosCoin({
    required this.denom,
    required this.amount,
  });

  /// Creates a [CosmosCoin] from the provided proto JSON.
  factory CosmosCoin.fromProtoJson(Map<String, dynamic> data) {
    return CosmosCoin(
      denom: data['denom'] as String,
      amount: BigInt.parse(data['amount'] as String),
    );
  }

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: ProtobufString(denom),
      2: ProtobufString(amount.toString()),
    });
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'denom': denom,
      'amount': amount.toString(),
    };
  }

  @override
  String toString() {
    return '$amount$denom';
  }

  @override
  List<Object?> get props => <Object?>[denom, amount];
}
