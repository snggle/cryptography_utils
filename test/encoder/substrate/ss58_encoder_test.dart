import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/substrate/ss58_encoder.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SS58Encoder.encode()', () {
    test('Should [return String] encoded by SS58 algorithm', () {
      // Arrange
      Uint8List actualBytes = base64Decode('z7Dbiwy9pzyyNc8VrMNqmdssCM0tlKxB9Yk8umwbYwc=');

      // Act
      String actualEncodedString = SS58Encoder.encode(actualBytes, 0);

      // Assert
      String expectedEncodedString = '15hKT6AkcwKey5JZoxXg7yjkpxcZfSMbxjfisc1xEBh9WmiB';

      expect(actualEncodedString, expectedEncodedString);
    });
  });

  group('Tests of SS58Encoder.decode()', () {
    test('Should [return bytes] decoded from SS58 address', () {
      // Arrange
      String actualEncodedString = '15hKT6AkcwKey5JZoxXg7yjkpxcZfSMbxjfisc1xEBh9WmiB';

      // Act
      Uint8List actualBytes = SS58Encoder.decode(actualEncodedString);

      // Assert
      Uint8List expectedBytes = base64Decode('z7Dbiwy9pzyyNc8VrMNqmdssCM0tlKxB9Yk8umwbYwc=');

      expect(actualBytes, expectedBytes);
    });
  });
}
