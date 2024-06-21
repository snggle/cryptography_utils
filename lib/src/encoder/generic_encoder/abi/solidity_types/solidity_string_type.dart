import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

class SolidityStringType extends SolidityBytesType {
  SolidityStringType() : super('string');

  @override
  String decode(List<int> encoded, int offset) {
    Uint8List strBytes = super.decode(encoded, offset) as Uint8List;
    return utf8.decode(strBytes);
  }
}
