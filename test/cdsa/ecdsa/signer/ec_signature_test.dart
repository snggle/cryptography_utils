import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of ECSignature.fromBase64() constructor', () {
    test('Should [return ECSignature] constructed from base64 String', () {
      // Arrange
      String actualSignature = 'pdDhYhioe7vKtGcmyLDP0m8qbeHwOy7R8WprnKWDpztSVKTWrNfxeJk8Zo9qd7Ef2IFeIej8RJN+YO+a+lDoRw==';

      // Act
      ECSignature actualECSignature = ECSignature.fromBase64(actualSignature);

      // Assert
      ECSignature expectedECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      expect(actualECSignature, expectedECSignature);
    });
  });

  group('Tests of ECSignature.fromBytes() constructor', () {
    test('Should [return ECSignature] constructed from bytes', () {
      // Arrange
      String actualSignature = 'pdDhYhioe7vKtGcmyLDP0m8qbeHwOy7R8WprnKWDpztSVKTWrNfxeJk8Zo9qd7Ef2IFeIej8RJN+YO+a+lDoRw==';
      Uint8List actualSignatureBytes = base64Decode(actualSignature);

      // Act
      ECSignature actualECSignature = ECSignature.fromBytes(actualSignatureBytes);

      // Assert
      ECSignature expectedECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      expect(actualECSignature, expectedECSignature);
    });
  });

  group('Tests of ECSignature.base64 getter', () {
    test('Should [return String] representing signature in base64 format', () {
      // Arrange
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      // Act
      String actualSignature = actualECSignature.base64;

      // Assert
      String expectedSignature = 'pdDhYhioe7vKtGcmyLDP0m8qbeHwOy7R8WprnKWDpztSVKTWrNfxeJk8Zo9qd7Ef2IFeIej8RJN+YO+a+lDoRw==';

      expect(actualSignature, expectedSignature);
    });
  });

  group('Tests of ECSignature.bytes getter', () {
    test('Should [return List<int>] representing signature as bytes', () {
      // Arrange
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      // Act
      List<int> actualSignatureBytes = actualECSignature.bytes;

      // Assert
      String expectedSignature = 'pdDhYhioe7vKtGcmyLDP0m8qbeHwOy7R8WprnKWDpztSVKTWrNfxeJk8Zo9qd7Ef2IFeIej8RJN+YO+a+lDoRw==';
      Uint8List expectedSignatureBytes = base64Decode(expectedSignature);

      expect(actualSignatureBytes, expectedSignatureBytes);
    });
  });

  group('Tests of ECSignature.length getter', () {
    test('Should [return integer] representing signature length', () {
      // Arrange
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      // Act
      int actualSignatureLength = actualECSignature.length;

      // Assert
      int expectedSignatureLength = 64;

      expect(actualSignatureLength, expectedSignatureLength);
    });
  });
}
