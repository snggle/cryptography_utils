import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Class representing a Schnorr digital signature in the ECDSA-SR25519 algorithm
class SRSignature extends ASignature {
  /// The part of the signature representing the random point on the elliptic curve, typically denoted as 'r'.
  final Uint8List r;

  /// The part of the signature representing the scalar component, typically denoted as 's'.
  /// Derived from the signer's private key and the hash of the message, this component serves as the proof of
  /// the signature's authenticity and the signer's agreement with the message content.
  final Uint8List s;

  /// Constructs an instance of SRSignature with the specified 'r' and 's' components.
  const SRSignature({
    required this.r,
    required this.s,
  });

  /// Constructs an instance of SRSignature from a base64 string.
  factory SRSignature.fromBase64(String base64) {
    Uint8List bytes = base64Decode(base64);
    return SRSignature.fromBytes(bytes);
  }

  /// Constructs an instance of SRSignature from a byte array.
  factory SRSignature.fromBytes(Uint8List bytes) {
    Uint8List cp = Uint8List.fromList(bytes.toList());
    Uint8List r = Uint8List.fromList(cp.sublist(0, 32));
    cp[63] &= 127;
    Uint8List s = Uint8List.fromList(cp.sublist(32, 64));
    return SRSignature(r: r, s: s);
  }

  /// Returns the signature as a byte array.
  @override
  Uint8List get bytes {
    Uint8List out = Uint8List(64)
      ..setRange(0, 32, r)
      ..setRange(32, 64, s);
    out[63] |= 128;
    return out;
  }

  @override
  List<Object?> get props => <Object>[r, s];
}
