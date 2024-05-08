import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/generic_encoder/rlp/rlp_coder.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of RLPUtils.encodeLength()', () {
    test('Should [return encoded length] for [length < 56]', () {
      // Arrange
      int actualLength = 55;
      int actualOffset = 128;

      // Act
      Uint8List actualEncodedLength = RLPUtils.encodeLength(actualLength, actualOffset);

      // Assert
      Uint8List expectedEncodedLength = Uint8List.fromList(<int>[183]);

      expect(actualEncodedLength, expectedEncodedLength);
    });

    test('Should [return encoded length] for [length >= 56]', () {
      // Arrange
      int actualLength = 56;
      int actualOffset = 128;

      // Act
      Uint8List actualEncodedLength = RLPUtils.encodeLength(actualLength, actualOffset);

      // Assert
      Uint8List expectedEncodedLength = Uint8List.fromList(<int>[184, 56]);

      expect(actualEncodedLength, expectedEncodedLength);
    });
  });
}
