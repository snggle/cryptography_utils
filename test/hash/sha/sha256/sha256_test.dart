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
      Uint8List actualDataToHash = Uint8List.fromList(utf8.encode(''));

      // Act
      Sha256 actualSha256 = Sha256();
      Digest actualDigest = actualSha256.convert(actualDataToHash);
      List<int> actualBytesList = actualDigest.bytesList;

      // Assert
      String expectedHashString = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';
      List<int> expectedBytesList = Uint8List.fromList(
          <int>[for (int i = 0; i < expectedHashString.length; i += 2) int.parse(expectedHashString.substring(i, i + 2), radix: 16)]);

      expect(actualBytesList, expectedBytesList);
    });

    test('Should [return hash] constructed from given data', () {
      // Arrange
      Uint8List actualDataToHash = Uint8List.fromList(utf8.encode('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~'));

      // Act
      Sha256 actualSha256 = Sha256();
      Digest actualDigest = actualSha256.convert(actualDataToHash);
      List<int> actualBytesList = actualDigest.bytesList;

      // Assert
      String expectedHashString = 'df00fb5ed14a252ca18abef541662956dd38dde917861ebbaeb0f21c4f84b224';
      List<int> expectedBytesList = Uint8List.fromList(
          <int>[for (int i = 0; i < expectedHashString.length; i += 2) int.parse(expectedHashString.substring(i, i + 2), radix: 16)]);

      expect(actualBytesList, expectedBytesList);
    });
  });
}
