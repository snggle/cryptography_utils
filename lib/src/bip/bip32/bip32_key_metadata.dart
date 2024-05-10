import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// Represents the metadata associated with a key in a BIP-32 hierarchical deterministic wallet.
/// This class holds the necessary components used in the derivation of child keys within an HD wallet structure.
class Bip32KeyMetadata extends Equatable {
  /// The number of derivations from the master root key to this key, indicating its level in the hierarchy.
  final int depth;

  /// A 256-bit (32 bytes) value acting as a component of BIP-32 private key.
  /// It's used in conjunction with [ECPrivateKey] or [ECPublicKey] for generating child private keys.
  final Uint8List chainCode;

  /// The unique identifier derived from the hash of the ECDSA public key, representing this key in the hierarchy.
  final BigInt fingerprint;

  /// The unique identifier for this key's direct parent, derived same way as [fingerprint].
  final BigInt parentFingerprint;

  /// The identifier for the root from which all keys in this hierarchy are derived.
  final BigInt masterFingerprint;

  /// The derivation path index in its shifted form. Is null for the master key.
  final int? shiftedIndex;

  /// Creates a new instance of [Bip32KeyMetadata] with the specified parameters.
  const Bip32KeyMetadata({
    required this.depth,
    required this.chainCode,
    required this.fingerprint,
    required this.parentFingerprint,
    required this.masterFingerprint,
    this.shiftedIndex,
  });

  @override
  List<Object?> get props => <Object?>[depth, chainCode, fingerprint, parentFingerprint, masterFingerprint, shiftedIndex];
}
