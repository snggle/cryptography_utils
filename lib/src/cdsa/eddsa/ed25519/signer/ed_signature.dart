import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Class representing a digital signature in the EdDSA algorithm
class EDSignature extends ASignature {
  /// The part of the signature representing the point on the Edwards curve, typically denoted as 'R'.
  /// This is a unique identifier for the signature, generated as part of the signing process.
  final Uint8List r;

  /// The part of the signature representing the scalar component, typically denoted as 'S'.
  /// This value is computed from the signer's private key, the message's hash, and the point 'R',
  /// serving as the proof of the signature's authenticity and integrity.
  final Uint8List s;

  /// Constructs an instance of ECSignature with the specified 'r' and 's' components.
  const EDSignature({
    required this.r,
    required this.s,
  });

  /// Constructs an instance of ECSignature from a base64 string.
  factory EDSignature.fromBase64(String base64) {
    Uint8List bytes = base64Decode(base64);
    return EDSignature.fromBytes(bytes);
  }

  /// Constructs an instance of ECSignature from a byte array.
  factory EDSignature.fromBytes(Uint8List bytes) {
    return EDSignature(
      r: bytes.sublist(0, 32),
      s: bytes.sublist(32, 64),
    );
  }

  /// Returns the signature as a byte array.
  @override
  Uint8List get bytes {
    return Uint8List.fromList(r + s);
  }

  /// Returns the length of the signature.
  @override
  int get length => r.length + s.length;

  @override
  List<Object?> get props => <Object?>[r, s];
}
