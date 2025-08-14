import 'package:cryptography_utils/src/encryption/aes/aes256_randomized.dart';
import 'package:cryptography_utils/src/encryption/aes/invalid_password_exception.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Arrange
  // Actual values for tests
  String actualPassword = 'xyzTest123';
  String actualStringToEncrypt = 'Abctest';
  String actualStringToDecrypt = 'MyAWit7BGm0uhMVm/rQwb9526GPVYlL8lZxio4vYMNMW3wLX';

  // Expected values for tests
  String expectedDecryptedString = 'Abctest';

  group('Tests of AES256Randomized.encrypt()', () {
    // Output is always a random string because AES changes the initialization vector with Random Secure
    // and we cannot match the hardcoded expected result. That's why we check whether it is possible to encode and decode text
    test('Should correctly encrypt given string via AES256 algorithm and check with decrypt method', () async {
      // Act
      String actualEncryptedString = AES256Randomized.encrypt(actualPassword, actualStringToEncrypt)['cipherText'] as String;
      String actualDecryptedString = AES256Randomized.decrypt(actualPassword, actualEncryptedString);

      // Assert
      expect(actualDecryptedString, expectedDecryptedString);
    });
  });

  group('Tests of AES256Randomized.decrypt()', () {
    test('Should [return STRING] decrypted from given hash via AES256 algorithm', () async {
      // Act
      String actualDecryptedString = AES256Randomized.decrypt(actualPassword, actualStringToDecrypt);

      // Assert
      expect(actualDecryptedString, expectedDecryptedString);
    });

    test('Should [throw InvalidPasswordException] if password is not correct', () {
      // Assert
      expect(
        () => AES256Randomized.decrypt('incorrect_password', actualStringToDecrypt),
        throwsA(isA<InvalidPasswordException>()),
      );
    });
  });

  group('Tests of AES256Randomized.isPasswordValid()', () {
    test('Should [return TRUE] if [password CORRECT]', () async {
      // Act
      bool actualPasswordValid = AES256Randomized.isPasswordValid(actualPassword, actualStringToDecrypt);

      // Assert
      expect(actualPasswordValid, true);
    });

    test('Should [return FALSE] if [password INCORRECT]', () async {
      // Act
      bool actualPasswordValid = AES256Randomized.isPasswordValid('incorrect_password', actualStringToDecrypt);

      // Assert
      expect(actualPasswordValid, false);
    });
  });
}
