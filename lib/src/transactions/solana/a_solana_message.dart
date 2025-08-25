import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ASolanaMessage extends Equatable {
  const ASolanaMessage();

  /// Creates a new instance of [ASolanaMessage] from serialized data,
  /// returning [SolanaRawMessage] or [ASolanaTransactionMessage] depending on [SignDataType].
  factory ASolanaMessage.fromSerializedData(SignDataType signDataType, Uint8List data) {
    switch (signDataType) {
      case SignDataType.typedTransaction:
        return ASolanaTransactionMessage.fromSerializedData(data);
      case SignDataType.rawBytes:
        return SolanaRawMessage.fromSerializedData(data);
    }
  }

  String? get message => null;
}
