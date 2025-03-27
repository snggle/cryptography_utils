import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/cipher/padded_block_cipher/pkcs7_padding.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Arrange
  late Pkcs7Padding pkcs7Padding;

  setUp(() {
    pkcs7Padding = Pkcs7Padding();
  });

  group('Tests of Pkcs7Padding.addPadding()', () {
    test('Should [return paddingSize] constructed from given data', () {
      // Arrange
      Uint8List actualUint8List = Uint8List(16)..setAll(0, <int>[1, 2, 3, 4, 5, 6, 7, 8]);

      // Act
      int actualLengthPaddingSize = pkcs7Padding.addPadding(actualUint8List, 8);

      // Assert
      int expectedLengthPaddingSize = 8;
      expect(actualLengthPaddingSize, expectedLengthPaddingSize);
    });
  });

  group('Tests of Pkcs7Padding.paddingCount()', () {
    test('Should [return count padding] constructed from given data', () {
      // Arrange
      Uint8List actualPaddedUint8List = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8]);

      // Act
      int actualCount = pkcs7Padding.paddingCount(actualPaddedUint8List);

      // Assert
      int expectedCount = 8;
      expect(actualCount, expectedCount);
    });
  });
}
