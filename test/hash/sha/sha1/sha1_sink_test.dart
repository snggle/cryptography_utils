import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest_sink.dart';
import 'package:cryptography_utils/src/hash/sha/sha1/sha1_sink.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Tests of Sha1Sink.updateHash()', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      String actualDataToHash = 'abcdefghijklmnopqrstuvwxyz';
      Uint32List actualUint32List = Uint32List.fromList(actualDataToHash.codeUnits);
      DigestSink actualDigestSink = DigestSink();
      Sha1Sink actualSha1Sink = Sha1Sink(actualDigestSink);

      // Act
      actualSha1Sink.updateHash(actualUint32List);

      Uint32List actualDigestUint32List = actualSha1Sink.digestUint32List;

      // Assert
      Uint32List expectedDigestUint32List = Uint32List.fromList(<int>[0x18347965, 0x240a9056, 0x56e7a0cb, 0x39bb3854, 0xb3ada906]);

      expect(actualDigestUint32List, expectedDigestUint32List);
    });
  });
}
