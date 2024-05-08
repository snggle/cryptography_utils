import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SegwitBech32Encoder.encode()', () {
    test('Should [return String] encoded by Bech32 (Segwit version)', () {
      // Arrange
      Uint8List actualDataToEncode = base64Decode('KxmiVli7oFEs8N5rjnzLtw7eym0=');

      // Act
      String actualEncodedData = SegwitBech32Encoder.encode('crypto', 0, actualDataToEncode);

      // Assert
      String expectedEncodedData = 'crypto1q9vv6y4jchws9zt8sme4culxtku8dajndgp9dmz';

      expect(actualEncodedData, expectedEncodedData);
    });
  });
}
