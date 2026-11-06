import 'package:cryptography_utils/src/password_generator/character_set_type.dart';
import 'package:cryptography_utils/src/password_generator/password_generator_config.dart';

class Password {
  final String password;
  final int randomCharacterCount;
  final int checksumCharacterCount;
  final PasswordGeneratorConfig config;

  const Password({
    required this.password,
    required this.config,
    required this.randomCharacterCount,
    required this.checksumCharacterCount,
  });

  CharacterSetType get characterSetType => config.characterSetType;

  double get entropy => randomCharacterCount * config.bitsPerCharacter;
}
