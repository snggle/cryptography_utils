import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of BytesUtils.changeToOctetsWithOrderPadding()', () {
    test('Should [return UNCHANGED bytes] if [bytes length EQUAL] scalar length', () {
      // Arrange
      List<int> actualBytes = base64Decode('ZOyIygCyaOW6GjVnihtTFtIS9PNmskdyMlNKiuyjfzw=');
      BigInt actualScalar = BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337');

      // Act
      List<int> actualPaddedBytes = BytesUtils.changeToOctetsWithOrderPadding(actualBytes, actualScalar);

      // Assert
      List<int> expectedPaddedBytes = base64Decode('ZOyIygCyaOW6GjVnihtTFtIS9PNmskdyMlNKiuyjfzw=');

      expect(actualPaddedBytes, expectedPaddedBytes);
    });

    test('Should [return PADDED bytes] if [bytes length GREATER] than scalar length', () {
      // Arrange
      List<int> actualBytes = base64Decode('Qml0Y29pbiBzZWVk');
      BigInt actualScalar = BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337');

      // Act
      List<int> actualPaddedBytes = BytesUtils.changeToOctetsWithOrderPadding(actualBytes, actualScalar);

      // Assert
      List<int> expectedPaddedBytes = base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAABCaXRjb2luIHNlZWQ=');

      expect(actualPaddedBytes, expectedPaddedBytes);
    });

    test('Should [return TRIMMED bytes] if [bytes length LESS] than scalar length', () {
      // Arrange
      List<int> actualBytes = base64Decode(
          'ZXhjbHVkZSB3ZXN0IG5vYmxlIHB1cml0eSBiZXlvbmQgaWxsbmVzcyBzb3VwIHJlc2VtYmxlIGF0b20gb2J2aW91cyBtZXRob2QgZmVzdGl2YWwgbmFtZSBpZGVudGlmeSBlbGVwaGFudCBzYXRpc2Z5IHdlZGRpbmcgaG9uZXkgY2VydGFpbiB0b2UgZXJvZGU=');

      BigInt actualScalar = BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337');

      // Act
      List<int> actualPaddedBytes = BytesUtils.changeToOctetsWithOrderPadding(actualBytes, actualScalar);

      // Assert
      List<int> expectedPaddedBytes = base64Decode('ZXhjbHVkZSB3ZXN0IG5vYmxlIHB1cml0eSBiZXlvbmQ=');

      expect(actualPaddedBytes, expectedPaddedBytes);
    });
  });
}
