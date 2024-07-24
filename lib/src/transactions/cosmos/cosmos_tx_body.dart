import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_any.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_encoder.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_mixin.dart';
import 'package:equatable/equatable.dart';

/// [CosmosTxBody] is the body of a transaction that all signers sign over.
class CosmosTxBody with ProtobufMixin, EquatableMixin {
  /// List of messages to be executed. The required signers of those messages define the number and order
  /// of elements in [CosmosAuthInfo]'s [signerInfos] and [CosmosTx]'s signatures. Each required signer address is added to
  /// the list only the first time it occurs. By convention, the first required signer (usually from the first message)
  /// is referred to as the primary signer and pays the fee for the whole transaction.
  ///
  /// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L95
  final List<ProtobufAny> messages;

  /// Defines any arbitrary note/comment to be added to the transaction.
  /// WARNING: in clients, any publicly exposed text should not be called memo,
  /// but should be called `note` instead (see https://github.com/cosmos/cosmos-sdk/issues/9122).
  final String memo;

  /// Defines the block height after which this transaction will not be processed by the chain.
  /// Note, if unordered=true this value MUST be set and will act as a short-lived TTL
  /// in which the transaction is deemed valid and kept in memory to prevent duplicates.
  final BigInt timeoutHeight;

  /// When set to true, indicates that the transaction signer(s)intend for the transaction
  /// to be evaluated and executed in an un-ordered fashion. Specifically, the account's nonce will NOT be checked or
  /// incremented, which allows for fire-and-forget as well as concurrent transaction execution.
  ///
  /// Note, when set to true, the existing 'timeout_height' value must be set and will be used
  /// to correspond to a height in which the transaction is deemed valid.
  final bool unordered;

  /// Arbitrary options that can be added by chains when the default options are not sufficient.
  /// If any of these are present and can't be handled, the transaction will be rejected
  final List<ProtobufAny> extensionOptions;

  /// Arbitrary options that can be added by chains when the default options are not sufficient.
  /// If any of these are present and can't be handled, they will be ignored
  final List<ProtobufAny> nonCriticalExtensionOptions;

  /// Constructs a [CosmosTxBody] with the provided messages, memo, timeout height, extension options, and non-critical extension options.
  CosmosTxBody({
    required this.messages,
    this.memo = '',
    this.unordered = false,
    BigInt? timeoutHeight,
    List<ProtobufAny>? extensionOptions,
    List<ProtobufAny>? nonCriticalExtensionOptions,
  })
      : timeoutHeight = timeoutHeight ?? BigInt.zero,
        extensionOptions = extensionOptions ?? <ProtobufAny>[],
        nonCriticalExtensionOptions = nonCriticalExtensionOptions ?? <ProtobufAny>[];

  /// Converts the object to a list of bytes compatible with Protobuf.
  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, messages),
      if (memo.isNotEmpty) ...ProtobufEncoder.encode(2, memo),
      if (timeoutHeight != BigInt.zero) ...ProtobufEncoder.encode(3, timeoutHeight),
      if (unordered == true) ...ProtobufEncoder.encode(4, unordered),
      if (extensionOptions.isNotEmpty == true) ...ProtobufEncoder.encode(1023, extensionOptions),
      if (nonCriticalExtensionOptions.isNotEmpty == true) ...ProtobufEncoder.encode(2047, nonCriticalExtensionOptions),
    ]);
  }

  /// Converts the object to a JSON object compatible with Protobuf.
  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'messages': messages.map((ProtobufAny e) => e.toProtoJson()).toList(),
      'memo': memo,
      'timeout_height': timeoutHeight.toString(),
      if (unordered == true) 'unordered': unordered,
      'extension_options': extensionOptions.map((ProtobufAny e) => e.toProtoJson()).toList(),
      'non_critical_extension_options': nonCriticalExtensionOptions.map((ProtobufAny e) => e.toProtoJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object>[messages, memo, timeoutHeight, unordered, extensionOptions, nonCriticalExtensionOptions];
}
