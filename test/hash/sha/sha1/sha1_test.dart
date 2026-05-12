import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/sha1/sha1.dart';
import 'package:test/test.dart';

/// For calculating [expectedHashString] an online calculator was used: https://emn178.github.io/online-tools/sha1.html
void main() {
  group('Tests of Sha1.convert()', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      Uint8List actualDataToHash = utf8.encode('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~');

      // Act
      Digest actualDigest = Sha1().convert(actualDataToHash);
      String actualHashString = base64Encode(actualDigest.byteList);

      // Assert
      String expectedHashString = 'kMUWoprF6uC6S8xnRE48SQICRos=';

      expect(actualHashString, expectedHashString);
    });
  });
}
