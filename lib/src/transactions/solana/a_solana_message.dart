import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';

abstract class ASolanaMessage {
  int get numRequiredSignatures;
  int get numReadonlySignedAccounts;
  int get numReadonlyUnsignedAccounts;
  List<Uint8List> get accountKeys;
  Uint8List get recentBlockhash;
  List<SolanaInstruction> get instructions;

  static ASolanaMessage fromSerializedData(Uint8List data) {
    int firstByte = data[0];
    final bool isVersioned = (firstByte & 0x80) != 0;

    if (!isVersioned) {
      return SolanaLegacyMessage.fromBytes(data);
    }

    int version = firstByte & 0x7F;

    switch (version) {
      case 0:
        return SolanaV0Message.fromBytes(data);
      default:
        throw UnimplementedError('Solana versioned message (version $version) is not supported.');
    }
  }


  Map<String, dynamic> toJson();
  @override
  String toString() => toJson().toString();
}
