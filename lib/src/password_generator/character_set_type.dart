import 'package:cryptography_utils/src/password_generator/character_sets.dart';

enum CharacterSetType {
  ascii,
  sip2,
  advanced;

  String get characterSet {
    switch (this) {
      case CharacterSetType.sip2:
        return PasswordCharacterSets.sip2;
      case CharacterSetType.ascii:
        return PasswordCharacterSets.ascii;
      case CharacterSetType.advanced:
        throw StateError('Use AdvancedCharacterSettings or PasswordGeneratorConfig for the effective advanced alphabet.');
    }
  }

  int get length => characterSet.length;
}
