import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/hash/digest_sink.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Test of DigestSink.add()', () {
    test('Should [return valueDigest] constructed from given data', () {
      // Arrange
      DigestSink actualDigestSink = DigestSink();
      Digest actualDigest1 = const Digest(<int>[1, 2, 3, 4]);
      Digest actualDigest2 = const Digest(<int>[5, 6, 7, 8]);

      // Act
      actualDigestSink.add(actualDigest1);
      actualDigestSink.add(actualDigest2);
      Digest actualValueDigest = actualDigestSink.valueDigest;

      // Assert
      Digest expectedValueDigest = actualDigest2;

      expect(actualValueDigest, expectedValueDigest);
    });
  });
  group('Test of DigestSink.close()', () {
    test('Should [return valueDigest] constructed from given data', () {
      // Arrange
      DigestSink actualDigestSink = DigestSink();
      Digest actualDigest = const Digest(<int>[9, 10, 11, 12]);

      // Act
      actualDigestSink.add(actualDigest);
      actualDigestSink.close();

      Digest actualValueDigest = actualDigestSink.valueDigest;

      // Assert
      Digest expectedValueDigest = actualDigest;

      expect(actualValueDigest, expectedValueDigest);
    });
  });
}
