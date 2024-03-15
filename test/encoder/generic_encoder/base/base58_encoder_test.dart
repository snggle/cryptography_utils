import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of Base58Encoder.encode()', () {
    test('Should [return String] encoded by Base58', () {
      // Arrange
      Uint8List actualDataToEncode = base64Decode('Q1JZUFRP');

      // Act
      String actualBase58Result = Base58Encoder.encode(actualDataToEncode);

      // Assert
      String expectedBase58Result = 'aXQWBu6W';

      expect(actualBase58Result, expectedBase58Result);
    });

    test('Should [return String] encoded by Base58 (with checksum)', () {
      // Arrange
      Uint8List actualDataToEncode = base64Decode('Q1JZUFRP');

      // Act
      String actualBase58Result = Base58Encoder.encodeWithChecksum(actualDataToEncode);

      // Assert
      String expectedBase58Result = '4nNW8qCqV3i7VY';

      expect(actualBase58Result, expectedBase58Result);
    });
  });

  group('Tests of Base58Encoder.decode()', () {
    test('Should [return String] encoded by Base58', () {
      // Arrange
      String actualBase58 = 'aXQWBu6W';

      // Act
      Uint8List actualDecodedData = Base58Encoder.decode(actualBase58);

      // Assert
      Uint8List expectedDecodedData = base64Decode('Q1JZUFRP');

      expect(actualDecodedData, expectedDecodedData);
    });

    test('Should [return String] encoded by Base58 (with checksum)', () {
      // Arrange
      String actualBase58 = '4nNW8qCqV3i7VY';

      // Act
      Uint8List actualDecodedData = Base58Encoder.decode(actualBase58);

      // Assert
      Uint8List expectedDecodedData = base64Decode('Q1JZUFRPndAu1w==');

      expect(actualDecodedData, expectedDecodedData);
    });
  });
}
