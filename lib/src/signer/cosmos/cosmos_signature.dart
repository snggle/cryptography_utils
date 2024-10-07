import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';

/// Represents a Cosmos digital signature, encapsulating the typical components of an ECDSA signature used in Cosmos transactions.
class CosmosSignature extends ASignature {
  /// Part of the signature that corresponds to the x-coordinate of the ephemeral public key,
  /// serving as a representation of the signature on the elliptic curve. Typically denoted as 'r'.
  final BigInt r;

  /// Part of the signature representing the scalar component, typically denoted as 's'.
  /// Derived from the signer's private key and the hash of the message, this component serves as the proof of
  /// the signature's authenticity and the signer's agreement with the message content.
  final BigInt s;

  /// Constructs an instance of [CosmosSignature] with the specified [s] and [r] components.
  const CosmosSignature({
    required this.r,
    required this.s,
  });

  /// Returns new [CosmosSignature] instance with the overridden values.
  @override
  Uint8List get bytes {
    List<int> rBytes = BigIntUtils.changeToBytes(r, length: 32);
    List<int> sBytes = BigIntUtils.changeToBytes(s, length: 32);

    return Uint8List.fromList(rBytes + sBytes);
  }

  @override
  List<Object?> get props => <Object>[r, s];
}
