import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/hash/digest_sink.dart';
import 'package:cryptography_utils/src/hash/sha/sha512/sha_512_sink.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations

void main() {
  group('Tests of Sha512Sink', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      Uint8List actualDataToHash = utf8.encode('');

      // Act
      DigestSink actualDigestSink = DigestSink();
      Sha512Sink actualSha512Sink = Sha512Sink(actualDigestSink);
      actualSha512Sink.add(actualDataToHash);
      actualSha512Sink.close();
      Digest actualDigest = actualDigestSink.valueDigest;
      String actualDigestString = actualDigest.bytesList.map((int b) => b.toRadixString(16).padLeft(2, '0')).join();

      // Assert
      String expectedDigestString =
          'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e';

      expect(actualDigestString, expectedDigestString);
    });

    test('Should [return hash] constructed from given data', () {
      // Arrange
      Uint8List actualInput = utf8.encode('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~');

      // Act
      DigestSink actualDigestSink = DigestSink();
      Sha512Sink actualSha512Sink = Sha512Sink(actualDigestSink);
      actualSha512Sink.add(actualInput);
      actualSha512Sink.close();
      Digest actualDigest = actualDigestSink.valueDigest;
      String actualDigestString = actualDigest.bytesList.map((int b) => b.toRadixString(16).padLeft(2, '0')).join();

      // Assert
      String expectedDigestString =
          'fa46e4fb04d1ff783cf57fe1de9de9e15f60eb6bac1d458cfb1fdaa851af26d194a804ae7bd0055a6e54734f20e84efa1f13b70ec9077489ee265cd1a959cc49';

      expect(actualDigestString, expectedDigestString);
    });
  });

  group('ASha64BitSink', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      final Uint32List chunk = Uint32List.fromList(<int>[
        0x61626380, 0x00000000, 0x00000000, 0x00000000, //
        0x00000000, 0x00000000, 0x00000000, 0x00000000,
        0x00000000, 0x00000000, 0x00000000, 0x00000000,
        0x00000000, 0x00000000, 0x00000000, 0x00000018,
        0x00000000, 0x00000000, 0x00000000, 0x00000000,
        0x00000000, 0x00000000, 0x00000000, 0x00000000,
        0x00000000, 0x00000000, 0x00000000, 0x00000000,
        0x00000000, 0x00000000, 0x00000000, 0x00000000
      ]);

      // Act
      DigestSink digestSink = DigestSink();
      Sha512Sink sha512Sink = Sha512Sink(digestSink);
      sha512Sink.updateHash(chunk);
      final Uint32List actualUint32List = sha512Sink.digestUint32List;

      // Assert
      final Uint32List expectedUint32List = Uint32List.fromList(<int>[
        3711768430, 2901526140, 2084514828, 2704861844, //
        1981292127, 2838781325, 1108973179, 3811054921,
        4159122938, 3247063908, 1578758462, 3138410666,
        2247727312, 28743375, 471685, 3748495704
      ]);

      expect(actualUint32List, expectedUint32List);
    });
  });
}
