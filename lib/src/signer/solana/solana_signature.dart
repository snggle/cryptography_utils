import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Represents a Solana digital signature.
class SolanaSignature extends ASignature {
  /// The standard length of Solana signatures.
  static const int solSignatureLength = 64;

  final Uint8List signatureBytes;

  SolanaSignature(this.signatureBytes) {
    if (bytes.length != solSignatureLength) {
      throw const FormatException('Invalid signature bytes');
    }
  }
  @override
  Uint8List get bytes => Uint8List.fromList(signatureBytes);

  factory SolanaSignature.fromBytes(List<int> bytes) {
    return SolanaSignature(Uint8List.fromList(bytes));
  }

  SolanaSignature copyWith({Uint8List? signatureBytes}) {
    return SolanaSignature(signatureBytes ?? this.signatureBytes);
  }

  @override
  List<Object?> get props => <Object?>[signatureBytes];

  /*@override
  int get hashCode => const ListEquality<int>().hash(_bytes) ^ publicKey.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolanaSignature &&
          runtimeType == other.runtimeType &&
          const ListEquality<int>().equals(_bytes, other._bytes) &&
          publicKey == other.publicKey;

  @override
  String toString() => 'SolanaSignature(bytes: $_bytes, publicKey: $publicKey)';*/
}
