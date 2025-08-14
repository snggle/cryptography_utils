import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/export.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaMessageHeader.fromBytes()', () {
    test('Should [return SolanaMessageHeader] from bytes', () {
      // Act
      SolanaMessageHeader actualSolanaMessageHeader = SolanaMessageHeader.fromBytes(ByteReader(Uint8List.fromList(<int>[1, 0, 9])));

      // Assert
      SolanaMessageHeader expectedSolanaMessageHeader = const SolanaMessageHeader(
        numRequiredSignatures: 1,
        numReadonlySignedAccounts: 0,
        numReadonlyUnsignedAccounts: 9,
      );
      expect(actualSolanaMessageHeader, expectedSolanaMessageHeader);
    });
  });
}
