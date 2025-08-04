import 'package:codec_utils/codec_utils.dart';

class SolanaMessageHeader {
  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnsignedAccounts;

  const SolanaMessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  factory SolanaMessageHeader.fromBytes(ByteReader reader) {
    return SolanaMessageHeader(
      numRequiredSignatures: reader.shiftRight(),
      numReadonlySignedAccounts: reader.shiftRight(),
      numReadonlyUnsignedAccounts: reader.shiftRight(),
    );
  }
}
