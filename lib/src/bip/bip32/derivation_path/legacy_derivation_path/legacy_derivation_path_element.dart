import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// [LegacyDerivationPathElement] is a class that represents a single element of a BIP32 derivation path.
class LegacyDerivationPathElement extends Equatable {
  static const List<String> _hardenedChars = <String>["'"];

  final int index;
  final String value;
  final bool _hardenedBool;

  const LegacyDerivationPathElement({
    required bool hardenedBool,
    required this.index,
    required this.value,
  }) : _hardenedBool = hardenedBool;

  /// Parses a single derivation path element which can be either a hardened or non-hardened index.
  factory LegacyDerivationPathElement.parse(String pathElement) {
    String parsedPathElement = pathElement;

    bool hardenedBool = _hardenedChars.where(parsedPathElement.endsWith).isNotEmpty;
    if (hardenedBool) {
      parsedPathElement = parsedPathElement.substring(0, pathElement.length - 1);
    }

    int? index = int.tryParse(parsedPathElement, radix: 10);
    if (index == null) {
      throw FormatException('Invalid BIP32 derivation path element ($pathElement)');
    } else if (hardenedBool) {
      index = index | (1 << 31);
    } else {
      index = index & ~(1 << 31);
    }

    return LegacyDerivationPathElement(
      hardenedBool: hardenedBool,
      index: index,
      value: pathElement,
    );
  }

  /// Returns true if the index is hardened, false otherwise.
  bool get isHardened => _hardenedBool;

  /// Returns the index as a 32-bit unsigned integer.
  Uint8List toBytes() {
    return Uint8List(4)..buffer.asByteData().setInt32(0, index, Endian.big);
  }

  @override
  String toString() => value;

  @override
  List<Object?> get props => <Object>[value, index, _hardenedBool];
}
