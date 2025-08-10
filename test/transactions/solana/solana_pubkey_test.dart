import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/export.dart';
import 'package:test/test.dart';

void main() {
  group('SolanaPubKey.fromBytes()', () {
    test('Should [return SolanaPubKey] from bytes', () {
      // Arrange
      Uint8List actualBytes = Uint8List.fromList(List<int>.generate(32, (int i) => i));

      // Act
      SolanaPubKey actualSolanaPubKey = SolanaPubKey.fromBytes(actualBytes);

      // Assert
      SolanaPubKey expectedSolanaPubKey = SolanaPubKey(actualBytes);
      expect(actualSolanaPubKey, expectedSolanaPubKey);
    });

    test('Should [throw Exception] when bytes length is not 32', () {
      // Arrange
      Uint8List actualBytes = Uint8List.fromList(List<int>.generate(31, (int i) => i));

      // Assert
      expect(() => SolanaPubKey.fromBytes(actualBytes), throwsA(isA<Exception>()));
    });
  });

  group('SolanaPubKey.fromBase58()', () {
    test('Should [return SolanaPubKey] from base58 string', () {
      // Arrange
      Uint8List actualBytes = Uint8List(32);
      String actualBase58String = Base58Codec.encode(actualBytes);

      // Act
      SolanaPubKey actualSolanaPubKey = SolanaPubKey.fromBase58(actualBase58String);

      // Assert
      SolanaPubKey expectedSolanaPubKey = SolanaPubKey(actualBytes);
      expect(actualSolanaPubKey, expectedSolanaPubKey);
    });
  });
}
