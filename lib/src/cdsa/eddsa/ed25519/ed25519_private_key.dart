import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// [ED25519PrivateKey] represents [EDPrivateKey] constructed with specific Curve (ED25519) and chain code.
class ED25519PrivateKey extends Equatable implements IBip32PrivateKey {
  /// EdDSA Private key used for cryptographic operations, following the Ed25519 curve specification.
  final EDPrivateKey edPrivateKey;

  /// A 256-bit (32 bytes) value acting as a component of BIP-32 private key.
  /// It's used in conjunction with [ecPrivateKey] for generating child private keys.
  final Uint8List _chainCode;

  ED25519PrivateKey({
    required this.edPrivateKey,
    Uint8List? chainCode,
  }) : _chainCode = chainCode ?? Uint8List(0);

  /// Returns the private key as a byte array.
  @override
  Uint8List get bytes {
    return Uint8List.fromList(edPrivateKey.bytes);
  }

  /// Returns the chain code.
  @override
  Uint8List get chainCode => _chainCode;

  /// Returns the length of the private key.
  @override
  int get length => 32;

  /// Returns the public key derived from the private key.
  @override
  ED25519PublicKey get publicKey {
    return ED25519PublicKey(edPublicKey: edPrivateKey.edPublicKey);
  }

  @override
  List<Object?> get props => <Object>[edPrivateKey, _chainCode];
}
