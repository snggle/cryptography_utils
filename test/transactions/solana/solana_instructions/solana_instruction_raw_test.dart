import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaInstructionRaw constructor', () {
    test('Should [return SolanaInstructionRaw]', () {
      // Arrange
      int actualProgramIdIndex = 3;
      List<int> actualAccountIndices = <int>[1, 2, 3];
      Uint8List actualData = Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0]);

      // Act
      SolanaInstructionRaw actual = SolanaInstructionRaw(
        programIdIndex: actualProgramIdIndex,
        accountIndices: actualAccountIndices,
        data: actualData,
      );

      // Assert
      expect(actual.programIdIndex, 3);
      expect(actual.accountIndices, <int>[1, 2, 3]);
      expect(actual.data, Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0]));
    });
  });

  group('Tests of SolanaInstructionRaw.fromSerializedData()', () {
    test('Should [return SolanaInstructionRaw] from serialized data', () {
      // Arrange
      List<int> actualData = <int>[1, 2, 3, 4, 3, 100, 101, 102];
      ByteReader actualByteReader = ByteReader(Uint8List.fromList(actualData));

      // Act
      SolanaInstructionRaw actualSolanaInstructionRaw = SolanaInstructionRaw.fromSerializedData(actualByteReader);

      // Assert
      expect(actualSolanaInstructionRaw.programIdIndex, 1);
      expect(actualSolanaInstructionRaw.accountIndices, <int>[3, 4]);
      expect(actualSolanaInstructionRaw.data, Uint8List.fromList(<int>[100, 101, 102]));
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      // Arrange
      List<int> actualData = <int>[1, 1, 42, 5, 55, 66];

      ByteReader actualByteReader = ByteReader(Uint8List.fromList(actualData));

      // Assert
      expect(() => SolanaInstructionRaw.fromSerializedData(actualByteReader), throwsA(isA<RangeError>()));
    });

    test('Should [return SolanaInstructionRaw] with zero-length accounts and data', () {
      // Arrange
      List<int> actualData = <int>[1, 0, 0];
      ByteReader actualByteReader = ByteReader(Uint8List.fromList(actualData));

      // Act
      SolanaInstructionRaw actualSolanaInstructionRaw = SolanaInstructionRaw.fromSerializedData(actualByteReader);

      // Assert
      expect(actualSolanaInstructionRaw.programIdIndex, 1);
      expect(actualSolanaInstructionRaw.accountIndices, <int>[]);
      expect(actualSolanaInstructionRaw.data, Uint8List(0));
    });
  });
}
