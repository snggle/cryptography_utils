import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/export.dart';
import 'package:test/test.dart';

void main() {
  group('SolanaPubKey.fromBytes()', () {
    test('Should [return SolanaPubKey] from bytes', () {
      // Act
      SolanaPubKey actualSolanaPubKey = SolanaPubKey.fromBytes(base64Decode('FvHsWcITjSSy666/XikzqLiO11a0SwY8rT5d3C+q84s='));

      // Assert
      SolanaPubKey expectedSolanaPubKey = SolanaPubKey(base64Decode('FvHsWcITjSSy666/XikzqLiO11a0SwY8rT5d3C+q84s='));

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
      // Act
      SolanaPubKey actualSolanaPubKey = SolanaPubKey.fromBase58('2YZvo6LkePK8V2G2ZaS8UxBYX2Ph6udCu5iuaYAqVM38');

      // Assert
      SolanaPubKey expectedSolanaPubKey = SolanaPubKey(base64Decode('FvHsWcITjSSy666/XikzqLiO11a0SwY8rT5d3C+q84s='));

      expect(actualSolanaPubKey, expectedSolanaPubKey);
    });
  });
}
