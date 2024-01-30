import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of SecureRandom.getBytes()', () {
    test('Should [return random bytes] with given length (256) and byte size (8)', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(256, byteSize: 8);

      // Assert
      bool actualValuesInRangeBool = true;
      for (int byte in actualBytes) {
        if (byte < 0 || byte > 255) {
          actualValuesInRangeBool = false;
        }
      }

      expect(actualValuesInRangeBool, true);
    });

    test('Should [return random bytes] with given length (256) and byte size (1)', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(256, byteSize: 1);

      // Assert
      bool actualValuesInRangeBool = true;
      for (int byte in actualBytes) {
        if (byte < 0 || byte > 1) {
          actualValuesInRangeBool = false;
        }
      }

      expect(actualValuesInRangeBool, true);
    });
  });
}
