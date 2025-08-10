import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaCompiledInstruction.fromSerializedData()', () {
    test('Should [return SolanaCompiledInstruction] from serialized data', () {
      // Arrange
      List<int> actualData = <int>[1, 2, 3, 4, 3, 100, 101, 102];
      ByteReader actualByteReader = ByteReader(Uint8List.fromList(actualData));

      // Act
      SolanaCompiledInstruction actualSolanaCompiledInstruction = SolanaCompiledInstruction.fromSerializedData(actualByteReader);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction = SolanaCompiledInstruction(programIdIndex: 1, accounts: Uint8List.fromList(<int>[3, 4]), data: Uint8List.fromList(<int>[100, 101, 102]));

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      // Arrange
      List<int> actualData = <int>[1, 1, 42, 5, 55, 66];

      ByteReader actualByteReader = ByteReader(Uint8List.fromList(actualData));

      // Assert
      expect(() => SolanaCompiledInstruction.fromSerializedData(actualByteReader), throwsA(isA<RangeError>()));
    });

    test('Should [return SolanaCompiledInstruction] with zero-length accounts and data', () {
      // Arrange
      List<int> actualData = <int>[1, 0, 0];
      ByteReader actualByteReader = ByteReader(Uint8List.fromList(actualData));

      // Act
      SolanaCompiledInstruction actualSolanaCompiledInstruction = SolanaCompiledInstruction.fromSerializedData(actualByteReader);

      // Assert
      SolanaCompiledInstruction expectedSolanaCompiledInstruction = SolanaCompiledInstruction(programIdIndex: 1, accounts: Uint8List(0), data: Uint8List(0));

      expect(actualSolanaCompiledInstruction, expectedSolanaCompiledInstruction);
    });
  });
}
