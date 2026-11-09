import 'dart:convert';

import 'package:cryptography_utils/src/hash/sha/sha256/sha256.dart';
import 'package:cryptography_utils/src/password_generator/character_sets.dart';
import 'package:cryptography_utils/src/password_generator/password.dart';
import 'package:cryptography_utils/src/password_generator/password_characters_config.dart';
import 'package:cryptography_utils/src/password_generator/password_generator.dart';
import 'package:cryptography_utils/src/password_generator/password_generator_config.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of PasswordGenerator.ascii()', () {
    test('Should [return the ASCII configuration]', () {
      // Act
      PasswordGenerator actualGenerator = PasswordGenerator.ascii();

      // Assert
      PasswordGeneratorConfig expectedConfig = PasswordGeneratorConfig.ascii();

      PasswordGenerator expectedGenerator = PasswordGenerator(expectedConfig);

      expect(actualGenerator, expectedGenerator);
    });
  });

  group('Tests of PasswordGenerator.sip2()', () {
    test('Should [return the SIP-2 configuration]', () {
      // Act
      PasswordGenerator actualGenerator = PasswordGenerator.sip2();

      // Assert
      PasswordGeneratorConfig expectedConfig = PasswordGeneratorConfig.sip2();

      PasswordGenerator expectedGenerator = PasswordGenerator(expectedConfig);

      expect(actualGenerator, expectedGenerator);
    });
  });

  group('Tests of PasswordGenerator.advanced()', () {
    test('Should [return the advanced numbers configuration]', () {
      // Act
      PasswordGenerator actualGenerator =
          PasswordGenerator.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false));

      // Assert
      PasswordGeneratorConfig expectedConfig =
          PasswordGeneratorConfig.advanced(PasswordCharactersConfig(lowercase: false, uppercase: false, special: false));

      PasswordGenerator expectedGenerator = PasswordGenerator(expectedConfig);

      expect(actualGenerator, expectedGenerator);
    });
  });

  group('Tests of PasswordGenerator.generate()', () {
    group('Tests of generating passwords with [ASCII] dictionary', () {
      test('Should [throw ArgumentError] if requested [ASCII] password length is [-1]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.ascii();

        // Assert
        expect(() => actualGenerator.generate(-1), throwsA(isA<ArgumentError>()));
      });

      test('Should [throw ArgumentError] if requested [ASCII] password length is [0]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.ascii();

        // Assert
        expect(() => actualGenerator.generate(0), throwsA(isA<ArgumentError>()));
      });

      test('Should [return Password] with [1] random and [0] checksum characters for length [1]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.ascii();

        // Act
        Password actualPassword = actualGenerator.generate(1);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 1,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 6.554588851677638);
      });

      test('Should [return Password] with [18] random and [0] checksum characters for length [18]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.ascii();

        // Act
        Password actualPassword = actualGenerator.generate(18);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 18,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 117.98259933019747);
      });

      test('Should [return Password] with [20] random and [0] checksum characters for length [20]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.ascii();

        // Act
        Password actualPassword = actualGenerator.generate(20);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 20,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 131.09177703355275);
      });

      test('Should [return Password] with [40] random and [0] checksum characters for length [40]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.ascii();

        // Act
        Password actualPassword = actualGenerator.generate(40);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 40,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 262.1835540671055);
      });

      test('Should [return Password] with [128] random and [0] checksum characters for length [128]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.ascii();

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 128,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 838.9873730147376);
      });
    });

    group('Tests of generating passwords with [SIP-2] dictionary', () {
      test('Should [throw ArgumentError] if requested [SIP-2] password length is [-1]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Assert
        expect(() => actualGenerator.generate(-1), throwsA(isA<ArgumentError>()));
      });

      test('Should [throw ArgumentError] if requested [SIP-2] password length is [0]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Assert
        expect(() => actualGenerator.generate(0), throwsA(isA<ArgumentError>()));
      });

      test('Should [throw ArgumentError] if requested [SIP-2] password length is [1]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Assert
        expect(() => actualGenerator.generate(1), throwsA(isA<ArgumentError>()));
      });

      test('Should [return Password] with [1] random and [1] checksum characters for length [2]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(2);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 1,
          checksumCharacterCount: 1,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 6);
      });

      test('Should [return Password] with [18] random and [1] checksum characters for length [19]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(19);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 18,
          checksumCharacterCount: 1,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 108);
      });

      test('Should [return Password] with [19] random and [1] checksum characters for length [20]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(20);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 19,
          checksumCharacterCount: 1,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 114);
      });

      test('Should [return Password] with [19] random and [2] checksum characters for length [21]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(21);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 19,
          checksumCharacterCount: 2,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 114);
      });

      test('Should [return Password] with [20] random and [2] checksum characters for length [22]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(22);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 20,
          checksumCharacterCount: 2,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 120);
      });

      test('Should [return Password] with [22] random and [2] checksum characters for length [24]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(24);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 22,
          checksumCharacterCount: 2,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 132);
      });

      test('Should [return Password] with [43] random and [2] checksum characters for length [45]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(45);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 43,
          checksumCharacterCount: 2,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 258);
      });

      test('Should [return Password] with [126] random and [2] checksum characters for length [128]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 126,
          checksumCharacterCount: 2,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 756);
      });
    });

    group('Tests of generating passwords with [all advanced options active]', () {
      test('Should [throw ArgumentError] if password length is [-1]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(PasswordCharactersConfig());

        // Assert
        expect(() => actualGenerator.generate(-1), throwsA(isA<ArgumentError>()));
      });

      test('Should [throw ArgumentError] if password length is [0]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(PasswordCharactersConfig());

        // Assert
        expect(() => actualGenerator.generate(0), throwsA(isA<ArgumentError>()));
      });

      test('Should [return Password] with [1] random and [0] checksum characters for length [1]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(PasswordCharactersConfig());

        // Act
        Password actualPassword = actualGenerator.generate(1);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 1,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 6.554588851677638);
      });

      test('Should [return Password] with [18] random and [0] checksum characters for length [18]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(PasswordCharactersConfig());

        // Act
        Password actualPassword = actualGenerator.generate(18);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 18,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 117.98259933019747);
      });

      test('Should [return Password] with [20] random and [0] checksum characters for length [20]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(PasswordCharactersConfig());

        // Act
        Password actualPassword = actualGenerator.generate(20);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 20,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 131.09177703355275);
      });

      test('Should [return Password] with [40] random and [0] checksum characters for length [40]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(PasswordCharactersConfig());

        // Act
        Password actualPassword = actualGenerator.generate(40);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 40,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 262.1835540671055);
      });

      test('Should [return Password] with [128] random and [0] checksum characters for length [128]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(PasswordCharactersConfig());

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        Password expectedPassword = Password(
          password: actualPassword.password,
          config: actualGenerator.config,
          randomCharacterCount: 128,
          checksumCharacterCount: 0,
        );

        expect(actualPassword, expectedPassword);
        expect(actualPassword.entropy, 838.9873730147376);
      });
    });

    group('Tests of generating passwords with various configuration of advanced options', () {
      test('Should [generate only allowed characters] with [lowercase]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: false);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 601.6562839220599);
      });

      test('Should [generate only allowed characters] with [uppercase]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: false, special: false);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 601.6562839220599);
      });

      test('Should [generate only allowed characters] with [lowercase, uppercase]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: false, special: false);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 729.6562839220599);
      });

      test('Should [generate only allowed characters] with [numbers]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: false);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 425.2067961455824);
      });

      test('Should [generate only allowed characters] with [lowercase, numbers]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: true, special: false);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 661.750400184616);
      });

      test('Should [generate only allowed characters] with [uppercase, numbers]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: true, special: false);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 661.750400184616);
      });

      test('Should [generate only allowed characters] with [lowercase, uppercase, numbers]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: false);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 762.1371277295201);
      });

      test('Should [generate only allowed characters] with [special]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: false, special: true);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 640);
      });

      test('Should [generate only allowed characters] with [lowercase, special]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: false, special: true);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 749.8215673763292);
      });

      test('Should [generate only allowed characters] with [uppercase, special]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: false, special: true);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 749.8215673763292);
      });

      test('Should [generate only allowed characters] with [lowercase, uppercase, special]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: false, special: true);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 818.2166301156813);
      });

      test('Should [generate only allowed characters] with [numbers, special]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: false, uppercase: false, numbers: true, special: true);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 690.2166301156814);
      });

      test('Should [generate only allowed characters] with [lowercase, numbers, special]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: true, uppercase: false, numbers: true, special: true);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 779.1952436800435);
      });

      test('Should [generate only allowed characters] with [uppercase, numbers, special]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: false, uppercase: true, numbers: true, special: true);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 779.1952436800435);
      });

      test('Should [generate only allowed characters] with [lowercase, uppercase, numbers, special]', () {
        // Arrange
        PasswordCharactersConfig actualSettings = PasswordCharactersConfig(lowercase: true, uppercase: true, numbers: true, special: true);
        PasswordGenerator actualGenerator = PasswordGenerator.advanced(actualSettings);

        // Act
        Password actualPassword = actualGenerator.generate(128);

        // Assert
        int expectedLength = 128;
        expect(actualPassword.password.length, expectedLength);
        expect(actualPassword.password.split(''), everyElement(isIn(actualSettings.characterSet.split(''))));
        expect(actualPassword.entropy, 838.9873730147376);
      });
    });

    group('Tests of generating passwords with SIP-2 checksum', () {
      const String sip2Alphabet = PasswordCharacterSets.sip2;

      test('Should [append 1 SIP-2 checksum characters] for password length [2]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(2);

        // Assert
        int expectedRandomCharacterCount = 1;
        String actualRandomPart = actualPassword.password.substring(0, expectedRandomCharacterCount);
        String actualChecksum = actualPassword.password.substring(expectedRandomCharacterCount);
        List<int> expectedHashBytes = Sha256().convert(utf8.encode(actualRandomPart)).byteList;
        String expectedHashBits = expectedHashBytes.map((int byte) => byte.toRadixString(2).padLeft(8, '0')).join();
        String expectedChecksum = List<String>.generate(
          1,
          (int index) => sip2Alphabet[int.parse(expectedHashBits.substring(index * 6, (index + 1) * 6), radix: 2)],
        ).join();

        expect(actualChecksum, expectedChecksum);
      });

      test('Should [append 2 SIP-2 checksum characters] for password length [21]', () {
        // Arrange
        PasswordGenerator actualGenerator = PasswordGenerator.sip2();

        // Act
        Password actualPassword = actualGenerator.generate(21);

        // Assert
        int expectedRandomCharacterCount = 19;
        String actualRandomPart = actualPassword.password.substring(0, expectedRandomCharacterCount);
        String actualChecksum = actualPassword.password.substring(expectedRandomCharacterCount);
        List<int> expectedHashBytes = Sha256().convert(utf8.encode(actualRandomPart)).byteList;
        String expectedHashBits = expectedHashBytes.map((int byte) => byte.toRadixString(2).padLeft(8, '0')).join();
        String expectedChecksum = List<String>.generate(
          2,
          (int index) => sip2Alphabet[int.parse(expectedHashBits.substring(index * 6, (index + 1) * 6), radix: 2)],
        ).join();

        expect(actualChecksum, expectedChecksum);
      });
    });
  });
}
