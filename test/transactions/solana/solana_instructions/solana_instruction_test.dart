import 'dart:typed_data';

// Only needed for SolanaInstruction
import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaInstruction', ()
  {
    test('Should [construct SolanaInstruction] and .toJson() encodes fields correctly', () {
      // Act
      SolanaInstruction actualInstruction = SolanaInstruction(
        programIdIndex: 1,
        accountIndices: <int>[4, 2, 7],
        data: Uint8List.fromList(<int>[10, 20, 30, 40]),
      );

      Map<String, dynamic> actualJson = actualInstruction.toJson();

      // Assert
      int expectedProgramIdIndex = 1;
      List<int> expectedAccountIndices = <int>[4, 2, 7];
      Uint8List expectedData = Uint8List.fromList(<int>[10, 20, 30, 40]);
      String expectedJsonData = Base58Codec.encode(expectedData);

      expect(actualInstruction.programIdIndex, expectedProgramIdIndex);
      expect(actualInstruction.accountIndices, expectedAccountIndices);
      expect(actualInstruction.data, expectedData);

      expect(actualJson['programIdIndex'], expectedProgramIdIndex);
      expect(actualJson['accountIndices'], expectedAccountIndices);
      expect(actualJson['data'], expectedJsonData);
    });
  });
}