import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/blake2b.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Blake2d.process()', () {
    test('Should [return Blake2d HASH] constructed from given data', () {
      // Arrange
      Uint8List actualDataToHash = Uint8List.fromList('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~'.codeUnits);

      // Act
      Uint8List actualBlake2dResult = Blake2d().process(actualDataToHash);

      // Assert
      Uint8List expectedBlake2dResult = base64Decode('IYnqbSZrn6rbW5Yq5UtXu4CqhpL+kt+b/KVHyt5SAEJBLb2Htw12p53brHc6LTMtPAWdD4uZF/jxsQn5Xt1xcw==');

      expect(actualBlake2dResult, expectedBlake2dResult);
    });
  });
}
