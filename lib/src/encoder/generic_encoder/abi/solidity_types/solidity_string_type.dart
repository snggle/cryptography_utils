import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_bytes_type.dart';

/// Dart representation of the Solidity's [string] type used in the ABI (Application Binary Interface) encoding.
/// Dynamic sized unicode string assumed to be UTF-8 encoded
///
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityStringType extends SolidityBytesType {
  SolidityStringType() : super('string');

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  String decode(List<int> encoded, int offset) {
    Uint8List stringBytes = super.decode(encoded, offset) as Uint8List;
    return utf8.decode(stringBytes);
  }

  /// Indicates whether the Solidity type has a dynamic size.
  @override
  bool get hasDynamicSize => true;
}
