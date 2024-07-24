import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_mixin.dart';
import 'package:equatable/equatable.dart';

/// [CosmosTx] is the standard type used for broadcasting transactions.
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L15
class CosmosTx with ProtobufMixin, EquatableMixin {
  /// The processable content of the transaction
  final CosmosTxBody body;

  /// the authorization related content of the transaction, specifically signers, signer modes and fee
  final CosmosAuthInfo authInfo;

  /// List of signatures that matches the length and order of [CosmosAuthInfo]'s [signerInfos]
  /// to allow connecting signature meta information like public key and signing mode by position.
  final List<CosmosSignature> signatures;

  /// Constructs a [CosmosTx] with the provided body, auth info, and signatures.
  CosmosTx.signed({
    required this.body,
    required this.authInfo,
    required this.signatures,
  });

  /// Constructs a [CosmosTx] with the provided body and auth info.
  CosmosTx.unsigned({
    required this.body,
    required this.authInfo,
  }) : signatures = const <CosmosSignature>[];

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, body),
      ...ProtobufEncoder.encode(2, authInfo),
      ...ProtobufEncoder.encode(3, signatures.map((CosmosSignature e) => e.bytes).toList()),
    ]);
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'body': body.toProtoJson(),
      'auth_info': authInfo.toProtoJson(),
      'signatures': signatures.map((CosmosSignature e) => e.base64).toList(),
    };
  }

  /// Returns the transaction hash.
  String getTransactionHash() {
    return HexCodec.encode(sha256
        .convert(toProtoBytes())
        .bytes, includePrefixBool: true);
  }

  @override
  List<Object?> get props => <Object?>[body, authInfo, signatures];
}
