import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/hash/digest_sink.dart';
import 'package:cryptography_utils/src/hash/sha/sha1/sha1_sink.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Sha1Sink.updateHash()', () {
    late Sha1Sink actualSha1Sink;

    setUp(() {
      actualSha1Sink = Sha1Sink(DigestSink());
    });

    tearDown(() {
      actualSha1Sink.close();
    });

    test('Should [update the digest state] if [input contains a full 16-word block]', () {
      // Arrange
      Uint32List actualBlockUint32List = Uint32List.fromList('abcdefghijklmnop'.codeUnits);

      // Act
      actualSha1Sink.updateHash(actualBlockUint32List);
      Uint32List actualDigestUint32List = actualSha1Sink.digestUint32List;

      // Assert
      Uint32List expectedDigestUint32List = Uint32List.fromList(<int>[0x18347965, 0x240a9056, 0x56e7a0cb, 0x39bb3854, 0xb3ada906]);

      expect(actualDigestUint32List, expectedDigestUint32List);
    });

    test('Should [fail without updating the digest state] if [input contains only 15 words]', () {
      // Arrange
      Uint32List actualBlockUint32List = Uint32List(15);

      // Act
      void actualUpdateHash() => actualSha1Sink.updateHash(actualBlockUint32List);

      // Assert
      Uint32List expectedDigestUint32List = Uint32List.fromList(<int>[0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0]);

      expect(actualUpdateHash, throwsA(isA<RangeError>()));
      expect(actualSha1Sink.digestUint32List, expectedDigestUint32List);
    });
  });

  group('Tests of Sha1Sink.add()', () {
    test('Should [ignore a full block] if [the sink is closed]', () {
      // Arrange
      Sha1Sink actualSha1Sink = Sha1Sink(DigestSink())
        ..add(utf8.encode('abc'))
        ..close();
      Uint8List actualLateBlockUint8List = Uint8List(64);

      // Act
      // ignore: cascade_invocations
      actualSha1Sink.add(actualLateBlockUint8List);
      Uint32List actualDigestUint32List = actualSha1Sink.digestUint32List;

      // Assert
      Uint32List expectedDigestUint32List = Uint32List.fromList(<int>[0xa9993e36, 0x4706816a, 0xba3e2571, 0x7850c26c, 0x9cd0d89d]);

      expect(actualDigestUint32List, expectedDigestUint32List);
    });
  });

  group('Tests of Sha1Sink.close()', () {
    test('Should [emit exactly one digest] if [close is called twice]', () {
      // Arrange
      List<Digest> actualDigestList = <Digest>[];
      ChunkedConversionSink<Digest> actualDigestSink = ChunkedConversionSink<Digest>.withCallback(actualDigestList.addAll);
      Sha1Sink actualSha1Sink = Sha1Sink(actualDigestSink)..add(utf8.encode('abc'));

      // Act
      // ignore: cascade_invocations
      actualSha1Sink
        ..close()
        ..close();

      // Assert
      List<Digest> expectedDigestList = <Digest>[Digest(base64Decode('qZk+NkcGgWq6PiVxeFDCbJzQ2J0='))];

      expect(actualDigestList, expectedDigestList);
    });
  });
}
