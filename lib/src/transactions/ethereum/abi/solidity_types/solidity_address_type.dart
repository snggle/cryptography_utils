import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_int_type.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';

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
    return HexCodec.encode(addressBytes, includePrefixBool: true);
  }
}
