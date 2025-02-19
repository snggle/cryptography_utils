import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/sha256/sha256.dart';
import 'package:test/test.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Tests of Sha256.convert()', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      Uint8List actualDataToHash = utf8.encode('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~');

      // Act
      Sha256 actualSha256 = Sha256();
      Digest actualDigest = actualSha256.convert(actualDataToHash);
      String actualBytesString = base64Encode(actualDigest.bytesList);

      // Assert
      String expectedHashString = '3wD7XtFKJSyhir71QWYpVt043ekXhh67rrDyHE+EsiQ=';

      expect(actualBytesString, expectedHashString);
    });
  });
}
