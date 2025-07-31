import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaInstructionDecoded', ()
  {
    test('Should [construct SolanaInstructionDecoded] with all fields set', () {
      // Arrange
      SolanaInstructionType expectedType = SolanaInstructionType.tokenTransfer;
      String expectedProgramId = 'AbCde12345';
      String expectedFrom = 'senderPubKey';
      String expectedTo = 'recipientPubKey';
      String expectedSigner = 'signerPubKey';
      int expectedAmount = 42;
      int expectedAmountSwappedTo = 123456;
      int expectedDecimals = 6;
      String expectedMint = 'mintPubKey';
      int expectedBaseFee = 1000;
      int expectedHeapFrameBytes = 2048;
      String expectedTokenProgram = 'TokenProgKey';
      String expectedAssociatedProgram = 'AssocProgKey';

      // Act
      SolanaInstructionDecoded actualDecoded = SolanaInstructionDecoded(
        type: expectedType,
        programId: expectedProgramId,
        from: expectedFrom,
        to: expectedTo,
        signer: expectedSigner,
        amount: expectedAmount,
        amountSwappedTo: expectedAmountSwappedTo,
        tokenDecimalPrecision: expectedDecimals,
        mint: expectedMint,
        unitPrice: expectedBaseFee,
        unitLimit: expectedHeapFrameBytes,
        tokenProgram: expectedTokenProgram,
        associatedProgram: expectedAssociatedProgram,
      );

      // Assert
      expect(actualDecoded.type, expectedType);
      expect(actualDecoded.programId, expectedProgramId);
      expect(actualDecoded.from, expectedFrom);
      expect(actualDecoded.to, expectedTo);
      expect(actualDecoded.signer, expectedSigner);
      expect(actualDecoded.amount, expectedAmount);
      expect(actualDecoded.amountSwappedTo, expectedAmountSwappedTo);
      expect(actualDecoded.tokenDecimalPrecision, expectedDecimals);
      expect(actualDecoded.mint, expectedMint);
      expect(actualDecoded.unitPrice, expectedBaseFee);
      expect(actualDecoded.unitLimit, expectedHeapFrameBytes);
      expect(actualDecoded.tokenProgram, expectedTokenProgram);
      expect(actualDecoded.associatedProgram, expectedAssociatedProgram);
    });
  });
}