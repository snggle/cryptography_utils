class BinaryUtils {
  static int binaryToInt(String binary) {
    return int.parse(binary, radix: 2);
  }

  static String bytesToBinary(List<int> bytes, {int padding = 8}) {
    return bytes.map((int byte) => byte.toRadixString(2).padLeft(padding, '0')).join('');
  }

  static String intToBinary(int number, {int padding = 8}) {
    return number.toRadixString(2).padLeft(padding, '0');
  }

  static List<String> splitBinary(String binary, int chunkSize) {
    RegExp regex = RegExp('.{1,$chunkSize}');
    List<String> chunks = regex.allMatches(binary).map((RegExpMatch match) => match.group(0)!).toList(growable: false);

    return chunks;
  }

  /// Adds two 32-bit integers and applies a mask to ensure the result fits within 32 bits.
  static int add32(int x, int y) => (x + y) & 0xFFFFFFFF;

  /// Rotates a 32-bit integer left by a specified number of bits.
  static int rotl32(int val, int shift) {
    int modShift = shift & 31;
    return ((val << modShift) & 0xFFFFFFFF) | ((val & 0xFFFFFFFF) >> (32 - modShift));
  }

  static int rotl64(int val, int shift) {
    return (val << shift) |(val >> (64 - shift)) & ~(-1 << (128 - shift));
  }

  /// Reads a 32-bit unsigned integer value in little-endian byte order from a list.
  static int readUint32LE(List<int> array, [int offset = 0]) {
    return ((array[offset + 3] << 24) |
    (array[offset + 2] << 16) |
    (array[offset + 1] << 8) |
    array[offset]) &
    0xFFFFFFFF;
  }

  /// Writes a 32-bit unsigned integer value in little-endian byte order to a list.
  static void writeUint32LE(int value, List<int> out, [int offset = 0]) {
    out[offset + 0] = value & 0xFF;
    out[offset + 1] = (value >> 8) & 0xFF;
    out[offset + 2] = (value >> 16) & 0xFF;
    out[offset + 3] = (value >> 24) & 0xFF;
  }
}
