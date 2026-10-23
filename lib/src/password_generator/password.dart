import 'package:cryptography_utils/src/password_generator/character_set_type.dart';
import 'package:cryptography_utils/src/password_generator/password_generator_config.dart';

class Password {
  final String password;
  final int randomCharacterCount;
  final int checksumCharacterCount;
  final PasswordGeneratorConfig? _config;
  final CharacterSetType? _characterSetType;

  /// Retained for existing ASCII and SIP-2 callers.
  const Password({
    required this.password,
    required CharacterSetType characterSetType,
    required this.randomCharacterCount,
    required this.checksumCharacterCount,
  })  : _characterSetType = characterSetType,
        _config = null;

  const Password.withConfig({
    required this.password,
    required PasswordGeneratorConfig config,
    required this.randomCharacterCount,
    required this.checksumCharacterCount,
  })  : _config = config,
        _characterSetType = null;

  PasswordGeneratorConfig get config {
    if (_config != null) {
      return _config;
    }
    switch (_characterSetType) {
      case CharacterSetType.ascii:
        return PasswordGeneratorConfig.ascii();
      case CharacterSetType.sip2:
        return PasswordGeneratorConfig.sip2();
      case CharacterSetType.advanced:
      case null:
        throw StateError('Advanced passwords must be constructed with Password.withConfig.');
    }
  }

  /// Selection marker only. Use [config] for the effective advanced alphabet.
  CharacterSetType get characterSetType => _characterSetType ?? config.characterSetType;

  double get entropy => randomCharacterCount * config.bitsPerCharacter;
}
