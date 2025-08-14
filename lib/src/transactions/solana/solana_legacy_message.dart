import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The transaction message includes the list of instructions to be processed atomically.
///
/// https://solana.com/docs/core/transactions#transactions
class SolanaLegacyMessage extends ASolanaMessage {
  const SolanaLegacyMessage({
    required super.header,
    required super.accountKeysList,
    required super.recentBlockhash,
    required super.compiledInstructions,
  });

  /// Creates a new instance of [SolanaLegacyMessage] from the serialized data.
  factory SolanaLegacyMessage.fromSerializedData(Uint8List data) {
    ByteReader reader = ByteReader(data);

    SolanaMessageHeader header = SolanaMessageHeader.fromBytes(reader);

    int accountsCount = CompactU16Decoder.decode(reader);
    List<SolanaPubKey> accountKeysList = List<SolanaPubKey>.generate(accountsCount, (_) {
      Uint8List key = reader.shiftRightBy(SolanaPubKey.publicKeyLength);
      return SolanaPubKey.fromBytes(Uint8List.fromList(key));
    });

    Uint8List recentBlockhash = reader.shiftRightBy(SolanaPubKey.publicKeyLength);

    int instructionCount = CompactU16Decoder.decode(reader);
    List<SolanaCompiledInstruction> instructions = List<SolanaCompiledInstruction>.generate(instructionCount, (_) {
      return SolanaCompiledInstruction.fromSerializedData(reader);
    });

    return SolanaLegacyMessage(
      header: header,
      accountKeysList: accountKeysList,
      recentBlockhash: recentBlockhash,
      compiledInstructions: instructions,
    );
  }

  @override
  List<Object?> get props => <Object?>[header, accountKeysList, recentBlockhash, compiledInstructions];
}
