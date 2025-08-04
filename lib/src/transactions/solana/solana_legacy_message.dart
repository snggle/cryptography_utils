import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class SolanaLegacyMessage extends ASolanaMessage {

  const SolanaLegacyMessage({
    required super.header,
    required super.accountKeysList,
    required super.recentBlockhash,
    required super.solanaInstructionList,
  });

  factory SolanaLegacyMessage.fromSerializedData(Uint8List data) {
    int publicKeyLength = 32;

    ByteReader reader = ByteReader(data);
    SolanaMessageHeader header = SolanaMessageHeader.fromBytes(reader);

    int accountsCount = CompactU16Decoder.decode(reader);

    List<Uint8List> accountKeys = List<Uint8List>.generate(accountsCount, (_) {
      Uint8List key = reader.shiftRightBy(publicKeyLength);
      return Uint8List.fromList(key);
    });

    Uint8List recentBlockhash = reader.shiftRightBy(publicKeyLength);
    int instructionCount = CompactU16Decoder.decode(reader);

    List<SolanaInstructionRaw> instructions = List<SolanaInstructionRaw>.generate(instructionCount, (_) {
      return SolanaInstructionRaw.fromSerializedData(reader);
    });

    return SolanaLegacyMessage(
      header: header,
      accountKeysList: accountKeys,
      recentBlockhash: recentBlockhash,
      solanaInstructionList: instructions,
    );
  }

  @override
  List<Object?> get props => <Object?>[header, accountKeysList, recentBlockhash, solanaInstructionList];
}
