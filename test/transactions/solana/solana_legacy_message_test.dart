import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaLegacyMessage.fromBytes()', () {
    test('Should [return SolanaLegacyMessage] from bytes', () {
      // Arrange
      Uint8List actualSolanaLegacyMessageBytes = Base58Codec.decode(
          '8XvVPnpTLZqLmFm1xXHBushdVTcZDpbgbTXtmAATXbzBDyBpaoMcvxWRRwjpBpHdeJSEC5FJUB8xDAn5eZWGetF96KzQv7cdVXP1e3H2dpkgpTaNsgJD8JLgowf8LEsjBya3oog6S3hwa7VgSDAvJHXVrGPRbCxoxt2ELwT1ZANor9BnZLz2PGhpF8SDWHZkSxyEkPWxMiCpqJGYD5WqB5hS8Br5dk2HcHpRvYxxPuzfoHygJECu4JyZLgnd39qQwk9nS8UuBiAg9wXS6B1');

      // Act
      SolanaLegacyMessage actualSolanaLegacyMessage = SolanaLegacyMessage.fromSerializedData(actualSolanaLegacyMessageBytes);

      // Assert
      List<String> expectedAccountKeys = <String>[
        '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        '11111111111111111111111111111111',
        'ComputeBudget111111111111111111111111111111'
      ];

      expect(actualSolanaLegacyMessage.header.numRequiredSignatures, 1);
      expect(actualSolanaLegacyMessage.header.numReadonlySignedAccounts, 0);
      expect(actualSolanaLegacyMessage.header.numReadonlyUnsignedAccounts, 2);

      List<String> actualAccountKeys = actualSolanaLegacyMessage.accountKeysList.map(Base58Codec.encode).toList();
      expect(actualAccountKeys, expectedAccountKeys);

      expect(Base58Codec.encode(actualSolanaLegacyMessage.recentBlockhash), 'DqdWewkZSAEPeC8sY4SFApoiMbYy6ScMP7JSVhyViNEV');

      expect(actualSolanaLegacyMessage.solanaInstructionList.length, 3);

      ASolanaInstructionDecoded actualSolanaInstruction0Decoded =
          ASolanaInstructionDecoded.decode(actualSolanaLegacyMessage.solanaInstructionList[0], actualSolanaLegacyMessage.accountKeysList);
      ASolanaInstructionDecoded actualSolanaInstruction1Decoded =
          ASolanaInstructionDecoded.decode(actualSolanaLegacyMessage.solanaInstructionList[1], actualSolanaLegacyMessage.accountKeysList);
      ASolanaInstructionDecoded actualSolanaInstruction2Decoded =
          ASolanaInstructionDecoded.decode(actualSolanaLegacyMessage.solanaInstructionList[2], actualSolanaLegacyMessage.accountKeysList);

      expect(actualSolanaInstruction0Decoded, isA<ComputeBudgetUnitPriceInstruction>());
      expect(actualSolanaInstruction0Decoded.programId, 'ComputeBudget111111111111111111111111111111');
      expect(actualSolanaInstruction0Decoded.unitPrice, 20000000);
      expect(actualSolanaInstruction0Decoded.unitLimit, isNull);

      expect(actualSolanaInstruction1Decoded, isA<ComputeBudgetUnitLimitInstruction>());
      expect(actualSolanaInstruction1Decoded.programId, 'ComputeBudget111111111111111111111111111111');
      expect(actualSolanaInstruction1Decoded.unitPrice, isNull);
      expect(actualSolanaInstruction1Decoded.unitLimit, 495);

      expect(actualSolanaInstruction2Decoded, isA<SystemTransferInstruction>());
      expect(actualSolanaInstruction2Decoded.programId, '11111111111111111111111111111111');
      expect(actualSolanaInstruction2Decoded.sender, '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19');
      expect(actualSolanaInstruction2Decoded.recipient, '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z');
      expect(actualSolanaInstruction2Decoded.amount, 1000000000);
    });
  });
}
