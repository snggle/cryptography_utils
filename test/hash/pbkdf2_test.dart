import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of PBKDF2.process()', () {
    test('Should [return 32-bytes hash] constructed from given password and salt', () {
      // Arrange
      PBKDF2 actualPBKDF2 = PBKDF2(outputLength: 32);
      Uint8List actualPassword = base64Decode('bWVkaWEgc2VtaW5hciBzZW1pbmFyIGdlbnRsZSBzdHVtYmxlIHNtb290aCBzYWxvbiB6ZWJyYSB2aXN1YWwgZ2FzcCB1c3VhbCByb3VnaA==');
      Uint8List actualSalt = base64Decode('bW5lbW9uaWM=');

      // Act
      Uint8List actualHash = actualPBKDF2.process(actualPassword, actualSalt);

      // Assert
      Uint8List expectedHash = base64Decode('PR2YNJm2i+sQ37pVigrZ/DjPLHDI/7/ZvSybQ3A3xLU=');

      expect(actualHash, expectedHash);
    });

    test('Should [return 64-bytes hash] constructed from given password and salt', () {
      // Arrange
      PBKDF2 actualPBKDF2 = PBKDF2(outputLength: 64);
      Uint8List actualPassword = base64Decode('bWVkaWEgc2VtaW5hciBzZW1pbmFyIGdlbnRsZSBzdHVtYmxlIHNtb290aCBzYWxvbiB6ZWJyYSB2aXN1YWwgZ2FzcCB1c3VhbCByb3VnaA==');
      Uint8List actualSalt = base64Decode('bW5lbW9uaWM=');

      // Act
      Uint8List actualHash = actualPBKDF2.process(actualPassword, actualSalt);

      // Assert
      Uint8List expectedHash = base64Decode('PR2YNJm2i+sQ37pVigrZ/DjPLHDI/7/ZvSybQ3A3xLUcpCNtGeISOJUU1mDv3AIbDjtWvCKWzJWgm5QpB0WD9g==');

      expect(actualHash, expectedHash);
    });
  });
}
