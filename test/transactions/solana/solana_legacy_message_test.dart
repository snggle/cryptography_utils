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
      SolanaMessageHeader expectedSolanaMessageHeader =
          const SolanaMessageHeader(numRequiredSignatures: 1, numReadonlySignedAccounts: 0, numReadonlyUnsignedAccounts: 2);
      List<SolanaPubKey> expectedAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBase58('2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19'),
        SolanaPubKey.fromBase58('6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z'),
        SolanaPubKey.fromBase58('11111111111111111111111111111111'),
        SolanaPubKey.fromBase58('ComputeBudget111111111111111111111111111111')
      ];
      Uint8List expecyedRecentBlockhash = Base58Codec.decode('DqdWewkZSAEPeC8sY4SFApoiMbYy6ScMP7JSVhyViNEV');
      List<SolanaCompiledInstruction> expectedCompiledInstructions = <SolanaCompiledInstruction>[
        SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[3, 0, 45, 49, 1, 0, 0, 0, 0])),
        SolanaCompiledInstruction(programIdIndex: 3, accounts: Uint8List(0), data: Uint8List.fromList(<int>[2, 239, 1, 0, 0])),
        SolanaCompiledInstruction(
            programIdIndex: 2,
            accounts: Uint8List.fromList(<int>[0, 1]),
            data: Uint8List.fromList(<int>[2, 0, 0, 0, 0, 202, 154, 59, 0, 0, 0, 0])),
      ];
      SolanaLegacyMessage expectedSolanaLegacyMessage = SolanaLegacyMessage(
          header: expectedSolanaMessageHeader,
          accountKeysList: expectedAccountKeys,
          recentBlockhash: expecyedRecentBlockhash,
          compiledInstructions: expectedCompiledInstructions);

      ASolanaInstructionDecoded actualSolanaComputeBudgetUnitLimitInstruction = actualSolanaLegacyMessage.decodedInstructions[0];
      ASolanaInstructionDecoded actualSolanaComputeBudgetUnitPriceInstruction = actualSolanaLegacyMessage.decodedInstructions[1];
      ASolanaInstructionDecoded actualSolanaSystemTransferInstruction = actualSolanaLegacyMessage.decodedInstructions[2];

      SolanaComputeBudgetUnitPriceInstruction expectedSolanaComputeBudgetUnitPriceInstruction =
          const SolanaComputeBudgetUnitPriceInstruction(programId: 'ComputeBudget111111111111111111111111111111', unitPrice: 20000000);
      SolanaComputeBudgetUnitLimitInstruction expectedSolanaComputeBudgetUnitLimitInstruction =
          const SolanaComputeBudgetUnitLimitInstruction(programId: 'ComputeBudget111111111111111111111111111111', unitLimit: 495);
      SolanaSystemTransferInstruction expectedSolanaSystemTransferInstruction = const SolanaSystemTransferInstruction(
          programId: '11111111111111111111111111111111',
          recipient: '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
          sender: '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
          amount: 1000000000);

      expect(actualSolanaLegacyMessage, expectedSolanaLegacyMessage);
      expect(actualSolanaComputeBudgetUnitLimitInstruction, expectedSolanaComputeBudgetUnitPriceInstruction);
      expect(actualSolanaComputeBudgetUnitPriceInstruction, expectedSolanaComputeBudgetUnitLimitInstruction);
      expect(actualSolanaSystemTransferInstruction, expectedSolanaSystemTransferInstruction);
    });
  });
}
