import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest_sink.dart';
import 'package:cryptography_utils/src/hash/sha/sha256/sha256_sink.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Tests of Sha256Sink()', () {
    test('Should [return hash] constructed from given data', () {
      String actualDataToHash = 'abcdefghijklmnopqrstuvwxyz';
      Uint32List actualUint32List = Uint32List.fromList(actualDataToHash.codeUnits);

      // Act
      DigestSink actualDigestSink = DigestSink();
      Sha256Sink actualSha256sink = Sha256Sink(actualDigestSink);
      actualSha256sink.updateHash(actualUint32List);

      Uint32List actualDigestUint32List = actualSha256sink.digestUint32List;

      // Assert
      Uint32List expectedDigestUint32List =
          Uint32List.fromList(<int>[402731661, 1055510437, 791927637, 2947656330, 1514833154, 2081851324, 3567160327, 163114491]);

      expect(actualDigestUint32List, expectedDigestUint32List);
    });
  });

  group('Tests of  ASha32BitSink()', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      String actualDataToHash = '123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~';
      Uint32List actualUint32List = Uint32List.fromList(actualDataToHash.codeUnits);

      // Act
      DigestSink actualDigestSink = DigestSink();
      Sha256Sink actualSha256sink = Sha256Sink(actualDigestSink);
      actualSha256sink.updateHash(actualUint32List);

      Uint32List actualDigestUint32List = actualSha256sink.digestUint32List;

      // Assert
      Uint32List expectedDigestUint32List =
          Uint32List.fromList(<int>[117022671, 1091493000, 1327280469, 3230838309, 3013673807, 2862686986, 2657444012, 133496128]);

      expect(actualDigestUint32List, expectedDigestUint32List);
    });
  });
}
