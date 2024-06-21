import 'dart:typed_data';

class StringUtils {
  static bool isASCIIBytes(Uint8List data) {
    for (int byte in data) {
      if (byte < 0 || byte > 127) {
        return false;
      }
    }
    return true;
  }
}