import 'dart:convert';
import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/password_generator/character_set_type.dart';
import 'package:cryptography_utils/src/password_generator/password.dart';

class PasswordGenerator {
  static const int _bitsPerChecksumCharacter = 6;
  static const int _byteBitLength = 8;
  static const int _checksumCharacterMask = 0x3f;
  static const int _hashWindowBitLength = 16;
  static const int _maxPasswordLengthWithOneChecksumCharacter = 20;

  final CharacterSetType characterSetType;

  PasswordGenerator.ascii()
      : characterSetType = CharacterSetType.ascii;

  PasswordGenerator.sip2()
      : characterSetType = CharacterSetType.sip2;


  bool get _checksumEnabled => characterSetType == CharacterSetType.sip2;

  Password generate(int passwordLength) {
    if (passwordLength < _minPasswordLength) {
      throw ArgumentError('Invalid password length: $passwordLength. It should never be lower than $_minPasswordLength');
    }

    int checksumCharacterCount = _checksumEnabled ? _getChecksumCharacterCount(passwordLength) : 0;
    int randomCharacterCount = max(0, passwordLength - checksumCharacterCount);
    String randomPassword = _generateRandomPassword(randomCharacterCount);
    String checksumString = _checksumEnabled ? _generateChecksum(randomPassword, checksumCharacterCount) : '';
    String password = '$randomPassword$checksumString';

    return Password(
      password: password,
      randomCharacterCount: randomCharacterCount,
      checksumCharacterCount: checksumCharacterCount,
      characterSetType: characterSetType,
    );
  }

  int get _minPasswordLength => _checksumEnabled ? 2 : 1;

  static int _getChecksumCharacterCount(int passwordLength) {
    if (passwordLength <= _maxPasswordLengthWithOneChecksumCharacter) {
      return 1;
    }
    return 2;
  }

  static String _generateChecksum(String randomPassword, int checksumCharacterCount) {
    List<int> hashBytes = Sha256().convert(utf8.encode(randomPassword)).byteList;
    StringBuffer checksumStringBuffer = StringBuffer();

    for (int checksumCharacterIndex = 0; checksumCharacterIndex < checksumCharacterCount; checksumCharacterIndex++) {
      int checksumCharacterValue = _readSixBitValue(hashBytes, checksumCharacterIndex);
      checksumStringBuffer.write(CharacterSetType.sip2.characterSet[checksumCharacterValue]);
    }

    return checksumStringBuffer.toString();
  }

  String _generateRandomPassword(int randomCharacterCount) {
    StringBuffer passwordStringBuffer = StringBuffer();
    String characterSet = characterSetType.characterSet;
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
