import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/export.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaMessageHeader.fromBytes()', () {
    test('Should [return SolanaMessageHeader] from bytes', () {
      // Arrange
      Uint8List actualBytes = Uint8List.fromList(<int>[1, 0, 9]);
      ByteReader actualByteReader = ByteReader(actualBytes);

      // Act
      SolanaMessageHeader actualSolanaMessageHeader = SolanaMessageHeader.fromBytes(actualByteReader);

      // Assert
      SolanaMessageHeader expectedSolanaMessageHeader = const SolanaMessageHeader(
        numRequiredSignatures: 1,
        numReadonlySignedAccounts: 0,
        numReadonlyUnsignedAccounts: 9,
      );
      expect(actualSolanaMessageHeader, expectedSolanaMessageHeader);
    });

    test('Should [throw] when bytes are fewer than 3', () {
      // Arrange
      Uint8List actualBytes = Uint8List.fromList(<int>[1, 2]);
      ByteReader actualByteReader = ByteReader(actualBytes);

      // Assert
      expect(() => SolanaMessageHeader.fromBytes(actualByteReader), throwsA(anyOf(isA<RangeError>(), isA<StateError>(), isA<Exception>())));
    });
  });
}
