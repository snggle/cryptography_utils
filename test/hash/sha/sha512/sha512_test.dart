import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/sha512/sha512.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

/// For calculating [expectedHashString] an online calculator was used:  https://emn178.github.io/online-tools/sha512.html
void main() {
  group('Tests of Sha512.convert()', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      Uint8List actualDataToHash = utf8.encode('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~');

      // Act
      Digest actualDigest = Sha512().convert(actualDataToHash);
      String actualDigestString = base64Encode(actualDigest.byteList);

      // Assert
      String expectedDigestString = '+kbk+wTR/3g89X/h3p3p4V9g62usHUWM+x/aqFGvJtGUqASue9AFWm5Uc08g6E76HxO3DskHdInuJlzRqVnMSQ==';

      expect(actualDigestString, expectedDigestString);
    });
  });
}
