import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ASolanaMessage extends Equatable {
  final SolanaMessageHeader header;
  final List<Uint8List> accountKeysList;
  final Uint8List recentBlockhash;
  final List<SolanaInstructionRaw> solanaInstructionList;

  const ASolanaMessage({
    required this.header,
    required this.accountKeysList,
    required this.recentBlockhash,
    required this.solanaInstructionList,
  });

  static ASolanaMessage fromSerializedData(Uint8List data) {
    int firstByte = data[0];
    final bool versionedBool = (firstByte & 0x80) != 0;

    if (!versionedBool) {
      return SolanaLegacyMessage.fromSerializedData(data);
    }

    int version = firstByte & 0x7F;

    switch (version) {
      case 0:
        return SolanaV0Message.fromSerializedData(data);
      default:
        throw Exception('Solana versioned message (version $version) is not supported.');
    }
  }
}
