import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Represents a Solana digital signature, encapsulating the typical components of an EDDSA signature used in Solana transactions.
class SolanaSignature extends ASignature {
  /// The standard length of Solana signatures.
  static const int solSignatureLength = 64;

  /// The [r] value of the EDDSA signature, representing one half of the digital signature.
  final Uint8List r;
  /// The [s] value of the EDDSA signature, representing the other half of the digital signature.
  final Uint8List s;

  /// Constructs an instance of [SolanaSignature] with the specified [r] and [s] components.
  const SolanaSignature({required this.r, required this.s});

  /// Constructs an instance of [SolanaSignature] from a byte array.
  factory SolanaSignature.fromBytes(Uint8List bytes) {
    if (bytes.length != solSignatureLength) {
      throw const FormatException('Invalid signature bytes');
    }

    Uint8List r = bytes.sublist(0, 32);
    Uint8List s = bytes.sublist(32, 64);
    return SolanaSignature(r: r, s: s);
  }

  /// Gets the byte representation of the 'r' and 's' components.
  @override
  Uint8List get bytes => Uint8List.fromList(r + s);

  @override
  List<Object?> get props => <Object?>[r, s];
}