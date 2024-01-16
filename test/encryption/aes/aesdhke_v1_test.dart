import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  // Arrange
  String actualPassword = 'cryptoTest123';
  String actualStringToEncrypt = 'crypto_test';

  Ciphertext actualCiphertext = Ciphertext.fromBase64(
    base64: 'XkmyBG4SOGfyl2Mx1HJCnVpiQMOY2pKOv5UZtAswVUX4BxZf',
    encryptionAlgorithmType: EncryptionAlgorithmType.aesdhke,
  );

  String expectedDecryptedString = 'crypto_test';

  group('Tests of AESDHKEV1.encrypt()', () {
    test('Should [return AESDHKEV1 Ciphertext] verify it using decrypt method', () async {
      // Act
      Ciphertext actualCiphertext = AESDHKEV1().encrypt(actualPassword, actualStringToEncrypt);

      // Output is always a random string because AES changes the initialization vector with Random Secure
      // and we cannot match the hardcoded expected result. That's why we check whether it is possible to encode and decode text
      String actualDecryptedString = AESDHKEV1().decrypt(actualPassword, actualCiphertext);

      // Assert
      expect(actualDecryptedString, expectedDecryptedString);
    });
  });

  group('Tests of AESDHKEV1.decrypt()', () {
    test('Should [return plaintext] decrypted from given hash using AESDHKE algorithm', () async {
      // Act
      String actualDecryptedString = AESDHKEV1().decrypt(actualPassword, actualCiphertext);

      // Assert
      expect(actualDecryptedString, expectedDecryptedString);
    });

    test('Should [throw ArgumentError] if password is not correct', () {
      // Assert
      expect(
        () => AESDHKEV1().decrypt('incorrect_password', actualCiphertext),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Tests of AESDHKEV1.isPasswordValid()', () {
    test('Should [return TRUE] if [password CORRECT]', () async {
      // Act
      bool actualPasswordValid = AESDHKEV1().isPasswordValid(actualPassword, actualCiphertext);

      // Assert
      expect(actualPasswordValid, true);
    });

    test('Should [return FALSE] if [password INCORRECT]', () async {
      // Act
      bool actualPasswordValid = AESDHKEV1().isPasswordValid('incorrect_password', actualCiphertext);

      // Assert
      expect(actualPasswordValid, false);
    });
  });
}
