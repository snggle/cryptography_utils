import 'package:cryptography_utils/src/password_generator/character_sets.dart';

class PasswordCharactersConfig {
  final bool lowercase;
  final bool uppercase;
  final bool numbers;
  final bool special;

  PasswordCharactersConfig({
    this.lowercase = true,
    this.uppercase = true,
    this.numbers = true,
    this.special = true,
  }) {
    if (!lowercase && !uppercase && !numbers && !special) {
      throw ArgumentError('At least one character category must be enabled.');
    }
  }

  String get characterSet {
    return <String>[
      if (lowercase) PasswordCharacterSets.lowercase,
      if (uppercase) PasswordCharacterSets.uppercase,
      if (numbers) PasswordCharacterSets.numbers,
      if (special) PasswordCharacterSets.special,
    ].join();
  }

  int get length => characterSet.length;

  PasswordCharactersConfig copyWith({
    bool? lowercase,
    bool? uppercase,
    bool? numbers,
    bool? special,
  }) {
    return PasswordCharactersConfig(
      lowercase: lowercase ?? this.lowercase,
      uppercase: uppercase ?? this.uppercase,
      numbers: numbers ?? this.numbers,
      special: special ?? this.special,
    );
  }
}
