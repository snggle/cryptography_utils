import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSignature.fromBytes() constructor', () {
    test('Should [return SolanaSignature] from valid bytes', () {
      // Act
      SolanaSignature actualSolanaSignature =
          SolanaSignature.fromBytes(base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDb1RB5jkG7OW7SfOGXWAYr3taQoOXmN2phFKFqsY2fnBA=='));

      // Assert
      SolanaSignature expectedSolanaSignature = SolanaSignature(
        r: base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDY='),
        s: base64Decode('9UQeY5Buzlu0nzhl1gGK97WkKDl5jdqYRSharGNn5wQ='),
      );

      expect(actualSolanaSignature, expectedSolanaSignature);
    });

    test('Should [throw FormatException] when bytes length is not 64', () {
      // Arrange
      Uint8List actualSolanaSignatureBytes = base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDb1RB5jkG7OW7SfOGXWAYr3taQoOXmN2phFKFqsY2fn');

      // Assert
      expect(() => SolanaSignature.fromBytes(actualSolanaSignatureBytes), throwsFormatException);
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
      Uint8List expectedSolanaSignatureBytes =
          base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDb1RB5jkG7OW7SfOGXWAYr3taQoOXmN2phFKFqsY2fnBA==');

      expect(actualSolanaSignatureBytes, expectedSolanaSignatureBytes);
    });
  });

  group('Tests of SolanaSignature.base64 getter', () {
    test('Should [return base64 string] representing Solana signature', () {
      // Arrange
      SolanaSignature actualSolanaSignature = SolanaSignature(
        r: base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDY='),
        s: base64Decode('9UQeY5Buzlu0nzhl1gGK97WkKDl5jdqYRSharGNn5wQ='),
      );

      // Act
      String actualSolanaSignatureBase64 = actualSolanaSignature.base64;

      // Assert
      String expectedSolanaSignatureBase64 = 'B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDb1RB5jkG7OW7SfOGXWAYr3taQoOXmN2phFKFqsY2fnBA==';

      expect(actualSolanaSignatureBase64, expectedSolanaSignatureBase64);
    });
  });

  group('Tests of SolanaSignature.hex getter', () {
    test('Should [return HEX string] representing Solana signature', () {
      // Arrange
      SolanaSignature actualSolanaSignature = SolanaSignature(
        r: base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDY='),
        s: base64Decode('9UQeY5Buzlu0nzhl1gGK97WkKDl5jdqYRSharGNn5wQ='),
      );

      // Act
      String actualSolanaSignatureHex = actualSolanaSignature.hex;

      // Assert
      String expectedSolanaSignatureHex =
          '0x07a6dfffbfbdc5630ba9c1b4d3d21744293565f41054ba659e74e80be6fbac36f5441e63906ece5bb49f3865d6018af7b5a42839798dda9845285aac6367e704';

      expect(actualSolanaSignatureHex, expectedSolanaSignatureHex);
    });
  });

  group('Tests of SolanaSignature.length getter', () {
    test('Should [return length] of Solana signature', () {
      // Arrange
      SolanaSignature actualSolanaSignature = SolanaSignature(
        r: base64Decode('B6bf/7+9xWMLqcG009IXRCk1ZfQQVLplnnToC+b7rDY='),
        s: base64Decode('9UQeY5Buzlu0nzhl1gGK97WkKDl5jdqYRSharGNn5wQ='),
      );

      // Act
      int actualLength = actualSolanaSignature.length;

      // Assert
      int expectedLength = 64;

      expect(actualLength, expectedLength);
    });
  });
}
