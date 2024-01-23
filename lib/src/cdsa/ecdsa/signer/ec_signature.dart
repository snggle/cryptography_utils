import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// Class representing a digital signature in the ECDSA algorithm
class ECSignature extends Equatable implements ISignature {
  /// Part of the signature that corresponds to the x-coordinate of the ephemeral public key,
  /// serving as a representation of the signature on the elliptic curve. Typically denoted as 'r'.
  final BigInt r;

  /// Part of the signature representing the scalar component, typically denoted as 's'.
  /// Derived from the signer's private key and the hash of the message, this component serves as the proof of
  /// the signature's authenticity and the signer's agreement with the message content.
  final BigInt s;

  /// Constructs an instance of ECSignature with the specified 'r' and 's' components.
  const ECSignature({
    required this.r,
    required this.s,
  });

  /// Constructs an instance of ECSignature from a base64 string.
  factory ECSignature.fromBase64(String base64) {
    Uint8List bytes = base64Decode(base64);
    return ECSignature.fromBytes(bytes);
  }

  /// Constructs an instance of ECSignature from a byte array.
  factory ECSignature.fromBytes(Uint8List bytes) {
    int halfLength = bytes.length ~/ 2;
    Uint8List rBytes = bytes.sublist(0, halfLength);
    Uint8List sBytes = bytes.sublist(halfLength);

    BigInt r = BigIntUtils.decodeWithSign(1, rBytes);
    BigInt s = BigIntUtils.decodeWithSign(1, sBytes);

    return ECSignature(r: r, s: s);
  }

  /// Returns the signature as a base64 string.
  @override
  String get base64 {
    return base64Encode(bytes);
  }

  /// Returns the signature as a byte array.
  @override
  Uint8List get bytes {
    List<int> rBytes = BigIntUtils.changeToBytes(r);
    List<int> sBytes = BigIntUtils.changeToBytes(s);

    return Uint8List.fromList(rBytes + sBytes);
  }

  /// Returns the length of the signature.
  @override
  int get length => bytes.length;

  @override
  List<Object?> get props => <Object>[r, s];
}
