import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// [LegacyDerivationPathElement] is a class that represents a single element of a BIP32 derivation path.
class LegacyDerivationPathElement extends Equatable {
  static const List<String> _hardenedChars = <String>["'"];

  final bool _hardenedBool;
  final int _rawIndex;

  const LegacyDerivationPathElement({
    required bool hardenedBool,
    required int rawIndex,
  })  : _hardenedBool = hardenedBool,
        _rawIndex = rawIndex;

  /// Parses a single derivation path element which can be either a hardened or non-hardened index.
  factory LegacyDerivationPathElement.parse(String pathElement) {
    String parsedPathElement = pathElement;

    bool hardenedBool = _hardenedChars.where(parsedPathElement.endsWith).isNotEmpty;
    if (hardenedBool) {
      parsedPathElement = parsedPathElement.substring(0, pathElement.length - 1);
    }

    int? rawIndex = int.tryParse(parsedPathElement, radix: 10);
    if (rawIndex == null) {
      throw FormatException('Invalid BIP32 derivation path element ($pathElement)');
    }

    return LegacyDerivationPathElement(hardenedBool: hardenedBool, rawIndex: rawIndex);
  }

  factory LegacyDerivationPathElement.fromShiftedIndex(int shiftedIndex) {
    int rawIndex = shiftedIndex & ~(1 << 31);
    bool hardenedBool = (shiftedIndex & (1 << 31)) != 0;

    return LegacyDerivationPathElement(hardenedBool: hardenedBool, rawIndex: rawIndex);
  }

  /// Returns true if the index is hardened, false otherwise.
  bool get isHardened => _hardenedBool;

  /// Returns the raw index value.
  int get rawIndex => _rawIndex;

  /// Returns the index as a shifted integer including whether it is hardened or not.
  /// Indexes numbered between 0 and (2^31 - 1) are considered unhardened.
  /// Indexes numbered between 2^31 and (2^32 - 1) are considered hardened.
  ///
  /// This value is used in the derivation of child keys in BIP32.
  int get shiftedIndex {
    if (isHardened) {
      return _rawIndex | (1 << 31);
    } else {
      return _rawIndex & ~(1 << 31);
    }
  }

  /// Returns the index as a 32-bit unsigned integer.
  Uint8List toBytes([Endian endian = Endian.big]) {
    return Uint8List(4)..buffer.asByteData().setInt32(0, shiftedIndex, endian);
  }

  @override
  String toString() => '$_rawIndex${_hardenedBool ? _hardenedChars.first : ''}';

  @override
  List<Object?> get props => <Object>[_rawIndex, _hardenedBool];
}
