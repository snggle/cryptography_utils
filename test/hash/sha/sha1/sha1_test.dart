import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/hash/digest_sink.dart';
import 'package:cryptography_utils/src/hash/sha/sha1/sha1.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Sha1.convert()', () {
    test('Should [return the expected digest] if [input spans more than one block]', () {
      // Arrange
      Uint8List actualDataToHash = utf8.encode('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~');

      // Act
      Digest actualDigest = Sha1().convert(actualDataToHash);

      // Assert
      Digest expectedDigest = Digest(base64Decode('kMUWoprF6uC6S8xnRE48SQICRos='));

      expect(actualDigest, expectedDigest);
    });

    test('Should [return the expected digest] if [input contains zero bytes]', () {
      // Arrange
      Uint8List actualDataToHash = Uint8List(0);

      // Act
      Digest actualDigest = Sha1().convert(actualDataToHash);

      // Assert
      Digest expectedDigest = Digest(base64Decode('2jmj7l5rSw0yVb/vlWAYkK/YBwk='));

      expect(actualDigest, expectedDigest);
    });

    test('Should [return the expected digest] if [55 bytes leave room for padding in one block]', () {
      // Arrange
      Uint8List actualDataToHash = utf8.encode('a' * 55);

      // Act
      Digest actualDigest = Sha1().convert(actualDataToHash);

      // Assert
      Digest expectedDigest = Digest(base64Decode('wci73CJ5bijA4VFj0giZtlYh1lo='));

      expect(actualDigest, expectedDigest);
    });

    test('Should [return the expected digest] if [56 bytes require a second block for padding]', () {
      // Arrange
      Uint8List actualDataToHash = utf8.encode('a' * 56);

      // Act
      Digest actualDigest = Sha1().convert(actualDataToHash);

      // Assert
      Digest expectedDigest = Digest(base64Decode('wtszD2CDhUyZ1LW/tujynyAb5pk='));

      expect(actualDigest, expectedDigest);
    });
  });

  group('Tests of Sha1.startChunkedConversion()', () {
    test('Should [return the expected digest] if [the second chunk completes a block and leaves a remainder]', () {
      // Arrange
      List<int> actualDataToHash = List<int>.generate(65, (int index) => index);
      DigestSink actualDigestSink = DigestSink();
      ByteConversionSink actualByteConversionSink = Sha1().startChunkedConversion(actualDigestSink);

      // Act
      // ignore: cascade_invocations
      actualByteConversionSink
        ..add(actualDataToHash.sublist(0, 63))
        ..add(actualDataToHash.sublist(63))
        ..close();
      Digest actualDigest = actualDigestSink.valueDigest;

      // Assert
      Digest expectedDigest = Digest(base64Decode('ab1yitbhPNdv8ZdR/eQnsA45V0Y='));

      expect(actualDigest, expectedDigest);
    });
  });
}
