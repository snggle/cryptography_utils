import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// [Secp256k1PrivateKey] represents [ECPrivateKey] constructed with specific Curve (secp256k1) and chain code.
class Secp256k1PrivateKey extends Equatable implements IBip32PrivateKey {
  /// ECDSA Private key used for cryptographic operations, following the secp256k1 curve specification.
  final ECPrivateKey ecPrivateKey;

  /// A 256-bit (32 bytes) value acting as a component of BIP-32 private key.
  /// It's used in conjunction with [ecPrivateKey] for generating child private keys.
  final Uint8List _chainCode;

  const Secp256k1PrivateKey({
    required this.ecPrivateKey,
    required Uint8List chainCode,
  }) : _chainCode = chainCode;

  /// Returns the private key as a byte array.
  @override
  Uint8List get bytes => ecPrivateKey.bytes;

  /// Returns the chain code.
  @override
  Uint8List get chainCode => _chainCode;

  /// Returns the length of the private key.
  @override
  int get length => ECPrivateKey.length;

  /// Returns the public key derived from the private key.
  @override
  Secp256k1PublicKey get publicKey {
    return Secp256k1PublicKey(ecPublicKey: ecPrivateKey.ecPublicKey);
  }

  @override
  List<Object?> get props => <Object>[ecPrivateKey, _chainCode];
}
