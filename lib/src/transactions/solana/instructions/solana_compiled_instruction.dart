import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// A directive for a single invocation of a Solana program
///
/// https://solana.com/docs/core/transactions#array-of-instructions
class SolanaCompiledInstruction extends Equatable {
  /// An index that points to the program's address in the account addresses array.
  /// This specifies the program that processes the instruction.
  final int programIdIndex;

  /// An array of indexes that point to the account addresses required for this instruction.
  final Uint8List accounts;

  /// A byte array that specifies which instruction to invoke on the program and any additional data
  /// required by the instruction (eg. function arguments).
  final Uint8List data;

  const SolanaCompiledInstruction({
    required this.programIdIndex,
    required this.accounts,
    required this.data,
  });

  /// Extracts a [SolanaCompiledInstruction] from a [ByteReader] of a [SolanaLegacyMessage] or a [SolanaV0Message].
  factory SolanaCompiledInstruction.fromSerializedData(ByteReader byteReader) {
    int programId = byteReader.shiftRight();
    int accountCount = CompactU16Decoder.decode(byteReader);
    Uint8List accounts = byteReader.shiftRightBy(accountCount);
    int dataLength = CompactU16Decoder.decode(byteReader);
    Uint8List data = byteReader.shiftRightBy(dataLength);

    return SolanaCompiledInstruction(
      programIdIndex: programId,
      accounts: accounts,
      data: data,
    );
  }

  @override
  List<Object?> get props => <Object?>[programIdIndex, accounts, data];
}
