import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Bech32Encoder.encode()', () {
    test('Should [return String] encoded by Bech32', () {
      // Arrange
      Uint8List actualDataToEncode = base64Decode('KxmiVli7oFEs8N5rjnzLtw7eym0=');

      // Act
      String actualEncodedData = Bech32Encoder.encode('crypto', actualDataToEncode);

      // Assert
      String expectedEncodedData = 'crypto19vv6y4jchws9zt8sme4culxtku8dajndgyhdm2';

      expect(actualEncodedData, expectedEncodedData);
    });
  });
}
