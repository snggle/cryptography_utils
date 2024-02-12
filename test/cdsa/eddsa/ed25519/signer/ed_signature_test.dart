import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EDSignature.fromBase64() constructor', () {
    test('Should [return EDSignature] constructed from base64 String', () {
      // Arrange
      String actualSignature = 'abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA/M/6oyVkUoi7HF2hQpG24c3bYa0rBW5J1IcNmaOKjBA==';

      // Act
      EDSignature actualEDSignature = EDSignature.fromBase64(actualSignature);

      // Assert
      EDSignature expectedEDSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('PzP+qMlZFKIuxxdoUKRtuHN22GtKwVuSdSHDZmjiowQ='),
      );

      expect(actualEDSignature, expectedEDSignature);
    });
  });

  group('Tests of EDSignature.fromBytes() constructor', () {
    test('Should [return EDSignature] constructed from bytes', () {
      // Arrange
      String actualSignature = 'abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA/M/6oyVkUoi7HF2hQpG24c3bYa0rBW5J1IcNmaOKjBA==';
      Uint8List actualSignatureBytes = base64Decode(actualSignature);

      // Act
      EDSignature actualEDSignature = EDSignature.fromBytes(actualSignatureBytes);

      // Assert
      EDSignature expectedEDSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('PzP+qMlZFKIuxxdoUKRtuHN22GtKwVuSdSHDZmjiowQ='),
      );

      expect(actualEDSignature, expectedEDSignature);
    });
  });

  group('Tests of EDSignature.bytes getter', () {
    test('Should [return List<int>] representing signature as bytes', () {
      // Arrange
      EDSignature actualEDSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('PzP+qMlZFKIuxxdoUKRtuHN22GtKwVuSdSHDZmjiowQ='),
      );

      // Act
      List<int> actualSignatureBytes = actualEDSignature.bytes;

      // Assert
      String expectedSignature = 'abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA/M/6oyVkUoi7HF2hQpG24c3bYa0rBW5J1IcNmaOKjBA==';
      Uint8List expectedSignatureBytes = base64Decode(expectedSignature);

      expect(actualSignatureBytes, expectedSignatureBytes);
    });
  });

  group('Tests of EDSignature.base64 getter', () {
    test('Should [return String] representing signature in base64 format', () {
      // Arrange
      EDSignature actualEDSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('PzP+qMlZFKIuxxdoUKRtuHN22GtKwVuSdSHDZmjiowQ='),
      );

      // Act
      String actualSignature = actualEDSignature.base64;

      // Assert
      String expectedSignature = 'abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA/M/6oyVkUoi7HF2hQpG24c3bYa0rBW5J1IcNmaOKjBA==';

      expect(actualSignature, expectedSignature);
    });
  });

  group('Tests of EDSignature.hex getter', () {
    test('Should [return HEX] representing signature in HEX format', () {
      // Arrange
      EDSignature actualEDSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('PzP+qMlZFKIuxxdoUKRtuHN22GtKwVuSdSHDZmjiowQ='),
      );

      // Act
      String actualSignature = actualEDSignature.hex;

      // Assert
      String expectedSignature = '0x69b20c87adad9bf33266639054dcfbb8d76a7c8801affc9ee68ea7f10ca606303f33fea8c95914a22ec7176850a46db87376d86b4ac15b927521c36668e2a304';

      expect(actualSignature, expectedSignature);
    });
  });

  group('Tests of EDSignature.length getter', () {
    test('Should [return integer] representing signature length', () {
      // Arrange
      EDSignature actualEDSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('PzP+qMlZFKIuxxdoUKRtuHN22GtKwVuSdSHDZmjiowQ='),
      );

      // Act
      int actualSignatureLength = actualEDSignature.length;

      // Assert
      int expectedSignatureLength = 64;

      expect(actualSignatureLength, expectedSignatureLength);
    });
  });
}
