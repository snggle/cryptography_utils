import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';

/// The [SS58Encoder] class provides functionality to take a public key and encode it into this specific address format, ensuring compatibility
/// with the Substrate network's requirements for address representation.
/// https://docs.substrate.io/reference/address-formats/
class SS58Encoder {
  static final List<int> checksumPrefix = utf8.encode('SS58PRE');

  /// Encodes the given [bytes] into a Substrate address using the given [ss58Format].
  static String encode(List<int> bytes, int ss58Format) {
    List<int> ss58FormatBytes;
    if (ss58Format <= 63) {
      ss58FormatBytes = BigIntUtils.changeToBytes(BigInt.from(ss58Format), order: Endian.little);
    } else {
      ss58FormatBytes = List<int>.from(<int>[((ss58Format & 0x00FC) >> 2) | 0x0040, (ss58Format >> 8) | ((ss58Format & 0x0003) << 6)]);
    }

    List<int> payload = List<int>.from(<int>[...ss58FormatBytes, ...bytes]);
    List<int> checksum = _computeChecksum(payload);

    return Base58Codec.encode(Uint8List.fromList(<int>[...payload, ...checksum]));
  }

  static Uint8List decode(String address) {
    Uint8List decBytes = Base58Codec.decode(address);

    int ss58FormatLen;

    if ((decBytes[0] & 0x40) != 0) {
      ss58FormatLen = 2;
    } else {
      ss58FormatLen = 1;
    }

    List<int> dataBytes = List<int>.from(decBytes.sublist(ss58FormatLen, decBytes.length - 2));
    List<int> checksumBytes = List<int>.from(decBytes.sublist(decBytes.length - 2));

    if (dataBytes.length != 32) {
      throw FormatException('Invalid data length (${dataBytes.length})');
    }

    List<int> checksumBytesGot = _computeChecksum(List<int>.from(decBytes.sublist(0, decBytes.length - 2)));

    if (!checksumBytesGot.every((int e) => e == checksumBytes[checksumBytesGot.indexOf(e)])) {
      throw Exception('Invalid checksum (expected ${base64Encode(checksumBytesGot)}, got ${base64Encode(checksumBytes)})');
    }

    return Uint8List.fromList(dataBytes);
  }

  static List<int> _computeChecksum(List<int> dataBytes) {
    Uint8List prefixAndData = Uint8List.fromList(<int>[...checksumPrefix, ...dataBytes]);
    return Blake2d().process(prefixAndData).sublist(0, 2);
  }
}
