import 'dart:math';

import 'package:cryptography_utils/src/password_generator/character_set_type.dart';

class Password {
  final String password;
  final int randomCharacterCount;
  final int checksumCharacterCount;
  final CharacterSetType characterSetType;

  const Password({
    required this.password,
    required this.characterSetType,
    required this.randomCharacterCount,
    required this.checksumCharacterCount,
  });

  double get passwordEntropy => randomCharacterCount * (log(characterSetType.length) / ln2);
}
