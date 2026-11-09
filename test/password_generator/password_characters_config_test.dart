import 'package:cryptography_utils/src/password_generator/password_characters_config.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of PasswordCharactersConfig()', () {
    test('Should [enable all character categories] by default', () {
      // Act
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig();

      // Assert
      expect(actualConfig.lowercase, true);
      expect(actualConfig.uppercase, true);
      expect(actualConfig.numbers, true);
      expect(actualConfig.special, true);
    });

    test('Should [throw ArgumentError] when [all categories are disabled]', () {
      // Assert
      expect(
        () => PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: false),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Tests of PasswordCharactersConfig.characterSet getter', () {
    test('Should [return correct list of characters] for [lowercase]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = 'abcdefghijklmnopqrstuvwxyz';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [uppercase]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: false, special: false);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [lowercase, uppercase]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: false, special: false);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [numbers]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = '0123456789';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [lowercase, numbers]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: true, special: false);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = 'abcdefghijklmnopqrstuvwxyz0123456789';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [uppercase, numbers]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: true, special: false);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [lowercase, uppercase, numbers]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: false);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = r'''!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [lowercase, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: true);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = r'''abcdefghijklmnopqrstuvwxyz!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [uppercase, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: false, special: true);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = r'''ABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [lowercase, uppercase, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: false, special: true);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = r'''abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [numbers, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: true);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = r'''0123456789!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [lowercase, numbers, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: true, special: true);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = r'''abcdefghijklmnopqrstuvwxyz0123456789!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [uppercase, numbers, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: true, special: true);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = r'''ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';

      expect(actualCharacterSet, expectedCharacterSet);
    });

    test('Should [return correct list of characters] for [lowercase, uppercase, numbers, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true);

      // Act
      String actualCharacterSet = actualConfig.characterSet;

      // Assert
      String expectedCharacterSet = r'''abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~''';

      expect(actualCharacterSet, expectedCharacterSet);
    });
  });

  group('Tests of PasswordCharactersConfig.length getter', () {
    test('Should [return 26] for [lowercase]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 26;

      expect(actualLength, expectedLength);
    });

    test('Should [return 26] for [uppercase]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: false, special: false);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 26;

      expect(actualLength, expectedLength);
    });

    test('Should [return 52] for [lowercase, uppercase]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: false, special: false);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 52;

      expect(actualLength, expectedLength);
    });

    test('Should [return 10] for [numbers]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 10;

      expect(actualLength, expectedLength);
    });

    test('Should [return 36] for [lowercase, numbers]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: true, special: false);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 36;

      expect(actualLength, expectedLength);
    });

    test('Should [return 36] for [uppercase, numbers]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: true, special: false);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 36;

      expect(actualLength, expectedLength);
    });

    test('Should [return 62] for [lowercase, uppercase, numbers]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: false);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 62;

      expect(actualLength, expectedLength);
    });

    test('Should [return 32] for [special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 32;

      expect(actualLength, expectedLength);
    });

    test('Should [return 58] for [lowercase, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: true);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 58;

      expect(actualLength, expectedLength);
    });

    test('Should [return 58] for [uppercase, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: false, special: true);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 58;

      expect(actualLength, expectedLength);
    });

    test('Should [return 84] for [lowercase, uppercase, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: false, special: true);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 84;

      expect(actualLength, expectedLength);
    });

    test('Should [return 42] for [numbers, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: true);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 42;

      expect(actualLength, expectedLength);
    });

    test('Should [return 68] for [lowercase, numbers, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: true, special: true);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 68;

      expect(actualLength, expectedLength);
    });

    test('Should [return 68] for [uppercase, numbers, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: true, special: true);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 68;

      expect(actualLength, expectedLength);
    });

    test('Should [return 94] for [lowercase, uppercase, numbers, special]', () {
      // Arrange
      PasswordCharactersConfig actualConfig = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true);

      // Act
      int actualLength = actualConfig.length;

      // Assert
      int expectedLength = 94;

      expect(actualLength, expectedLength);
    });
  });
}
