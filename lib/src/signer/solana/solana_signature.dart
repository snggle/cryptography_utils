import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Represents a Solana digital signature.
class SolanaSignature extends ASignature {
  /// The standard length of Solana signatures.
  static const int solSignatureLength = 64;

  final Uint8List r;
  final Uint8List s;

  const SolanaSignature({required this.r, required this.s});

  factory SolanaSignature.fromBytes(List<int> bytes) {
    if (bytes.length != solSignatureLength) {
      throw const FormatException('Invalid signature bytes');
    }

    Uint8List r = Uint8List.fromList(bytes.sublist(0, 32));
    Uint8List s = Uint8List.fromList(bytes.sublist(32, 64));
    return SolanaSignature(r: r, s: s);
  }


  @override
  Uint8List get bytes => Uint8List.fromList(r + s);

  @override
  List<Object?> get props => <Object?>[r, s];
}