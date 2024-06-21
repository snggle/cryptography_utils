import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';

/// Dart representation of the Solidity's dynamic int/uint type used in the ABI (Application Binary Interface) encoding.
/// - uint<M>: unsigned integer type of M bits, 0 < M <= 256, M % 8 == 0. e.g. uint32, uint8, uint256
/// - int<M>: two’s complement signed integer type of M bits, 0 < M <= 256, M % 8 == 0.
/// - uint, int: synonyms for uint256, int256 respectively. For computing the function selector, uint256 and int256 have to be used
///
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityIntType extends ASolidityType {
  SolidityIntType(String name) : super(name);

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  static BigInt decodeInt(List<int> encoded, int offset) {
    return BigIntUtils.decode(encoded.sublist(offset, min(offset + ASolidityType.segmentBytesSize, encoded.length)));
  }

  /// Returns the canonical name of the Solidity type.
  @override
  String get canonicalName {
    if (name == 'int') {
      return 'int256';
    } else if (name == 'uint') {
      return 'uint256';
    }
    return super.canonicalName;
  }

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  Object decode(List<int> encoded, int offset) {
    return decodeInt(encoded, offset).toString();
  }
}
