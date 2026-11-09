import 'package:cryptography_utils/src/password_generator/character_set_type.dart';
import 'package:cryptography_utils/src/password_generator/password_characters_config.dart';
import 'package:cryptography_utils/src/password_generator/password_generator_config.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of PasswordGeneratorConfig.ascii()', () {
    test('Should [return correct alphabet and checksum setting] for [ASCII]', () {
      // Act
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Assert
      String expectedCharacterSet = r'''!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~''';
      int expectedLength = 94;

      expect(actualConfig.characterSet, expectedCharacterSet);
      expect(actualConfig.length, expectedLength);
      expect(actualConfig.characterSetType, CharacterSetType.ascii);
      expect(actualConfig.checksumEnabled, false);
    });
  });

  group('Tests of PasswordGeneratorConfig.sip2()', () {
    test('Should [return correct alphabet and checksum setting] for [SIP-2]', () {
      // Act
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Assert
      String expectedCharacterSet = '!+-0123456789=@ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
      int expectedLength = 64;

      expect(actualConfig.characterSet, expectedCharacterSet);
      expect(actualConfig.length, expectedLength);
      expect(actualConfig.characterSetType, CharacterSetType.sip2);
      expect(actualConfig.checksumEnabled, true);
    });
  });

  group('Tests of PasswordGeneratorConfig.advanced()', () {
    test('Should [return correct alphabet and checksum setting] for [lowercase, uppercase, numbers, special]', () {
      // Act
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true));

      // Assert
      String expectedCharacterSet = r'''abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';
      int expectedLength = 94;

      expect(actualConfig.characterSet, expectedCharacterSet);
      expect(actualConfig.length, expectedLength);
      expect(actualConfig.characterSetType, CharacterSetType.advanced);
      expect(actualConfig.checksumEnabled, false);
    });

    test('Should [return correct alphabet and checksum setting] for [lowercase]', () {
      // Act
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false));

      // Assert
      String expectedCharacterSet = 'abcdefghijklmnopqrstuvwxyz';
      int expectedLength = 26;

      expect(actualConfig.characterSet, expectedCharacterSet);
      expect(actualConfig.length, expectedLength);
      expect(actualConfig.characterSetType, CharacterSetType.advanced);
      expect(actualConfig.checksumEnabled, false);
    });

    test('Should [return correct alphabet and checksum setting] for [uppercase]', () {
      // Act
      PasswordGeneratorConfig actualConfig =
      PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: false, special: false));

      // Assert
      String expectedCharacterSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      int expectedLength = 26;

      expect(actualConfig.characterSet, expectedCharacterSet);
      expect(actualConfig.length, expectedLength);
      expect(actualConfig.characterSetType, CharacterSetType.advanced);
      expect(actualConfig.checksumEnabled, false);
    });

    test('Should [return correct alphabet and checksum setting] for [numbers]', () {
      // Act
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false));

      // Assert
      String expectedCharacterSet = '0123456789';
      int expectedLength = 10;

      expect(actualConfig.characterSet, expectedCharacterSet);
      expect(actualConfig.length, expectedLength);
      expect(actualConfig.characterSetType, CharacterSetType.advanced);
      expect(actualConfig.checksumEnabled, false);
    });

    test('Should [return correct alphabet and checksum setting] for [special]', () {
      // Act
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true));

      // Assert
      String expectedCharacterSet = r'''!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';
      int expectedLength = 32;

      expect(actualConfig.characterSet, expectedCharacterSet);
      expect(actualConfig.length, expectedLength);
      expect(actualConfig.characterSetType, CharacterSetType.advanced);
      expect(actualConfig.checksumEnabled, false);
    });
  });

  group('Tests of PasswordGeneratorConfig.bitsPerCharacter getter', () {
    test('Should [return 6.554588851677638 bits] for [ASCII]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Act
      double actualBitsPerCharacter = actualConfig.bitsPerCharacter;

      // Assert
      double expectedBitsPerCharacter = 6.554588851677638;

      expect(actualBitsPerCharacter, expectedBitsPerCharacter);
    });

    test('Should [return 6 bits] for [SIP-2]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Act
      double actualBitsPerCharacter = actualConfig.bitsPerCharacter;

      // Assert
      double expectedBitsPerCharacter = 6.0;

      expect(actualBitsPerCharacter, expectedBitsPerCharacter);
    });

    test('Should [return 6.554588851677638 bits] for [advanced all categories]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true));

      // Act
      double actualBitsPerCharacter = actualConfig.bitsPerCharacter;

      // Assert
      double expectedBitsPerCharacter = 6.554588851677638;

      expect(actualBitsPerCharacter, expectedBitsPerCharacter);
    });

    test('Should [return 4.700439718141092 bits] for [advanced lowercase]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false));

      // Act
      double actualBitsPerCharacter = actualConfig.bitsPerCharacter;

      // Assert
      double expectedBitsPerCharacter = 4.700439718141093;

      expect(actualBitsPerCharacter, expectedBitsPerCharacter);
    });

    test('Should [return 3.321928094887362 bits] for [advanced numbers]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false));

      // Act
      double actualBitsPerCharacter = actualConfig.bitsPerCharacter;

      // Assert
      double expectedBitsPerCharacter = 3.3219280948873626;

      expect(actualBitsPerCharacter, expectedBitsPerCharacter);
    });

    test('Should [return 5 bits] for [advanced special]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true));

      // Act
      double actualBitsPerCharacter = actualConfig.bitsPerCharacter;

      // Assert
      double expectedBitsPerCharacter = 5.0;

      expect(actualBitsPerCharacter, expectedBitsPerCharacter);
    });
  });

  group('Tests of PasswordGeneratorConfig.checksumCharacterCountForLength()', () {
    test('Should [return 0 checksum characters] for [ASCII] length [2]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(2);

      // Assert
      int expectedCount = 0;

      expect(actualCount, expectedCount);
    });

    test('Should [return 0 checksum characters] for [ASCII] length [20]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(20);

      // Assert
      int expectedCount = 0;

      expect(actualCount, expectedCount);
    });

    test('Should [return 0 checksum characters] for [ASCII] length [128]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(128);

      // Assert
      int expectedCount = 0;

      expect(actualCount, expectedCount);
    });

    test('Should [return 1 checksum characters] for [SIP-2] length [2]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(2);

      // Assert
      int expectedCount = 1;

      expect(actualCount, expectedCount);
    });

    test('Should [return 1 checksum characters] for [SIP-2] length [20]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(20);

      // Assert
      int expectedCount = 1;

      expect(actualCount, expectedCount);
    });

    test('Should [return 2 checksum characters] for [SIP-2] length [21]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(21);

      // Assert
      int expectedCount = 2;

      expect(actualCount, expectedCount);
    });

    test('Should [return 2 checksum characters] for [SIP-2] length [128]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(128);

      // Assert
      int expectedCount = 2;

      expect(actualCount, expectedCount);
    });

    test('Should [return 0 checksum characters] for [advanced all categories] length [20]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true));

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(20);

      // Assert
      int expectedCount = 0;

      expect(actualCount, expectedCount);
    });

    test('Should [return 0 checksum characters] for [advanced lowercase] length [20]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false));

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(20);

      // Assert
      int expectedCount = 0;

      expect(actualCount, expectedCount);
    });

    test('Should [return 0 checksum characters] for [advanced numbers] length [20]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false));

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(20);

      // Assert
      int expectedCount = 0;

      expect(actualCount, expectedCount);
    });

    test('Should [return 0 checksum characters] for [advanced special] length [20]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true));

      // Act
      int actualCount = actualConfig.checksumCharactersForLength(20);

      // Assert
      int expectedCount = 0;

      expect(actualCount, expectedCount);
    });
  });

  group('Tests of PasswordGeneratorConfig.minimumLengthForEntropy()', () {
    test('Should [return length 18] for [ASCII] with [112 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(112);

      // Assert
      int expectedLength = 18;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 20] for [ASCII] with [128 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(128);

      // Assert
      int expectedLength = 20;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 40] for [ASCII] with [256 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(256);

      // Assert
      int expectedLength = 40;

      expect(actualLength, expectedLength);
    });

    test('Should [throw ArgumentError] for [ASCII] with entropy [-1]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(-1), throwsA(isA<ArgumentError>()));
    });

    test('Should [throw ArgumentError] for [ASCII] with entropy [0]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.ascii();

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(0), throwsA(isA<ArgumentError>()));
    });

    test('Should [return length 20] for [SIP-2] with [112 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(112);

      // Assert
      int expectedLength = 20;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 24] for [SIP-2] with [128 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(128);

      // Assert
      int expectedLength = 24;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 45] for [SIP-2] with [256 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(256);

      // Assert
      int expectedLength = 45;

      expect(actualLength, expectedLength);
    });

    test('Should [throw ArgumentError] for [SIP-2] with entropy [-1]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(-1), throwsA(isA<ArgumentError>()));
    });

    test('Should [throw ArgumentError] for [SIP-2] with entropy [0]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig = PasswordGeneratorConfig.sip2();

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(0), throwsA(isA<ArgumentError>()));
    });

    test('Should [return length 18] for [advanced all categories] with [112 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(112);

      // Assert
      int expectedLength = 18;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 20] for [advanced all categories] with [128 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(128);

      // Assert
      int expectedLength = 20;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 40] for [advanced all categories] with [256 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(256);

      // Assert
      int expectedLength = 40;

      expect(actualLength, expectedLength);
    });

    test('Should [throw ArgumentError] for [advanced all categories] with entropy [-1]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true));

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(-1), throwsA(isA<ArgumentError>()));
    });

    test('Should [throw ArgumentError] for [advanced all categories] with entropy [0]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true));

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(0), throwsA(isA<ArgumentError>()));
    });

    test('Should [return length 24] for [advanced lowercase] with [112 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(112);

      // Assert
      int expectedLength = 24;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 28] for [advanced lowercase] with [128 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(128);

      // Assert
      int expectedLength = 28;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 55] for [advanced lowercase] with [256 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(256);

      // Assert
      int expectedLength = 55;

      expect(actualLength, expectedLength);
    });

    test('Should [throw ArgumentError] for [advanced lowercase] with entropy [-1]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false));

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(-1), throwsA(isA<ArgumentError>()));
    });

    test('Should [throw ArgumentError] for [advanced lowercase] with entropy [0]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false));

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(0), throwsA(isA<ArgumentError>()));
    });

    test('Should [return length 34] for [advanced numbers] with [112 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(112);

      // Assert
      int expectedLength = 34;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 39] for [advanced numbers] with [128 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(128);

      // Assert
      int expectedLength = 39;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 78] for [advanced numbers] with [256 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(256);

      // Assert
      int expectedLength = 78;

      expect(actualLength, expectedLength);
    });

    test('Should [throw ArgumentError] for [advanced numbers] with entropy [-1]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false));

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(-1), throwsA(isA<ArgumentError>()));
    });

    test('Should [throw ArgumentError] for [advanced numbers] with entropy [0]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false));

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(0), throwsA(isA<ArgumentError>()));
    });

    test('Should [return length 23] for [advanced special] with [112 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(112);

      // Assert
      int expectedLength = 23;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 26] for [advanced special] with [128 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(128);

      // Assert
      int expectedLength = 26;

      expect(actualLength, expectedLength);
    });

    test('Should [return length 52] for [advanced special] with [256 bits of entropy]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true));

      // Act
      int actualLength = actualConfig.minimumLengthForEntropy(256);

      // Assert
      int expectedLength = 52;

      expect(actualLength, expectedLength);
    });

    test('Should [throw ArgumentError] for [advanced special] with entropy [-1]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true));

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(-1), throwsA(isA<ArgumentError>()));
    });

    test('Should [throw ArgumentError] for [advanced special] with entropy [0]', () {
      // Arrange
      PasswordGeneratorConfig actualConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true));

      // Assert
      expect(() => actualConfig.minimumLengthForEntropy(0), throwsA(isA<ArgumentError>()));
    });
  });
}
