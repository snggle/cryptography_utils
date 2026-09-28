import 'dart:math';

import 'package:cryptography_utils/src/password_generator/password.dart';
import 'package:cryptography_utils/src/password_generator/password_generator.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Sip2PasswordGenerator.generate()', () {
    group('Tests of generating password with non-whitespace ASCII dictionary', () {
      test('Should [throw ArgumentError] if requested length is [NEGATIVE]', () {
        // Arrange
        PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii(random: Random.secure());

        // Assert
        expect(
          () => actualPasswordGenerator.generate(-1),
          throwsA(isA<ArgumentError>()),
        );
      });

      test(
        'Should [throw ArgumentError] if requested length is [0]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii(random: Random.secure());

          // Assert
          expect(
            () => actualPasswordGenerator.generate(0),
            throwsA(isA<ArgumentError>()),
          );
        },
      );

      test(
        'Should [return PASSWORD with 1 random character and 0 checksum characters] if requested length is [1]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(1);

          // Assert
          expect(actualGeneratedPassword.password.length, 1);
          expect(actualGeneratedPassword.randomCharacterCount, 1);
          expect(actualGeneratedPassword.checksumCharacterCount, 0);
        },
      );

      test(
        'Should [return password with one random character and one checksum character] if requested length is [18]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(18);

          // Assert
          expect(actualGeneratedPassword.password.length, 18);
          expect(actualGeneratedPassword.randomCharacterCount, 18);
          expect(actualGeneratedPassword.checksumCharacterCount, 0);
        },
      );

      test(
        'Should [return password with one random character and one checksum character] if requested length is [20]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(20);

          // Assert
          expect(actualGeneratedPassword.password.length, 20);
          expect(actualGeneratedPassword.randomCharacterCount, 20);
          expect(actualGeneratedPassword.checksumCharacterCount, 0);
        },
      );

      test(
        'Should [return password with one random character and one checksum character] if requested length is [40]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(40);

          // Assert
          expect(actualGeneratedPassword.password.length, 40);
          expect(actualGeneratedPassword.randomCharacterCount, 40);
          expect(actualGeneratedPassword.checksumCharacterCount, 0);
        },
      );
    });

    group('Tests of generating password with SIP-2 dictionary', () {
      test('Should [throw ArgumentError] if requested length is [NEGATIVE]', () {
        // Arrange
        PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2(random: Random.secure());

        // Assert
        expect(
          () => actualPasswordGenerator.generate(-1),
          throwsA(isA<ArgumentError>()),
        );
      });

      test(
        'Should [throw ArgumentError] if requested length is [0]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2(random: Random.secure());

          // Assert
          expect(
            () => actualPasswordGenerator.generate(0),
            throwsA(isA<ArgumentError>()),
          );
        },
      );

      test(
        'Should [throw ArgumentError] if requested length is [1]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2(random: Random.secure());

          // Assert
          expect(
            () => actualPasswordGenerator.generate(1),
            throwsA(isA<ArgumentError>()),
          );
        },
      );

      test(
        'Should [return password with one random character and one checksum character] if requested length is [2]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(2);

          // Assert
          expect(actualGeneratedPassword.password.length, 2);
          expect(actualGeneratedPassword.randomCharacterCount, 1);
          expect(actualGeneratedPassword.checksumCharacterCount, 1);
        },
      );

      test(
        'Should [return password with one random character and one checksum character] if requested length is [18]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(18);

          // Assert
          expect(actualGeneratedPassword.password.length, 18);
          expect(actualGeneratedPassword.randomCharacterCount, 17);
          expect(actualGeneratedPassword.checksumCharacterCount, 1);
        },
      );

      test(
        'Should [return password with one random character and one checksum character] if requested length is [19]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(19);

          // Assert
          expect(actualGeneratedPassword.password.length, 19);
          expect(actualGeneratedPassword.randomCharacterCount, 18);
          expect(actualGeneratedPassword.checksumCharacterCount, 1);
        },
      );

      test(
        'Should [return password with one random character and one checksum character] if requested length is [20]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(20);

          // Assert
          expect(actualGeneratedPassword.password.length, 20);
          expect(actualGeneratedPassword.randomCharacterCount, 19);
          expect(actualGeneratedPassword.checksumCharacterCount, 1);
        },
      );

      test(
        'Should [return password with one random character and one checksum character] if requested length is [21]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(21);

          // Assert
          expect(actualGeneratedPassword.password.length, 21);
          expect(actualGeneratedPassword.randomCharacterCount, 19);
          expect(actualGeneratedPassword.checksumCharacterCount, 2);
        },
      );

      test(
        'Should [return password] with one checksum character if requested length is [22]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2(random: Random.secure());

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(22);

          // Assert
          expect(actualGeneratedPassword.password.length, 22);
          expect(actualGeneratedPassword.randomCharacterCount, 20);
          expect(actualGeneratedPassword.checksumCharacterCount, 2);
        },
      );
    });
  });
}
