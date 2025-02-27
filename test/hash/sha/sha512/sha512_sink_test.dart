import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest_sink.dart';
import 'package:cryptography_utils/src/hash/sha/sha512/sha_512_sink.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Tests of Sha512Sink.updateHash()', () {
    test('Should [return hash] constructed from given data', () {
      // Arrange
      String actualDataToHash = '123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~';
      Uint32List actualUint32List = Uint32List.fromList(actualDataToHash.codeUnits);
      DigestSink actualDigestSink = DigestSink();
      Sha512Sink actualSha512Sink = Sha512Sink(actualDigestSink);

      // Act
      actualSha512Sink.updateHash(actualUint32List);
      Uint32List actualDigestUint32List = actualSha512Sink.digestUint32List;

      // Assert
      Uint32List expectedDigestUint32List = Uint32List.fromList(<int>[
        3492118963, 1627087956, 3150871713, 3630638959, //
        3359712394, 1593454716, 1080073699, 2608846795,
        1817179099, 2060845797, 3341868678, 1197038725,
        1082521416, 2706134826, 1898010856, 931400256
      ]);

      expect(actualDigestUint32List, expectedDigestUint32List);
    });
  });
}
