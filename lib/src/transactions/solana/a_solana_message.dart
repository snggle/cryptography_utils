import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';

abstract class ASolanaMessage {
  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnsignedAccounts;
  final List<Uint8List> accountKeysList;
  final Uint8List recentBlockhash;
  final List<SolanaInstruction> solanaInstructionList;

  ASolanaMessage({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
    required this.accountKeysList,
    required this.recentBlockhash,
    required this.solanaInstructionList,
  });

  @override
  String toString() => toJson().toString();

  static ASolanaMessage fromSerializedData(Uint8List data) {
    int firstByte = data[0];
    final bool isVersionedBool = (firstByte & 0x80) != 0;

    if (!isVersionedBool) {
      return SolanaLegacyMessage.fromSerializedData(data);
    }

    int version = firstByte & 0x7F;

    switch (version) {
      case 0:
        return SolanaV0Message.fromSerializedData(data);
      default:
        throw UnimplementedError('Solana versioned message (version $version) is not supported.');
    }
  }

  Map<String, dynamic> toJson();
}
