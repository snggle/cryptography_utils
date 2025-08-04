import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of TokenTransferInstruction constructor', () {
    test('Should [return TokenTransferInstruction]', () {
      // Act
      TokenTransferInstruction actualTokenTransferInstruction = const TokenTransferInstruction(
        programIdString: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        amountInt: 12345,
        mintString: 'Mint1ABCDEFG1234567890abcdefghiJLMNOP',
        recipientString: 'Recipient1abcdefghi1234567890JKLMNOPQR',
        senderString: 'Sender1JKLmnopqrs23456789ABCDefghijklmno',
        signerString: 'Signer1mnopqrstuvwx3456789ABCDEFGHIJKLM',
        tokenDecimalPrecisionInt: 6,
      );

      // Assert
      String expectedProgramId = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';
      int expectedAmount = 12345;
      int expectedDecimals = 6;
      String expectedMint = 'Mint1ABCDEFG1234567890abcdefghiJLMNOP';
      String expectedRecipient = 'Recipient1abcdefghi1234567890JKLMNOPQR';
      String expectedSender = 'Sender1JKLmnopqrs23456789ABCDefghijklmno';
      String expectedSigner = 'Signer1mnopqrstuvwx3456789ABCDEFGHIJKLM';

      expect(actualTokenTransferInstruction.programId, expectedProgramId);
      expect(actualTokenTransferInstruction.amount, expectedAmount);
      expect(actualTokenTransferInstruction.mint, expectedMint);
      expect(actualTokenTransferInstruction.recipient, expectedRecipient);
      expect(actualTokenTransferInstruction.sender, expectedSender);
      expect(actualTokenTransferInstruction.signer, expectedSigner);
      expect(actualTokenTransferInstruction.tokenDecimalPrecision, expectedDecimals);
    });
  });

  group('Tests of TokenTransferInstruction.fromSerializedData()', () {
    test('Should [return TokenTransferInstruction] from serialized data', () {
      // Arrange
      List<Uint8List> actualAccountKeys = <Uint8List>[Uint8List.fromList(<int>[29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244]), Uint8List.fromList(<int>[65, 195, 248, 71, 38, 108, 7, 153, 170, 40, 181, 87, 109, 92, 9, 56, 245, 16, 207, 80, 68, 1, 178, 128, 190, 188, 246, 130, 177, 139, 141, 40]), Uint8List.fromList(<int>[126, 4, 208, 146, 155, 82, 193, 192, 157, 232, 127, 145, 20, 161, 214, 68, 18, 11, 192, 97, 229, 81, 8, 151, 117, 251, 132, 121, 160, 253, 246, 67]), Uint8List.fromList(<int>[59, 68, 44, 179, 145, 33, 87, 241, 58, 147, 61, 1, 52, 40, 45, 3, 43, 95, 254, 205, 1, 162, 219, 241, 183, 121, 6, 8, 223, 0, 46, 167]), Uint8List.fromList(<int>[3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0]), Uint8List.fromList(<int>[6, 221, 246, 225, 215, 101, 161, 147, 217, 203, 225, 70, 206, 235, 121, 172, 28, 180, 133, 237, 95, 91, 55, 145, 58, 140, 245, 133, 126, 255, 0, 169])];

      SolanaInstructionRaw actualSolanaInstruction = SolanaInstructionRaw(
          programIdIndex: 5, accountIndices: <int>[2, 3, 1, 0], data: Uint8List.fromList(<int>[12, 64, 66, 15, 0, 0, 0, 0, 0, 6]));
      String actualProgramId = Base58Codec.encode(actualAccountKeys[actualSolanaInstruction.programIdIndex]);

      // Act
      TokenTransferInstruction actualSolanaInstructionDecoded = TokenTransferInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId);

      // Assert
      expect(actualSolanaInstruction.data, Uint8List.fromList(<int>[12, 64, 66, 15, 0, 0, 0, 0, 0, 6]));
      expect(actualSolanaInstruction.accountIndices, <int>[2, 3, 1, 0]);
      expect(actualSolanaInstruction.programIdIndex, 5);
      expect(actualSolanaInstructionDecoded.programId, 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');
      expect(actualSolanaInstructionDecoded.sender, '9UvdRv2CoyLrgdGbobrQu6feMoapdzY1oqueuYMBfLWv');
      expect(actualSolanaInstructionDecoded.recipient, '5RipPdH3QLE7cyKzf7HKDrUoBrPKNi8odK866vJZV3AP');
      expect(actualSolanaInstructionDecoded.amount, 1000000);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      List<Uint8List> actualAccountKeys = <Uint8List>[Uint8List.fromList(<int>[29, 3, 212, 1, 8, 94, 206, 81, 207, 141, 242, 121, 172, 168, 237, 109, 45, 74, 148, 132, 23, 185, 13, 77, 21, 64, 84, 94, 20, 24, 88, 244]), Uint8List.fromList(<int>[65, 195, 248, 71, 38, 108, 7, 153, 170, 40, 181, 87, 109, 92, 9, 56, 245, 16, 207, 80, 68, 1, 178, 128, 190, 188, 246, 130, 177, 139, 141, 40]), Uint8List.fromList(<int>[126, 4, 208, 146, 155, 82, 193, 192, 157, 232, 127, 145, 20, 161, 214, 68, 18, 11, 192, 97, 229, 81, 8, 151, 117, 251, 132, 121, 160, 253, 246, 67]), Uint8List.fromList(<int>[59, 68, 44, 179, 145, 33, 87, 241, 58, 147, 61, 1, 52, 40, 45, 3, 43, 95, 254, 205, 1, 162, 219, 241, 183, 121, 6, 8, 223, 0, 46, 167]), Uint8List.fromList(<int>[3, 6, 70, 111, 229, 33, 23, 50, 255, 236, 173, 186, 114, 195, 155, 231, 188, 140, 229, 187, 197, 247, 18, 107, 44, 67, 155, 58, 64, 0, 0, 0]), Uint8List.fromList(<int>[6, 221, 246, 225, 215, 101, 161, 147, 217, 203, 225, 70, 206, 235, 121, 172, 28, 180, 133, 237, 95, 91, 55, 145, 58, 140, 245, 133, 126, 255, 0, 169])];
      SolanaInstructionRaw actualSolanaInstruction = SolanaInstructionRaw(
          programIdIndex: 5, accountIndices: <int>[], data: Uint8List.fromList(<int>[12]));
      String actualProgramId = Base58Codec.encode(actualAccountKeys[actualSolanaInstruction.programIdIndex]);

      expect(() => TokenTransferInstruction.fromSerializedData(actualSolanaInstruction, actualAccountKeys, actualProgramId),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
