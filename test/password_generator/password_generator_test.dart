import 'package:cryptography_utils/src/password_generator/character_set_type.dart';
import 'package:cryptography_utils/src/password_generator/password.dart';
import 'package:cryptography_utils/src/password_generator/password_generator.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Sip2PasswordGenerator.generate()', () {
    group('Tests of generating password with non-whitespace ASCII dictionary', () {
      test('Should [throw ArgumentError] if requested [ASCII] password length is [NEGATIVE]', () {
        // Arrange
        PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii();

        // Assert
        expect(
          () => actualPasswordGenerator.generate(-1),
          throwsA(isA<ArgumentError>()),
        );
      });

      test(
        'Should [throw ArgumentError] if requested [ASCII] password length is [0]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii();

          // Assert
          expect(
            () => actualPasswordGenerator.generate(0),
            throwsA(isA<ArgumentError>()),
          );
        },
      );

      test(
        'Should [return Password] with [1] random character and [0] checksum characters if requested [ASCII] password length is [1]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii();

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(1);

          // Assert
          expect(actualGeneratedPassword.password.length, 1);
          expect(actualGeneratedPassword.randomCharacterCount, 1);
          expect(actualGeneratedPassword.checksumCharacterCount, 0);
          expect(actualGeneratedPassword.characterSetType, CharacterSetType.ascii);
          expect(actualGeneratedPassword.entropy, 6.554588851677638);
        },
      );

      test(
        'Should [return Password] with [18] random character and [0] checksum characters if requested [ASCII] password length is [18]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii();

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(18);

          // Assert
          expect(actualGeneratedPassword.password.length, 18);
          expect(actualGeneratedPassword.randomCharacterCount, 18);
          expect(actualGeneratedPassword.checksumCharacterCount, 0);
          expect(actualGeneratedPassword.entropy, 117.98259933019747);
        },
      );

      test(
        'Should [return Password] with [20] random character and [0] checksum characters if requested [ASCII] password length is [20]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii();

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(20);

          // Assert
          expect(actualGeneratedPassword.password.length, 20);
          expect(actualGeneratedPassword.randomCharacterCount, 20);
          expect(actualGeneratedPassword.checksumCharacterCount, 0);
          expect(actualGeneratedPassword.entropy, 131.09177703355275);
        },
      );

      test(
        'Should [return Password] with [40] random character and [0] checksum characters if requested [ASCII] password length is [40]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.ascii();

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(40);

          // Assert
          expect(actualGeneratedPassword.password.length, 40);
          expect(actualGeneratedPassword.randomCharacterCount, 40);
          expect(actualGeneratedPassword.checksumCharacterCount, 0);
          expect(actualGeneratedPassword.entropy, 262.1835540671055);
        },
      );
    });

    group('Tests of generating password with SIP-2 dictionary', () {
      test('Should [throw ArgumentError] if requested [SIP-2] password length is [1]', () {
        // Arrange
        PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2();

        // Assert
        expect(
          () => actualPasswordGenerator.generate(-1),
          throwsA(isA<ArgumentError>()),
        );
      });

      test(
        'Should [throw ArgumentError] if requested [SIP-2] password length is [0]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2();

          // Assert
          expect(
            () => actualPasswordGenerator.generate(0),
            throwsA(isA<ArgumentError>()),
          );
        },
      );

      test(
        'Should [throw ArgumentError] if requested [SIP-2] password length is [1]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2();

          // Assert
          expect(
            () => actualPasswordGenerator.generate(1),
            throwsA(isA<ArgumentError>()),
          );
        },
      );

      test(
        'Should [return Password] with [1] random character and [1] checksum characters if requested [SIP-2] password length is [2]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2();

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(2);

          // Assert
          expect(actualGeneratedPassword.password.length, 2);
          expect(actualGeneratedPassword.randomCharacterCount, 1);
          expect(actualGeneratedPassword.checksumCharacterCount, 1);
          expect(actualGeneratedPassword.characterSetType, CharacterSetType.sip2);
          expect(actualGeneratedPassword.entropy, 6);
        },
      );

      test(
        'Should [return Password] with [19] random character and [1] checksum characters if requested [SIP-2] password length is [20]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2();

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(20);

          // Assert
          expect(actualGeneratedPassword.password.length, 20);
          expect(actualGeneratedPassword.randomCharacterCount, 19);
          expect(actualGeneratedPassword.checksumCharacterCount, 1);
          expect(actualGeneratedPassword.entropy, 114);
        },
      );

      test(
        'Should [return Password] with [19] random character and [2] checksum characters if requested [SIP-2] password length is [21]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2();

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(21);

          // Assert
          expect(actualGeneratedPassword.password.length, 21);
          expect(actualGeneratedPassword.randomCharacterCount, 19);
          expect(actualGeneratedPassword.checksumCharacterCount, 2);
          expect(actualGeneratedPassword.entropy, 114);
        },
      );

      test(
        'Should [return Password] with [20] random character and [2] checksum characters if requested [SIP-2] password length is [22]',
        () {
          // Arrange
          PasswordGenerator actualPasswordGenerator = PasswordGenerator.sip2();

          // Act
          Password actualGeneratedPassword = actualPasswordGenerator.generate(22);

          // Assert
          expect(actualGeneratedPassword.password.length, 22);
          expect(actualGeneratedPassword.randomCharacterCount, 20);
          expect(actualGeneratedPassword.checksumCharacterCount, 2);
          expect(actualGeneratedPassword.entropy, 120);
        },
      );
    });
  });
}
