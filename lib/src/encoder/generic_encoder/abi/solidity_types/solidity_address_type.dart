import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

class SolidityAddressType extends SolidityIntType {
  SolidityAddressType() : super('address');

  @override
  String decode(List<int> encoded, int offset) {
    BigInt addressNumber = BigInt.parse(super.decode(encoded, offset) as String);
    Uint8List addressBytes = BigIntUtils.changeToBytes(addressNumber, length: 20);
    return '0x${HexEncoder.encode(addressBytes)}';
  }
}