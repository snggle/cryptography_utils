import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Uint8List asciiCodeBytes = Uint8List.fromList('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~'.codeUnits);
  String hexLowercase =
      '3132333435363738393a3b3c3d3e3f404142434445464748494a4b4c4d4e4f505152535455565758595a5b5d5e5f606162636465666768696a6b6c6d6e6f707172737475767778797a7b7c7d7e';
  String hexUppercase =
      '3132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E';

  group('Tests of HexEncoder.encode()', () {
    test('Should [return UPPERCASE hexadecimal] from given bytes', () {
      Uint8List actualDataToEncode = asciiCodeBytes;

      // Act
      String actualHexResult = HexEncoder.encode(actualDataToEncode, lowercaseBool: false);

      // Assert
      String expectedHexResult = hexUppercase;

      expect(actualHexResult, expectedHexResult);
    });

    test('Should [return LOWERCASE hexadecimal] from given bytes', () {
      Uint8List actualDataToEncode = asciiCodeBytes;

      // Act
      String actualHexResult = HexEncoder.encode(actualDataToEncode, lowercaseBool: true);

      // Assert
      String expectedHexResult = hexLowercase;

      expect(actualHexResult, expectedHexResult);
    });
  });

  group('Tests of HexEncoder.decode()', () {
    test('Should [return Uint8List] decoded from given [UPPERCASE hexadecimal] [with 0x prefix]', () {
      // Arrange
      String actualHexToDecode = hexUppercase;

      // Act
      Uint8List actualDecodedHexResult = HexEncoder.decode('0x$actualHexToDecode');

      // Assert
      Uint8List expectedDecodedHexResult = asciiCodeBytes;

      expect(actualDecodedHexResult, expectedDecodedHexResult);
    });

    test('Should [return Uint8List] decoded from given [UPPERCASE hexadecimal] [without 0x prefix]', () {
      // Arrange
      String actualHexToDecode = hexUppercase;

      // Act
      Uint8List actualDecodedHexResult = HexEncoder.decode(actualHexToDecode);

      // Assert
      Uint8List expectedDecodedHexResult = asciiCodeBytes;

      expect(actualDecodedHexResult, expectedDecodedHexResult);
    });

    test('Should [return Uint8List] decoded from given [LOWERCASE hexadecimal] [with 0x prefix]', () {
      // Arrange
      String actualHexToDecode = hexLowercase;

      // Act
      Uint8List actualDecodedHexResult = HexEncoder.decode('0x$actualHexToDecode');

      // Assert
      Uint8List expectedDecodedHexResult = asciiCodeBytes;

      expect(actualDecodedHexResult, expectedDecodedHexResult);
    });

    test('Should [return Uint8List] decoded from given [LOWERCASE hexadecimal] [without 0x prefix]', () {
      // Arrange
      String actualHexToDecode = hexLowercase;

      // Act
      Uint8List actualDecodedHexResult = HexEncoder.decode(actualHexToDecode);

      // Assert
      Uint8List expectedDecodedHexResult = asciiCodeBytes;

      expect(actualDecodedHexResult, expectedDecodedHexResult);
    });
  });

  group('Tests of HexEncoder.isHex()', () {
    test('Should [return TRUE] if given value is [UPPERCASE hexadecimal] [with 0x prefix]', () {
      // Arrange
      String actualHexToCheck = '0x$hexUppercase';

      // Act
      bool actualHexBool = HexEncoder.isHex(actualHexToCheck);

      // Assert
      bool expectedHexBool = true;

      expect(actualHexBool, expectedHexBool);
    });

    test('Should [return TRUE] if given value is [UPPERCASE hexadecimal] [without 0x prefix]', () {
      // Arrange
      String actualHexToCheck = hexUppercase;

      // Act
      bool actualHexBool = HexEncoder.isHex(actualHexToCheck);

      // Assert
      bool expectedHexBool = true;

      expect(actualHexBool, expectedHexBool);
    });

    test('Should [return TRUE] if given value is [LOWERCASE hexadecimal] [with 0x prefix]', () {
      // Arrange
      String actualHexToCheck = '0x$hexLowercase';

      // Act
      bool actualHexBool = HexEncoder.isHex(actualHexToCheck);

      // Assert
      bool expectedHexBool = true;

      expect(actualHexBool, expectedHexBool);
    });

    test('Should [return TRUE] if given value is [LOWERCASE hexadecimal] [without 0x prefix]', () {
      // Arrange
      String actualHexToCheck = hexLowercase;

      // Act
      bool actualHexBool = HexEncoder.isHex(actualHexToCheck);

      // Assert
      bool expectedHexBool = true;

      expect(actualHexBool, expectedHexBool);
    });

    test('Should [return FALSE] if given value is [NOT hexadecimal]', () {
      // Arrange
      String actualHexToCheck = 'random string';

      // Act
      bool actualHexBool = HexEncoder.isHex(actualHexToCheck);

      // Assert
      bool expectedHexBool = false;

      expect(actualHexBool, expectedHexBool);
    });
  });
}
