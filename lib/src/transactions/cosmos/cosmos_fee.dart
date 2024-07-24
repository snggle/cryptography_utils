import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_mixin.dart';
import 'package:cryptography_utils/src/transactions/cosmos/cosmos_coin.dart';
import 'package:equatable/equatable.dart';

/// [CosmosFee] includes the amount of coins paid in fees and the maximum gas to be used by the transaction.
/// The ratio yields an effective "gasprice", which must be above some minimum to be accepted into the mempool.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L214
class CosmosFee with ProtobufMixin, EquatableMixin {
  /// The amount of coins to be paid as a fee
  final List<CosmosCoin> amount;

  /// The maximum gas that can be used in transaction processing before an out of gas error occurs
  final BigInt gasLimit;

  /// The payer of the fee, if specified. If unset, the first signer is responsible for paying the fees.
  /// If set, the specified account must pay the fees. The payer must be a tx signer (and thus have signed this field in AuthInfo).
  /// Setting this field does *not* change the ordering of required signers for the transaction.
  final String? payer;

  /// The granter of the fee, if specified. If set, the fee payer (either the first signer or the value of the payer field) requests
  /// that a fee grant be used to pay fees instead of the fee payer's own balance.
  /// If an appropriate fee grant does not exist or the chain does not support fee grants, this will fail.
  final String? granter;

  /// Constructs a [CosmosFee] with the provided amount, gas limit, payer, and granter.
  CosmosFee({
    required this.gasLimit,
    required this.amount,
    this.payer,
    this.granter,
  });

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, amount.toProtoBytes()),
      ...ProtobufEncoder.encode(2, gasLimit),
      ...ProtobufEncoder.encode(3, payer),
      ...ProtobufEncoder.encode(4, granter),
    ]);
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'gas_limit': gasLimit.toString(),
      'amount': amount.map((CosmosCoin e) => e.toProtoJson()).toList(),
      'payer': payer,
      'granter': granter,
    };
  }

  @override
  List<Object?> get props => <Object?>[amount, gasLimit, payer, granter];
}
