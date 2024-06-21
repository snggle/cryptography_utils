import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_int_type.dart';

/// Dart representation of the Solidity's [address] type used in the ABI (Application Binary Interface) encoding.
///
/// Equivalent to uint160, except for the assumed interpretation and language typing. For computing the function selector, address is used.
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityAddressType extends SolidityIntType {
  SolidityAddressType() : super('address');

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  String decode(List<int> encoded, int offset) {
    BigInt addressNumber = BigInt.parse(super.decode(encoded, offset) as String);
    Uint8List addressBytes = BigIntUtils.changeToBytes(addressNumber, length: 20);
    return '0x${HexEncoder.encode(addressBytes)}';
  }
}
