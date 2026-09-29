enum CharacterSetType {
  sip2,
  ascii;

  static const int _asciiCharacterSetLength = 94;
  static const int _firstNonWhitespaceAsciiCodeUnit = 33;
  static const String _sip2CharacterSet = '!+-0123456789=@ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
  static final String _asciiCharacterSet = String.fromCharCodes(
    List<int>.generate(_asciiCharacterSetLength, (int index) => _firstNonWhitespaceAsciiCodeUnit + index),
  );

  String get characterSet {
    switch (this) {
      case CharacterSetType.sip2:
        return _sip2CharacterSet;
      case CharacterSetType.ascii:
        return _asciiCharacterSet;
    }
  }

  int get length => characterSet.length;
}
