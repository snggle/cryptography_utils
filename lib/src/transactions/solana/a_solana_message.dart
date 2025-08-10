import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ASolanaMessage extends Equatable {
  final SolanaMessageHeader header;

  /// list of all account addresses required by its instructions.
  /// The array starts with a compact-u16 number indicating how many addresses it contains.
  /// https://solana.com/docs/core/transactions#array-of-account-addresses
  final List<SolanaPubKey> accountKeysList;

  /// Every transaction requires a recent blockhash that serves two purposes:
  ///
  /// Acts as a timestamp for when the transaction was created
  /// Prevents duplicate transactions
  /// A blockhash expires after 150 blocks (about 1 minute assuming 400ms block times),
  /// after which the transaction is considered expired and cannot be processed.
  /// https://solana.com/docs/core/transactions#recent-blockhash
  final Uint8List recentBlockhash;

  /// An array of instructions in the CompiledInstruction type. It starts with a compact-u16 length followed by the instruction data.
  /// https://solana.com/docs/core/transactions#array-of-instructions
  final List<SolanaCompiledInstruction> compiledInstructions;

  const ASolanaMessage({
    required this.header,
    required this.accountKeysList,
    required this.recentBlockhash,
    required this.compiledInstructions,
  });

  /// Creates a new instance of [ASolanaMessage] from the serialized data,
  /// returning [SolanaLegacyMessage] or [SolanaV0Message] depending on the detected version.
  static ASolanaMessage fromSerializedData(Uint8List data) {
    int firstByte = data[0];
    bool versionedBool = (firstByte & 0x80) != 0;
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

  List<ASolanaInstructionDecoded> get decodedInstructions {
    List<SolanaPubKey> accountKeyBytes = accountKeysList.map((SolanaPubKey solanaPubKey) => solanaPubKey).toList(growable: false);
    return compiledInstructions
        .map((SolanaCompiledInstruction solanaCompiledInstruction) => ASolanaInstructionDecoded.decode(solanaCompiledInstruction, accountKeyBytes))
        .toList(growable: false);
  }
}
