import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/sha512/sha512.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of Sha512.convert()', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      Uint8List actualDataToHash = Uint8List.fromList(utf8.encode(''));

      // Act
      Digest actualDigest = Sha512().convert(actualDataToHash);
      String actualDigestString = actualDigest.bytesList.map((int b) => b.toRadixString(16).padLeft(2, '0')).join();

      // Assert
      String expectedDigestString = 'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce'
          '47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e';

      expect(actualDigestString, expectedDigestString);
    });

    test('Should [return hash] constructed from given data', () {
      // Arrange
      Uint8List actualDataToHash = Uint8List.fromList(utf8.encode('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~'));

      String expectedDigestString = 'fa46e4fb04d1ff783cf57fe1de9de9e15f60eb6bac1d458cfb1fdaa851af26d1'
          '94a804ae7bd0055a6e54734f20e84efa1f13b70ec9077489ee265cd1a959cc49';

      // Act
      Digest actualDigest = Sha512().convert(actualDataToHash);
      String actualDigestString = actualDigest.bytesList.map((int b) => b.toRadixString(16).padLeft(2, '0')).join();

      // Assert
      expect(actualDigestString, expectedDigestString);
    });
  });
}
