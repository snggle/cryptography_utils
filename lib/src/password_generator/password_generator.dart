import 'dart:convert';
import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/password_generator/character_sets.dart';
import 'package:cryptography_utils/src/password_generator/password_characters_config.dart';

class PasswordGenerator {
  static const int _bitsPerChecksumCharacter = 6;
  static const int _byteBitLength = 8;
  static const int _checksumCharacterMask = 0x3f;
  static const int _hashWindowBitLength = 16;

  final PasswordGeneratorConfig config;

  PasswordGenerator(this.config);

  PasswordGenerator.ascii() : this(PasswordGeneratorConfig.ascii());

  PasswordGenerator.sip2() : this(PasswordGeneratorConfig.sip2());

  PasswordGenerator.advanced(PasswordCharactersConfig settings) : this(PasswordGeneratorConfig.advanced(settings));

  /// Selection marker only. Use [config] for the effective advanced alphabet.
  CharacterSetType get characterSetType => config.characterSetType;

  Password generate(int passwordLength) {
    int minPasswordLength = config.checksumEnabled ? 2 : 1;
    if (passwordLength < minPasswordLength) {
      throw ArgumentError('Invalid password length: $passwordLength. It should never be lower than $minPasswordLength');
    }

    int checksumCharacterCount = config.checksumCharacterCountForLength(passwordLength);
    int randomCharacterCount = passwordLength - checksumCharacterCount;
    String randomPassword = _generateRandomPassword(randomCharacterCount);
    String checksumString = config.checksumEnabled ? _generateChecksum(randomPassword, checksumCharacterCount) : '';
    String password = '$randomPassword$checksumString';

    return Password.withConfig(
      password: password,
      randomCharacterCount: randomCharacterCount,
      checksumCharacterCount: checksumCharacterCount,
      config: config,
    );
  }

  static String _generateChecksum(String randomPassword, int checksumCharacterCount) {
    List<int> hashBytes = Sha256().convert(utf8.encode(randomPassword)).byteList;
    StringBuffer checksumStringBuffer = StringBuffer();

    for (int checksumCharacterIndex = 0; checksumCharacterIndex < checksumCharacterCount; checksumCharacterIndex++) {
      int checksumCharacterValue = _readSixBitValue(hashBytes, checksumCharacterIndex);
      checksumStringBuffer.write(PasswordCharacterSets.sip2[checksumCharacterValue]);
    }

    return checksumStringBuffer.toString();
  }

  String _generateRandomPassword(int randomCharacterCount) {
    StringBuffer passwordStringBuffer = StringBuffer();
    String characterSet = config.characterSet;
    Random random = Random.secure();

    for (int characterIndex = 0; characterIndex < randomCharacterCount; characterIndex++) {
      passwordStringBuffer.write(characterSet[random.nextInt(characterSet.length)]);
    }

    return passwordStringBuffer.toString();
  }

  static int _readSixBitValue(List<int> bytes, int checksumCharacterIndex) {
    int bitOffset = checksumCharacterIndex * _bitsPerChecksumCharacter;
    int byteOffset = bitOffset ~/ _byteBitLength;
    int bitOffsetInWindow = bitOffset - (byteOffset * _byteBitLength);
    int hashWindow = (bytes[byteOffset] << _byteBitLength) | bytes[byteOffset + 1];
    int rightShift = _hashWindowBitLength - bitOffsetInWindow - _bitsPerChecksumCharacter;

    return (hashWindow >> rightShift) & _checksumCharacterMask;
  }
}
