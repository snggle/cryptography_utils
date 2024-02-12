import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/substrate/substrate_scale_encoder.dart';
import 'package:equatable/equatable.dart';

/// Represents a single element within a Substrate derivation path, encapsulating both soft and hard key derivations
/// Each element in the path can represent:
/// - soft derivation: (indicated by a single `/`),
/// - hard derivation (indicated by `//`),
/// This class models such an element, providing a structured way to interact with individual parts of a derivation path.
class SubstrateDerivationPathElement extends Equatable {
  final bool hardenedBool;
  final Uint8List id;

  const SubstrateDerivationPathElement({
    required this.hardenedBool,
    required this.id,
  });

  /// Parses a single element from a string representation of a Substrate derivation path
  factory SubstrateDerivationPathElement.fromString(String element) {
    final bool hardenedBool;
    final String code;

    if (element.startsWith('/')) {
      hardenedBool = true;
      code = element.substring(1);
    } else {
      hardenedBool = false;
      code = element;
    }

    BigInt? n = BigInt.tryParse(code, radix: 10);
    Uint8List bytes;
    if (n != null && n >= BigInt.zero && n < BigInt.parse('18446744073709551616')) {
      bytes = SubstrateScaleEncoder.encodeUInt(n);
    } else {
      bytes = SubstrateScaleEncoder.encodeString(code);
    }

    return SubstrateDerivationPathElement.fromBytes(hardenedBool: hardenedBool, bytes: bytes);
  }

  /// Parses a single element from a byte representation of a Substrate derivation path
  factory SubstrateDerivationPathElement.fromBytes({
    required bool hardenedBool,
    required Uint8List bytes,
  }) {
    Uint8List tmpBytes = Uint8List(32);
    if (bytes.length > 32) {
      tmpBytes = Blake2d(digestSize: 32).process(bytes);
    } else {
      tmpBytes.setAll(0, bytes);
    }
    return SubstrateDerivationPathElement(hardenedBool: hardenedBool, id: tmpBytes);
  }

  @override
  List<Object?> get props => <Object?>[hardenedBool, id];
}
