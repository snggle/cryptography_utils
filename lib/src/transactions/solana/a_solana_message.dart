import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ASolanaMessage extends Equatable {
  const ASolanaMessage();

  /// Creates a new instance of [ASolanaMessage] from serialized data,
  /// returning [SolanaRawMessage] or [ASolanaTransactionMessage] depending on [SolanaSignDataType].
  factory ASolanaMessage.fromSerializedData(SolanaSignDataType solanaSignDataType, Uint8List data) {
    switch (solanaSignDataType) {
      case SolanaSignDataType.transaction:
        return ASolanaTransactionMessage.fromSerializedData(data);
      case SolanaSignDataType.message:
        return SolanaRawMessage.fromSerializedData(data);
    }
  }

  String? get message => null;
}
