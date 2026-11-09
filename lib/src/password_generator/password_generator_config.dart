import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/password_generator/character_sets.dart';
import 'package:equatable/equatable.dart';

class PasswordGeneratorConfig extends Equatable {
  static const int _maxLengthWithOneChecksumCharacter = 20;

  final String characterSet;
  final bool checksumEnabled;

  final CharacterSetType characterSetType;

  const PasswordGeneratorConfig._(this.characterSet, {required this.checksumEnabled, required this.characterSetType});

  factory PasswordGeneratorConfig.ascii() {
    return const PasswordGeneratorConfig._(PasswordCharacterSets.ascii, checksumEnabled: false, characterSetType: CharacterSetType.ascii);
  }

  factory PasswordGeneratorConfig.sip2() {
    return const PasswordGeneratorConfig._(PasswordCharacterSets.sip2, checksumEnabled: true, characterSetType: CharacterSetType.sip2);
  }

  factory PasswordGeneratorConfig.advanced(PasswordCharactersConfig settings) {
    return PasswordGeneratorConfig._(settings.characterSet, checksumEnabled: false, characterSetType: CharacterSetType.advanced);
  }

  int get length => characterSet.length;

  double get bitsPerCharacter {
    if ((length & (length - 1)) == 0) {
      return (length.bitLength - 1).toDouble();
    }
    return log(length) / ln2;
  }

  int checksumCharactersForLength(int passwordLength) {
    if (checksumEnabled == false) {
      return 0;
    }
    return passwordLength <= _maxLengthWithOneChecksumCharacter ? 1 : 2;
  }

  int minimumLengthForEntropy(int targetEntropyBits) {
    if (targetEntropyBits <= 0) {
      throw ArgumentError.value(targetEntropyBits, 'targetEntropyBits', 'Must be positive.');
    }

    int randomCharacterCount;
    if ((length & (length - 1)) == 0) {
      int bits = length.bitLength - 1;
      randomCharacterCount = targetEntropyBits ~/ bits + (targetEntropyBits % bits == 0 ? 0 : 1);
    } else {
      double bits = bitsPerCharacter;
      randomCharacterCount = (targetEntropyBits / bits).ceil();
      while (randomCharacterCount * bits < targetEntropyBits) {
        randomCharacterCount++;
      }
      while ((randomCharacterCount - 1) * bits >= targetEntropyBits) {
        randomCharacterCount--;
      }
    }

    int passwordLength = randomCharacterCount;
    while (passwordLength - checksumCharactersForLength(passwordLength) < randomCharacterCount) {
      passwordLength++;
    }
    return passwordLength;
  }

  @override
  List<Object?> get props => <Object?>[characterSet, checksumEnabled, characterSetType];
}
