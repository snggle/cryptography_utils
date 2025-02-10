import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest_sink.dart';
import 'package:cryptography_utils/src/hash/sha/sha256/sha256_sink.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Tests of Sha256Sink()', () {
    test('Should [return correct hash] constructed from given data', () {
      // Arrange
      String actualDataToHash = '';
      Uint8List actualUint8List = utf8.encode(actualDataToHash);

      // Act
      Sha256Sink actualSha256Sink = Sha256Sink(DigestSink());
      actualSha256Sink.add(actualUint8List);
      actualSha256Sink.close();
      List<int> actualHashList = actualSha256Sink.digestUint32List;
      String actualHashString = actualHashList.map((int e) => e.toRadixString(16).padLeft(8, '0')).join();

      // Assert
      String expectedHashString = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';

      expect(actualHashString, expectedHashString);
    });

    test('Should [return hash] constructed from given data', () {
      // Arrange
      String actualDataToHash = '123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~';
      Uint8List actualUint8List = utf8.encode(actualDataToHash);

      // Act
      Sha256Sink actualSha256Sink = Sha256Sink(DigestSink());
      actualSha256Sink.add(actualUint8List);
      actualSha256Sink.close();
      List<int> actualHashList = actualSha256Sink.digestUint32List;
      String actualHashString = actualHashList.map((int e) => e.toRadixString(16).padLeft(8, '0')).join();

      // Assert
      String expectedHashString = 'df00fb5ed14a252ca18abef541662956dd38dde917861ebbaeb0f21c4f84b224';

      expect(actualHashString, expectedHashString);
    });
  });

  group('Tests of  ASha32BitSink()', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      Uint32List actualUint32List = Uint32List.fromList(<int>[
        0x61626380, 0x00000000, 0x00000000, 0x00000000, //
        0x00000000, 0x00000000, 0x00000000, 0x00000000,
        0x00000000, 0x00000000, 0x00000000, 0x00000000,
        0x00000000, 0x00000000, 0x00000000, 0x00000018
      ]);

      // Act
      DigestSink actualDigestSink = DigestSink();
      Sha256Sink actualSha256sink = Sha256Sink(actualDigestSink);
      actualSha256sink.updateHash(actualUint32List);

      final Uint32List actualDigestUint32List = actualSha256sink.digestUint32List;

      // Assert
      Uint32List expectedDigestUint32List =
          Uint32List.fromList(<int>[0xba7816bf, 0x8f01cfea, 0x414140de, 0x5dae2223, 0xb00361a3, 0x96177a9c, 0xb410ff61, 0xf20015ad]);

      expect(actualDigestUint32List, expectedDigestUint32List);
    });
  });
}
