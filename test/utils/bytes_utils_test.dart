import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/utils/bytes_utils.dart';
import 'package:test/test.dart';

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

  group('Tests of BytesUtils.chunkBytes()', () {
    test('Should [return chunked bytes] with specified chunk sized', () {
      // Arrange
      Uint8List actualBytesToChunk = Uint8List.fromList(<int>[1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6]);
      List<int> actualChunkSizes = <int>[1, 2, 3, 4, 5, 6];

      // Act
      List<Uint8List> actualChunkedBytes = BytesUtils.chunkBytes(bytes: actualBytesToChunk, chunkSizes: actualChunkSizes);

      // Assert
      List<Uint8List> expectedChunkedBytes = <Uint8List>[
        Uint8List.fromList(<int>[1]),
        Uint8List.fromList(<int>[2, 2]),
        Uint8List.fromList(<int>[3, 3, 3]),
        Uint8List.fromList(<int>[4, 4, 4, 4]),
        Uint8List.fromList(<int>[5, 5, 5, 5, 5]),
        Uint8List.fromList(<int>[6, 6, 6, 6, 6, 6]),
      ];

      expect(actualChunkedBytes, expectedChunkedBytes);
    });
  });
}
