import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSignature.fromBytes factory', () {
    test('Should [return SolanaSignature] from valid bytes', () {
      // Act
      SolanaSignature actualSolanaSignature =
          SolanaSignature.fromBytes(base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDb1RB5jkG7OW7SfOGXWAYr3taQoOXmN2phFKFqsY2fnBA=='));

      // Assert
      SolanaSignature expectedSolanaSignature = SolanaSignature(
          r: Uint8List.fromList(
              base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDb1RB5jkG7OW7SfOGXWAYr3taQoOXmN2phFKFqsY2fnBA==').sublist(0, 32)),
          s: Uint8List.fromList(
              base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDb1RB5jkG7OW7SfOGXWAYr3taQoOXmN2phFKFqsY2fnBA==').sublist(32, 64)));

      expect(actualSolanaSignature, expectedSolanaSignature);
    });

    test('Should [throw FormatException] when bytes length is not 64', () {
      // Arrange
      List<int> expectedSolanaSignatureBytes = List<int>.filled(32, 1);

      // Assert
      expect(() => SolanaSignature.fromBytes(expectedSolanaSignatureBytes), throwsFormatException);
    });
  });

  group('Tests of SolanaSignature.bytes getter', () {
    test('Should [return bytes] representing a SolanaSignature', () {
      // Arrange
      SolanaSignature actualSolanaSignature =
          SolanaSignature.fromBytes(base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDb1RB5jkG7OW7SfOGXWAYr3taQoOXmN2phFKFqsY2fnBA=='));

      // Act
      Uint8List actualSolanaSignatureBytes = actualSolanaSignature.bytes;

      // Assert
      List<int> expectedSolanaSignatureBytes =
          base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDb1RB5jkG7OW7SfOGXWAYr3taQoOXmN2phFKFqsY2fnBA==');

      expect(actualSolanaSignatureBytes, expectedSolanaSignatureBytes);
    });
  });
}
