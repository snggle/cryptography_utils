import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of MnemonicSize.entropyBytesSize getter', () {
    test('Should [return bytes size] for 12-word mnemonic', () {
      // Arrange
      MnemonicSize actualMnemonicSize = MnemonicSize.words12;

      // Act
      int actualEntropyBytesSize = actualMnemonicSize.entropyBytesSize;

      // Assert
      int expectedEntropyBytesSize = 16;
      expect(actualEntropyBytesSize, expectedEntropyBytesSize);
    });

    test('Should [return bytes size] for 15-word mnemonic', () {
      // Arrange
      MnemonicSize actualMnemonicSize = MnemonicSize.words15;

      // Act
      int actualEntropyBytesSize = actualMnemonicSize.entropyBytesSize;

      // Assert
      int expectedEntropyBytesSize = 20;
      expect(actualEntropyBytesSize, expectedEntropyBytesSize);
    });

    test('Should [return bytes size] for 18-word mnemonic', () {
      // Arrange
      MnemonicSize actualMnemonicSize = MnemonicSize.words18;

      // Act
      int actualEntropyBytesSize = actualMnemonicSize.entropyBytesSize;

      // Assert
      int expectedEntropyBytesSize = 24;
      expect(actualEntropyBytesSize, expectedEntropyBytesSize);
    });

    test('Should [return bytes size] for 21-word mnemonic', () {
      // Arrange
      MnemonicSize actualMnemonicSize = MnemonicSize.words21;

      // Act
      int actualEntropyBytesSize = actualMnemonicSize.entropyBytesSize;

      // Assert
      int expectedEntropyBytesSize = 28;
      expect(actualEntropyBytesSize, expectedEntropyBytesSize);
    });

    test('Should [return bytes size] for 24-word mnemonic', () {
      // Arrange
      MnemonicSize actualMnemonicSize = MnemonicSize.words24;

      // Act
      int actualEntropyBytesSize = actualMnemonicSize.entropyBytesSize;

      // Assert
      int expectedEntropyBytesSize = 32;
      expect(actualEntropyBytesSize, expectedEntropyBytesSize);
    });
  });
}
