// Class was shaped by the influence of JavaScript key sources including:
// https://github.com/ethereumjs/ethereumjs-monorepo/tree/master/packages/rlp
//
// Mozilla Public License Version 2.0
part of 'rlp_coder.dart';

/// A utility class providing static methods related to the Recursive Length Prefix (RLP) encoding.
class RLPUtils {
  /// Encodes the length of a data element as part of the RLP encoding process. This method is used to determine
  /// how many bytes are needed to represent the length of the data and to prepend the appropriate prefix according
  /// to the RLP specification.
  static Uint8List encodeLength(int length, int offset) {
    if (length < 56) {
      return Uint8List.fromList(<int>[length + offset]);
    }
    String lengthHex = length.toRadixString(16).padLeft(2, '0');
    int lengthOfLength = lengthHex.length ~/ 2;
    String firstByte = (offset + 55 + lengthOfLength).toRadixString(16).padLeft(2, '0');
    return Uint8List.fromList(HexEncoder.decode('$firstByte$lengthHex'));
  }
}
