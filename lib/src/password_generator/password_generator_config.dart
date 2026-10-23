import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/password_generator/character_sets.dart';

/// The resolved alphabet and checksum policy used to generate a password.
class PasswordGeneratorConfig {
  static const int _maxLengthWithOneChecksumCharacter = 20;

  final String characterSet;
  final bool checksumEnabled;

  /// Compatibility metadata only; advanced alphabet sizes come from [length].
  final CharacterSetType characterSetType;

  const PasswordGeneratorConfig._(this.characterSet, {required this.checksumEnabled, required this.characterSetType});

  factory PasswordGeneratorConfig.ascii() {
    return PasswordGeneratorConfig._(PasswordCharacterSets.ascii, checksumEnabled: false, characterSetType: CharacterSetType.ascii);
  }

  factory PasswordGeneratorConfig.sip2() {
    return const PasswordGeneratorConfig._(PasswordCharacterSets.sip2, checksumEnabled: true, characterSetType: CharacterSetType.sip2);
  }

  factory PasswordGeneratorConfig.advanced(PasswordCharactersConfig settings) {
    return PasswordGeneratorConfig._(settings.characterSet, checksumEnabled: false, characterSetType: CharacterSetType.advanced);
  }

  int get length => characterSet.length;

  double get bitsPerCharacter {
    // Powers of two have exact integer entropy, avoiding logarithm rounding.
    if ((length & (length - 1)) == 0) {
      return (length.bitLength - 1).toDouble();
    }
    return log(length) / ln2;
  }

  /// Checksum characters occupy space but contribute no random entropy.
  int checksumCharacterCountForLength(int passwordLength) {
    if (!checksumEnabled) {
      return 0;
    }
    return passwordLength <= _maxLengthWithOneChecksumCharacter ? 1 : 2;
  }

  /// Minimum total length, including any checksum, for a positive target.
  int minLengthForEntropy(int targetBits) {
    if (targetBits <= 0) {
      throw ArgumentError.value(targetBits, 'targetBits', 'Must be positive.');
    }

    int randomCharacterCount;
    if ((length & (length - 1)) == 0) {
      int bits = length.bitLength - 1;
      randomCharacterCount = targetBits ~/ bits + (targetBits % bits == 0 ? 0 : 1);
    } else {
      double bits = bitsPerCharacter;
      randomCharacterCount = (targetBits / bits).ceil();
      // Correct division rounding using the same entropy calculation as Password.
      while (randomCharacterCount * bits < targetBits) {
        randomCharacterCount++;
      }
      while ((randomCharacterCount - 1) * bits >= targetBits) {
        randomCharacterCount--;
      }
    }

    int passwordLength = randomCharacterCount;
    while (passwordLength - checksumCharacterCountForLength(passwordLength) < randomCharacterCount) {
      passwordLength++;
    }
    return passwordLength;
  }
}
