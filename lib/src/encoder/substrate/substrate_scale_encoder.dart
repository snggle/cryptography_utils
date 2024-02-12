import 'dart:typed_data';

import 'package:cryptography_utils/src/utils/big_int_utils.dart';

/// Encodes data structures using the SCALE (Simple Concatenated Aggregate Little-Endian) codec for the Substrate ecosystem.
/// SCALE is a lightweight, efficient, binary serialization and encoding format used extensively within the Substrate framework.
/// https://docs.substrate.io/reference/scale-codec/
class SubstrateScaleEncoder {
  /// Encodes the String [value] into a SCALE encoded byte array.
  static Uint8List encodeString(String value) {
    Uint8List bytes = Uint8List.fromList(value.codeUnits);
    return encodeBytes(bytes);
  }

  /// Encodes the Uint8List [value] into a SCALE encoded byte array.
  static Uint8List encodeBytes(Uint8List value) {
    Uint8List lengthBytes = encodeCUint(value.length);
    return Uint8List.fromList(<int>[...lengthBytes, ...value]);
  }

  /// Encodes the unsigned 32-bit integer [value] into a SCALE encoded byte array.
  static Uint8List encodeCUint(int value) {
    int tmpValue = value;
    List<int> output = <int>[];

    if (tmpValue < 64) {
      output.add(tmpValue << 2);
    } else if (tmpValue < 16384) {
      output
        ..add((tmpValue & 0x3F) << 2 | 1)
        ..add((tmpValue >> 6).toUnsigned(8));
    } else if (tmpValue < 1073741824) {
      output
        ..add((tmpValue & 0x3F) << 2 | 2)
        ..add((tmpValue >> 6).toUnsigned(8))
        ..add((tmpValue >> 14).toUnsigned(8))
        ..add((tmpValue >> 22).toUnsigned(8));
    } else {
      int bytesNeeded = (tmpValue.bitLength + 7) >> 3;
      output.add(((bytesNeeded - 4) << 2).toUnsigned(8) | 3);
      for (int i = 0; i < bytesNeeded; i++) {
        output.add(tmpValue.toUnsigned(8).toInt());
        tmpValue >>= 8;
      }
    }
    return Uint8List.fromList(output);
  }

  /// Encodes the unsigned 64-bit integer [value] into a SCALE encoded byte array.
  static Uint8List encodeUInt(BigInt value) {
    return encodeUIntWithBytesLength(value, bytesLength: value.bitLength ~/ 8);
  }

  /// Encodes the unsigned 64-bit integer [value] into a SCALE encoded byte array with a fixed [bytesLength].
  static Uint8List encodeUIntWithBytesLength(BigInt v, {required int bytesLength}) {
    return BigIntUtils.changeToBytes(v, length: bytesLength, order: bytesLength >= 2 ? Endian.little : Endian.big);
  }
}
