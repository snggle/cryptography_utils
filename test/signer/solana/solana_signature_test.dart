import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSignature constructor', () {
    test('Should [return SolanaSignature] when given 64 bytes', () {
      // Arrange
      List<int> expectedSolanaSignatureBytes = List<int>.generate(64, (int i) => i);

      // Act
      SolanaSignature actualSolanaSignature = SolanaSignature.fromBytes(expectedSolanaSignatureBytes);

      // Assert
      Uint8List actualSolanaSignatureBytes = actualSolanaSignature.bytes;

      expect(actualSolanaSignatureBytes, expectedSolanaSignatureBytes);
    });

    test('Should [throw FormatException] when given <64 bytes', () {
      // Arrange
      List<int> expectedSolanaSignatureBytes = List<int>.generate(63, (int i) => i);

      // Assert
      expect(() => SolanaSignature.fromBytes(expectedSolanaSignatureBytes), throwsFormatException);
    });

    test('Should [throw FormatException] when given >64 bytes', () {
      // Arrange
      List<int> expectedSolanaSignatureBytes = List<int>.generate(65, (int i) => i);

      // Assert
      expect(() => SolanaSignature.fromBytes(expectedSolanaSignatureBytes), throwsFormatException);
    });
  });

  group('Tests of SolanaSignature.fromBytes factory', () {
    test('Should [return SolanaSignature] from valid bytes', () {
      // Arrange
      List<int> expectedSolanaSignatureBytes = List<int>.filled(64, 42);

      // Act
      SolanaSignature actualSolanaSignature = SolanaSignature.fromBytes(expectedSolanaSignatureBytes);

      // Assert
      Uint8List actualSolanaSignatureBytes = actualSolanaSignature.bytes;

      expect(actualSolanaSignatureBytes, expectedSolanaSignatureBytes);
    });

    test('Should [throw FormatException] when bytes not 64 length', () {
      // Arrange
      List<int> expectedSolanaSignatureBytes = List<int>.filled(32, 1);

      // Assert
      expect(() => SolanaSignature.fromBytes(expectedSolanaSignatureBytes), throwsFormatException);
    });
  });

  group('Tests of SolanaSignature.bytes getter', () {
    test('Should [return bytes]', () {
      // Arrange
      List<int> expectedSolanaSignatureBytes = List<int>.generate(64, (int i) => i);
      SolanaSignature actualSolanaSignature = SolanaSignature.fromBytes(expectedSolanaSignatureBytes);

      // Act
      Uint8List actualSolanaSignatureBytes = actualSolanaSignature.bytes;

      // Assert
      expect(actualSolanaSignatureBytes, expectedSolanaSignatureBytes);
    });
  });
}
