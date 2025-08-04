import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SystemTransferInstruction constructor', () {
    test('Should [return SystemTransferInstruction]', () {
      // Act
      SystemTransferInstruction actualSystemTransferInstruction = const SystemTransferInstruction(
        programIdString: '11111111111111111111111111111111',
        amountInt: 42,
        recipientString: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        senderString: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
      );

      // Assert
      String expectedProgramId = '11111111111111111111111111111111';
      int expectedAmount = 42;
      String expectedRecipient = '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z';
      String expectedSender = '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19';

      expect(actualSystemTransferInstruction.programId, expectedProgramId);
      expect(actualSystemTransferInstruction.amount, expectedAmount);
      expect(actualSystemTransferInstruction.recipient, expectedRecipient);
      expect(actualSystemTransferInstruction.sender, expectedSender);
    });
  });

  group('Tests of SystemTransferInstruction.fromSerializedData()', () {
    test('Should [return SystemTransferInstruction] from serialized data', () {
      // Arrange
      List<Uint8List> actualAccountKeys = <Uint8List>[Uint8List.fromList(<int>[29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244]), Uint8List.fromList(<int>[81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92]), Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), Uint8List.fromList(<int>[3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0])];
      SolanaInstructionRaw actualSolanaInstruction = SolanaInstructionRaw(programIdIndex: 2, accountIndices: <int>[0, 1], data: Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0]));
      String actualProgramId = Base58Codec.encode(actualAccountKeys[actualSolanaInstruction.programIdIndex]);

      // Act
      SystemTransferInstruction actualSolanaInstructionDecoded = SystemTransferInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId);

      // Assert
      expect(actualSolanaInstruction.data, Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0]));
      expect(actualSolanaInstruction.accountIndices, <int>[0, 1]);
      expect(actualSolanaInstruction.programIdIndex, 2);
      expect(actualSolanaInstructionDecoded.programId, '11111111111111111111111111111111');
      expect(actualSolanaInstructionDecoded.sender, '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19');
      expect(actualSolanaInstructionDecoded.recipient, '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z');
      expect(actualSolanaInstructionDecoded.amount, 1000000000);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      // Arrange
      List<Uint8List> actualAccountKeys = <Uint8List>[Uint8List.fromList(<int>[29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244]), Uint8List.fromList(<int>[81, 152, 8, 5, 93, 227, 117, 225, 149, 24, 146, 171, 176, 184, 52, 31, 115, 99, 47, 242, 63, 150, 104, 119, 58, 48, 244, 202, 52, 205, 123, 92]), Uint8List.fromList(<int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), Uint8List.fromList(<int>[3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0])];
      SolanaInstructionRaw actualSolanaInstruction =
      SolanaInstructionRaw(programIdIndex: 2, accountIndices: <int>[0, 1], data: Uint8List.fromList(<int>[2, 0]));
      String actualProgramId = Base58Codec.encode(actualAccountKeys[actualSolanaInstruction.programIdIndex]);

      // Assert
      expect(() => SystemTransferInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
