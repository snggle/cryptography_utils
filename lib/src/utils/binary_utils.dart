class BinaryUtils {
  static int binaryToInt(String binary) {
    return int.parse(binary, radix: 2);
  }

  static String bytesToBinary(List<int> bytes, {int padding = 8}) {
    return bytes.map((int byte) => byte.toRadixString(2).padLeft(padding, '0')).join('');
  }

  static int maskTo8Bits(int value) {
    int mask8Bits = 0xFF;
    return value & mask8Bits;
  }

  static String intToBinary(int number, {int padding = 8}) {
    return number.toRadixString(2).padLeft(padding, '0');
  }

  static List<String> splitBinary(String binary, int chunkSize) {
    RegExp regex = RegExp('.{1,$chunkSize}');
    List<String> chunks = regex.allMatches(binary).map((RegExpMatch match) => match.group(0)!).toList(growable: false);

    return chunks;
  }
}
