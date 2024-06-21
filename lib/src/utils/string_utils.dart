class StringUtils {
  static bool areASCIIBytes(List<int> data) {
    for (int byte in data) {
      if (byte < 0 || byte > 127) {
        return false;
      }
    }
    return true;
  }
}
