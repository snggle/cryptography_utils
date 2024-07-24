import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_any.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';

class TestMsgSend extends ProtobufAny {
  final String fromAddress;
  final String toAddress;
  final List<CosmosCoin> amount;

  TestMsgSend({
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
  }) : super(typeUrl: '/cosmos.bank.v1beta1.MsgSend');

  factory TestMsgSend.fromData(Map<String, dynamic> data) {
    return TestMsgSend(
      fromAddress: data['from_address'] as String,
      toAddress: data['to_address'] as String,
      amount: (data['amount'] as List<dynamic>).map((dynamic e) => CosmosCoin.fromProtoJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, fromAddress),
      ...ProtobufEncoder.encode(2, toAddress),
      ...ProtobufEncoder.encode(3, amount),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'from_address': fromAddress,
      'to_address': toAddress,
      'amount': amount.map((CosmosCoin cosmosCoin) => cosmosCoin.toProtoJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object>[fromAddress, toAddress, amount];
}
