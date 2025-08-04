import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of StakeWithdrawInstruction constructor', () {
    test('Should [return StakeWithdrawInstruction]', () {
      // Act
      StakeWithdrawInstruction actualStakeWithdrawInstruction = const StakeWithdrawInstruction(
        programIdString: 'Stake11111111111111111111111111111111111111',
        amountInt: 987654321,
        recipientString: 'Recipient111111111111111111111111111111111',
        senderString: 'Sender1111111111111111111111111111111111111',
      );

      // Assert
      String expectedProgramId = 'Stake11111111111111111111111111111111111111';
      int expectedAmount = 987654321;
      String expectedRecipient = 'Recipient111111111111111111111111111111111';
      String expectedSender = 'Sender1111111111111111111111111111111111111';

      expect(actualStakeWithdrawInstruction.programIdString, expectedProgramId);
      expect(actualStakeWithdrawInstruction.amountInt, expectedAmount);
      expect(actualStakeWithdrawInstruction.recipientString, expectedRecipient);
      expect(actualStakeWithdrawInstruction.senderString, expectedSender);
      expect(actualStakeWithdrawInstruction.programId, expectedProgramId);
      expect(actualStakeWithdrawInstruction.amount, expectedAmount);
      expect(actualStakeWithdrawInstruction.recipient, expectedRecipient);
      expect(actualStakeWithdrawInstruction.sender, expectedSender);
    });
  });

  group('Tests of StakeWithdrawInstruction.fromSerializedData()', () {
    test('Should [return StakeWithdrawInstruction] from serialized data', () {
      // Arrange
      List<Uint8List> actualAccountKeys = <Uint8List>[Uint8List.fromList(<int>[29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244]), Uint8List.fromList(<int>[174, 145, 249, 183, 28, 188, 51, 182, 241, 4, 242, 35, 144, 122, 69, 173, 250, 180, 225, 202, 242, 56, 169, 233, 31, 100, 162, 62, 204, 40, 2, 99]), Uint8List.fromList(<int>[3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0]), Uint8List.fromList(<int>[6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178, 85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0]), Uint8List.fromList(<int>[6, 167, 213, 23, 24, 199, 116, 201, 40, 86, 99, 152, 105, 29, 94, 182, 139, 94, 184, 163, 155, 75, 109, 92, 115, 85, 91, 33, 0, 0, 0, 0]), Uint8List.fromList(<int>[6, 167, 213, 23, 25, 53, 132, 208, 254, 237, 155, 179, 67, 29, 19, 32, 107, 229, 68, 40, 27, 87, 184, 86, 108, 197, 55, 95, 244, 0, 0, 0])];
      SolanaInstructionRaw actualSolanaInstruction = SolanaInstructionRaw(
          programIdIndex: 3, accountIndices: <int>[1, 0, 4, 5, 0], data: Uint8List.fromList(<int>[4, 0, 0, 0, 128, 159, 189, 59, 0, 0, 0, 0]));
      String actualProgramId = Base58Codec.encode(actualAccountKeys[actualSolanaInstruction.programIdIndex]);

      // Act
      StakeWithdrawInstruction actualSolanaInstructionDecoded = StakeWithdrawInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId);

      // Assert
      expect(actualSolanaInstruction.data, Uint8List.fromList(<int>[4, 0, 0, 0, 128, 159, 189, 59, 0, 0, 0, 0]));
      expect(actualSolanaInstruction.accountIndices, <int>[1, 0, 4, 5, 0]);
      expect(actualSolanaInstruction.programIdIndex, 3);
      expect(actualSolanaInstructionDecoded.programId, 'Stake11111111111111111111111111111111111111');
      expect(actualSolanaInstructionDecoded.sender, 'CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k');
      expect(actualSolanaInstructionDecoded.recipient, '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19');
      expect(actualSolanaInstructionDecoded.amount, 1002282880);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      // Arrange
      List<Uint8List> actualAccountKeys = <Uint8List>[Uint8List.fromList(<int>[29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244]), Uint8List.fromList(<int>[174, 145, 249, 183, 28, 188, 51, 182, 241, 4, 242, 35, 144, 122, 69, 173, 250, 180, 225, 202, 242, 56, 169, 233, 31, 100, 162, 62, 204, 40, 2, 99]), Uint8List.fromList(<int>[3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0]), Uint8List.fromList(<int>[6, 161, 216, 23, 145, 55, 84, 42, 152, 52, 55, 189, 254, 42, 122, 178, 85, 127, 83, 92, 138, 120, 114, 43, 104, 164, 157, 192, 0, 0, 0, 0]), Uint8List.fromList(<int>[6, 167, 213, 23, 24, 199, 116, 201, 40, 86, 99, 152, 105, 29, 94, 182, 139, 94, 184, 163, 155, 75, 109, 92, 115, 85, 91, 33, 0, 0, 0, 0]), Uint8List.fromList(<int>[6, 167, 213, 23, 25, 53, 132, 208, 254, 237, 155, 179, 67, 29, 19, 32, 107, 229, 68, 40, 27, 87, 184, 86, 108, 197, 55, 95, 244, 0, 0, 0])];
      SolanaInstructionRaw actualSolanaInstruction = SolanaInstructionRaw(
          programIdIndex: 3, accountIndices: <int>[1, 0, 4, 5, 0], data: Uint8List.fromList(<int>[4]));
      String actualProgramId = Base58Codec.encode(actualAccountKeys[actualSolanaInstruction.programIdIndex]);

      // Assert
      expect(() => StakeWithdrawInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
