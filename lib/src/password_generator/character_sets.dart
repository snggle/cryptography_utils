/// Shared alphabets used by password presets and advanced settings.
class PasswordCharacterSets {
  static const String lowercase = 'abcdefghijklmnopqrstuvwxyz';
  static const String uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const String numbers = '0123456789';
  static const String special = r'''!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';
  static const String sip2 = '!+-0123456789=@ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
  static final String ascii = String.fromCharCodes(List<int>.generate(94, (int index) => 33 + index));
}
