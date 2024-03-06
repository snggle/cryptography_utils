import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

class BytesUtils {
  static Uint8List changeToOctetsWithOrderPadding(List<int> data, BigInt padding) {
    BigInt z1 = BigIntUtils.decode(data, bitLength: padding.bitLength);
    BigInt z2 = z1 - padding;
    if (z2 < BigInt.zero) {
      z2 = z1;
    }
    List<int> bytes = BigIntUtils.changeToBytes(z2, length: padding.bitLength ~/ 8);
    return Uint8List.fromList(bytes);
  }
}
