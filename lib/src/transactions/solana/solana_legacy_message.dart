import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The transaction message includes the list of instructions to be processed atomically.
///
/// https://solana.com/docs/core/transactions#transactions
class SolanaLegacyMessage extends ASolanaTransactionMessage {
  const SolanaLegacyMessage({
    required super.header,
    required super.accountKeysList,
    required super.recentBlockhash,
    required super.compiledInstructions,
  });

  /// Creates a new instance of [SolanaLegacyMessage] from the serialized data.
  factory SolanaLegacyMessage.fromSerializedData(Uint8List data) {
    ByteReader byteReader = ByteReader(data);

    SolanaMessageHeader solanaMessageHeader = SolanaMessageHeader.fromBytes(byteReader);

    int accountsCount = CompactU16Decoder.decode(byteReader);
    List<SolanaPubKey> accountKeysList = List<SolanaPubKey>.generate(accountsCount, (_) {
      Uint8List keyUint8List = byteReader.shiftRightBy(SolanaPubKey.publicKeyLength);
      return SolanaPubKey.fromBytes(keyUint8List);
    });

    Uint8List recentBlockhash = byteReader.shiftRightBy(SolanaPubKey.publicKeyLength);

    int instructionCount = CompactU16Decoder.decode(byteReader);
    List<SolanaCompiledInstruction> instructionsList = List<SolanaCompiledInstruction>.generate(instructionCount, (_) {
      return SolanaCompiledInstruction.fromSerializedData(byteReader);
    });

    return SolanaLegacyMessage(
      header: solanaMessageHeader,
      accountKeysList: accountKeysList,
      recentBlockhash: recentBlockhash,
      compiledInstructions: instructionsList,
    );
  }

  @override
  List<Object?> get props => <Object?>[header, accountKeysList, recentBlockhash, compiledInstructions];
}
