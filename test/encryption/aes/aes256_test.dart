import 'package:cryptography_utils/src/encryption/aes/aes256_dhke.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Arrange
  // Actual values for tests
  // TestWidgetsFlutterBinding.ensureInitialized();
  String actualPassword = 'kiraTest123';
  String actualStringToEncrypt = 'kiratest';
  String actualStringToDecrypt = 'wEQo23Uy93RU8EMf1tip5iKnq1VOdUO03cDu3X/l92xEcRLx';

  // Expected values for tests
  String expectedDecryptedString = 'kiratest';

  group('Tests of Aes256.encrypt()', () {
    // Output is always a random string because AES changes the initialization vector with Random Secure
    // and we cannot match the hardcoded expected result. That's why we check whether it is possible to encode and decode text
    test('Should correctly encrypt given string via AES256 algorithm and check with decrypt method', () async {
      // Act
      String actualEncryptedString = Aes256DHKE.encrypt(actualPassword, actualStringToEncrypt);
      String actualDecryptedString = Aes256DHKE.decrypt(actualPassword, actualEncryptedString);

      // Assert
      expect(actualDecryptedString, expectedDecryptedString);
    });
  });

  group('Tests of Aes256.decrypt()', () {
    test('Should [return STRING] decrypted from given hash via AES256 algorithm', () async {
      // Act
      String actualDecryptedString = Aes256DHKE.decrypt(actualPassword, actualStringToDecrypt);

      // Assert
      expect(actualDecryptedString, expectedDecryptedString);
    });

    test('Should [throw ArgumentError] if password is not correct', () {
      // Assert
      expect(
        () => Aes256DHKE.decrypt('incorrect_password', actualStringToDecrypt),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Tests of Aes256.isPasswordValid()', () {
    test('Should [return TRUE] if [password CORRECT]', () async {
      // Act
      bool actualPasswordValid = Aes256DHKE.isPasswordValid(actualPassword, actualStringToDecrypt);

      // Assert
      expect(actualPasswordValid, true);
    });

    test('Should [return FALSE] if [password INCORRECT]', () async {
      // Act
      bool actualPasswordValid = Aes256DHKE.isPasswordValid('incorrect_password', actualStringToDecrypt);

      // Assert
      expect(actualPasswordValid, false);
    });
  });
}
