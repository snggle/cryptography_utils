import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// The message header specifies the permissions for the account in the transaction.
/// It works in combination with the strictly ordered account addresses to determine which accounts are signers and which are writable.
///
/// https://solana.com/docs/core/transactions#message-header
class SolanaMessageHeader extends Equatable {
  /// The number of signatures required for all instructions on the transaction.
  final int numRequiredSignatures;

  /// The number of signed accounts that are read-only.
  final int numReadonlySignedAccounts;

  /// The number of unsigned accounts that are read-only.
  final int numReadonlyUnsignedAccounts;

  const SolanaMessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  /// Extracts a [SolanaMessageHeader] from a [ByteReader] of a [SolanaLegacyMessage] or a [SolanaV0Message].
  factory SolanaMessageHeader.fromBytes(ByteReader reader) {
    return SolanaMessageHeader(
      numRequiredSignatures: reader.shiftRight(),
      numReadonlySignedAccounts: reader.shiftRight(),
      numReadonlyUnsignedAccounts: reader.shiftRight(),
    );
  }

  @override
  List<Object?> get props => <Object?>[numRequiredSignatures, numReadonlySignedAccounts, numReadonlyUnsignedAccounts];
}
