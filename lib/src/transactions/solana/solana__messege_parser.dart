import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

class SolanaMessageParser {
  Object parseSolanaMessage(SignDataType signDataType, Uint8List data) {
    switch (signDataType) {
      case SignDataType.typedTransaction:
        // Legacy format by default for typed transactions
        return SolanaLegacyMessage.fromSerializedData(data);
      case SignDataType.rawBytes:
        // Try V0 first; if decoding fails, treat as raw message bytes
        try {
          return SolanaV0Message.fromSerializedData(data);
        } catch (_) {
          return SolanaRawMessage.fromSerializedData(data);
        }
    }
  }
}
