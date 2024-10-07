import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/cosmos/cosmos_auth_info.dart';
import 'package:cryptography_utils/src/transactions/cosmos/cosmos_tx_body.dart';
import 'package:equatable/equatable.dart';

/// [CosmosSignDoc] is the type used for generating sign bytes for SIGN_MODE_DIRECT
///
/// https://github.com/cosmos/cosmos-sdk/blob/main/proto/cosmos/tx/v1beta1/tx.proto#L51
class CosmosSignDoc with EquatableMixin {
  /// The processable content of the transaction.
  final CosmosTxBody txBody;

  /// The authorization related content of the transaction, specifically signers, signer modes and fee.
  final CosmosAuthInfo authInfo;

  /// The identifier of the chain this transaction targets.
  /// It prevents signed transactions from being used on another chain by an attacker.
  final String chainId;

  /// The account number of the account in state.
  final int accountNumber;

  /// Constructs a [CosmosSignDoc] with the provided values.
  CosmosSignDoc({
    required this.txBody,
    required this.authInfo,
    required this.chainId,
    required this.accountNumber,
  });

  /// Converts the object to a list of bytes compatible with Protobuf.
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: txBody,
      2: authInfo,
      3: ProtobufString(chainId),
      4: ProtobufInt32(accountNumber),
    });
  }

  /// Returns the sign bytes for SIGN_MODE_DIRECT
  Uint8List getDirectSignBytes() {
    return toProtoBytes();
  }

  @override
  List<Object?> get props => <Object?>[txBody, authInfo, chainId, accountNumber];
}
