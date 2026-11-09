import 'package:cryptography_utils/src/password_generator/character_set_type.dart';
import 'package:cryptography_utils/src/password_generator/password.dart';
import 'package:cryptography_utils/src/password_generator/password_characters_config.dart';
import 'package:cryptography_utils/src/password_generator/password_generator_config.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Password.characterSetType getter', () {
    test('Should [return ascii] for [ASCII]', () {
      // Arrange
      Password actualPassword = Password(
        password: ']Jn*pUuY32&I~*I0c7jS7',
        config: PasswordGeneratorConfig.ascii(),
        randomCharacterCount: 21,
        checksumCharacterCount: 0,
      );

      // Act
      CharacterSetType actualCharacterSetType = actualPassword.characterSetType;

      // Assert
      CharacterSetType expectedCharacterSetType = CharacterSetType.ascii;

      expect(actualCharacterSetType, expectedCharacterSetType);
    });

    test('Should [return sip2] for [SIP-2]', () {
      // Arrange
      Password actualPassword = Password(
        password: 'yMz1ERwy90v4WTzvLrNLcVg',
        config: PasswordGeneratorConfig.sip2(),
        randomCharacterCount: 21,
        checksumCharacterCount: 2,
      );

      // Act
      CharacterSetType actualCharacterSetType = actualPassword.characterSetType;

      // Assert
      CharacterSetType expectedCharacterSetType = CharacterSetType.sip2;

      expect(actualCharacterSetType, expectedCharacterSetType);
    });

    test('Should [return advanced] for [advanced numbers]', () {
      // Arrange
      Password actualPassword = Password(
        password: '644392175628170237893',
        config: PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false)),
        randomCharacterCount: 21,
        checksumCharacterCount: 0,
      );

      // Act
      CharacterSetType actualCharacterSetType = actualPassword.characterSetType;

      // Assert
      CharacterSetType expectedCharacterSetType = CharacterSetType.advanced;

      expect(actualCharacterSetType, expectedCharacterSetType);
    });

    test('Should [return advanced] for [advanced special]', () {
      // Arrange
      Password actualPassword = Password(
        password: '"){\$=+"\'|(}_&&_~)=}#"',
        config: PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true)),
        randomCharacterCount: 21,
        checksumCharacterCount: 0,
      );

      // Act
      CharacterSetType actualCharacterSetType = actualPassword.characterSetType;

      // Assert
      CharacterSetType expectedCharacterSetType = CharacterSetType.advanced;

      expect(actualCharacterSetType, expectedCharacterSetType);
    });

    test('Should [return advanced] for [advanced numbers, special]', () {
      // Arrange
      Password actualPassword = Password(
        password: '"1{\$=+"\'|(4_&&_0)=8#"',
        config: PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: true)),
        randomCharacterCount: 21,
        checksumCharacterCount: 0,
      );

      // Act
      CharacterSetType actualCharacterSetType = actualPassword.characterSetType;

      // Assert
      CharacterSetType expectedCharacterSetType = CharacterSetType.advanced;

      expect(actualCharacterSetType, expectedCharacterSetType);
    });
  });

  group('Tests of Password.entropy getter', () {
    test('Should [return 137.64636588523038 bits] for [ASCII] with [21 random characters]', () {
      // Arrange
      Password actualPassword = Password(
        password: ']Jn*pUuY32&I~*I0c7jS7',
        config: PasswordGeneratorConfig.ascii(),
        randomCharacterCount: 21,
        checksumCharacterCount: 0,
      );

      // Act
      double actualEntropy = actualPassword.entropy;

      // Assert
      double expectedEntropy = 137.64636588523038;

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return 126 bits] for [SIP-2] excluding checksum characters with [21 random characters]', () {
      // Arrange
      Password actualPassword = Password(
        password: 'yMz1ERwy90v4WTzvLrNLcVg',
        config: PasswordGeneratorConfig.sip2(),
        randomCharacterCount: 21,
        checksumCharacterCount: 2,
      );

      // Act
      double actualEntropy = actualPassword.entropy;

      // Assert
      double expectedEntropy = 126;

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return 69.7604899926346 bits] for [advanced numbers] with [21 random characters]', () {
      // Arrange
      Password actualPassword = Password(
        password: '644392175628170237893',
        config: PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false)),
        randomCharacterCount: 21,
        checksumCharacterCount: 0,
      );

      // Act
      double actualEntropy = actualPassword.entropy;

      // Assert
      double expectedEntropy = 69.76048999263462;

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return 105 bits] for [advanced special] with [21 random characters]', () {
      // Arrange
      Password actualPassword = Password(
        password: '"){\$=+"\'|(}_&&_~)=}#"',
        config: PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true)),
        randomCharacterCount: 21,
        checksumCharacterCount: 0,
      );

      // Act
      double actualEntropy = actualPassword.entropy;

      // Assert
      double expectedEntropy = 105;

      expect(actualEntropy, expectedEntropy);
    });
  });
}
