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
      SolanaLegacyMessage actualSolanaLegacyMessage = SolanaLegacyMessage.fromBytes(actualSolanaLegacyMessageBytes);

      // Assert
      List<String> expectedAccountKeys = <String>[
        '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        '11111111111111111111111111111111',
        'ComputeBudget111111111111111111111111111111'
      ];

      expect(actualSolanaLegacyMessage.numRequiredSignatures, 1);
      expect(actualSolanaLegacyMessage.numReadonlySignedAccounts, 0);
      expect(actualSolanaLegacyMessage.numReadonlyUnsignedAccounts, 2);

      List<String> actualAccountKeys = actualSolanaLegacyMessage.accountKeys.map(Base58Codec.encode).toList();
      expect(actualAccountKeys, expectedAccountKeys);

      expect(Base58Codec.encode(actualSolanaLegacyMessage.recentBlockhash), 'DqdWewkZSAEPeC8sY4SFApoiMbYy6ScMP7JSVhyViNEV');

      expect(actualSolanaLegacyMessage.instructions.length, 3);

      SolanaInstructionDecoded actualSolanaInstruction0Decoded =
          actualSolanaLegacyMessage.instructions[0].decode(actualSolanaLegacyMessage.accountKeys);
      SolanaInstructionDecoded actualSolanaInstruction1Decoded =
          actualSolanaLegacyMessage.instructions[1].decode(actualSolanaLegacyMessage.accountKeys);
      SolanaInstructionDecoded actualSolanaInstruction2Decoded =
          actualSolanaLegacyMessage.instructions[2].decode(actualSolanaLegacyMessage.accountKeys);

      expect(actualSolanaInstruction0Decoded.type, SolanaInstructionType.computeBudget);
      expect(actualSolanaInstruction0Decoded.programId, 'ComputeBudget111111111111111111111111111111');
      expect(actualSolanaInstruction0Decoded.baseFee, 20000000);
      expect(actualSolanaInstruction0Decoded.heapFrameBytes, isNull);

      expect(actualSolanaInstruction1Decoded.type, SolanaInstructionType.computeBudget);
      expect(actualSolanaInstruction1Decoded.programId, 'ComputeBudget111111111111111111111111111111');
      expect(actualSolanaInstruction1Decoded.baseFee, isNull);
      expect(actualSolanaInstruction1Decoded.heapFrameBytes, 495);

      expect(actualSolanaInstruction2Decoded.type, SolanaInstructionType.solTransfer);
      expect(actualSolanaInstruction2Decoded.programId, '11111111111111111111111111111111');
      expect(actualSolanaInstruction2Decoded.from, '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19');
      expect(actualSolanaInstruction2Decoded.to, '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z');
      expect(actualSolanaInstruction2Decoded.amount, 1000000000);
    });
  });

  group('Tests of SolanaLegacyMessage.toJson()', () {
    test('Should [convert SolanaLegacyMessage to JSON]', () {
      // Arrange
      Uint8List actualSolanaLegacyMessageBytes = Base58Codec.decode(
          '8XvVPnpTLZqLmFm1xXHBushdVTcZDpbgbTXtmAATXbzBDyBpaoMcvxWRRwjpBpHdeJSEC5FJUB8xDAn5eZWGetF96KzQv7cdVXP1e3H2dpkgpTaNsgJD8JLgowf8LEsjBya3oog6S3hwa7VgSDAvJHXVrGPRbCxoxt2ELwT1ZANor9BnZLz2PGhpF8SDWHZkSxyEkPWxMiCpqJGYD5WqB5hS8Br5dk2HcHpRvYxxPuzfoHygJECu4JyZLgnd39qQwk9nS8UuBiAg9wXS6B1');

      // Act
      SolanaLegacyMessage actualSolanaLegacyMessage = SolanaLegacyMessage.fromBytes(actualSolanaLegacyMessageBytes);
      Map<String, dynamic> actualJson = actualSolanaLegacyMessage.toJson();

      // Assert
      List<String> expectedAccountKeys = <String>[
        '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19',
        '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z',
        '11111111111111111111111111111111',
        'ComputeBudget111111111111111111111111111111'
      ];

      expect(actualJson['numRequiredSignatures'], 1);
      expect(actualJson['numReadonlySignedAccounts'], 0);
      expect(actualJson['numReadonlyUnsignedAccounts'], 2);
      expect(actualJson['accountKeys'], expectedAccountKeys);
      expect(actualJson['recentBlockhash'], 'DqdWewkZSAEPeC8sY4SFApoiMbYy6ScMP7JSVhyViNEV');
      expect(actualJson['instructions'], isA<List<dynamic>>());
      expect((actualJson['instructions'] as List<dynamic>).length, 3);

      List<Map<String, dynamic>> actualInstructions = List<Map<String, dynamic>>.from(actualJson['instructions'] as List<dynamic>);
      Map<String, dynamic> actualInstruction0 = actualInstructions[0];
      Map<String, dynamic> actualInstruction1 = actualInstructions[1];
      Map<String, dynamic> actualInstruction2 = actualInstructions[2];

      Map<String, dynamic> actualInstructionDecoded0 = actualInstruction0['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded1 = actualInstruction1['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded2 = actualInstruction2['decoded'] as Map<String, dynamic>;

      expect(actualInstruction0['programIdIndex'], 3);
      expect(actualInstruction0['programId'], 'ComputeBudget111111111111111111111111111111');
      expect(actualInstructionDecoded0['type'], 'computeBudget');
      expect(actualInstructionDecoded0['baseFee'], 20000000);

      expect(actualInstruction1['programIdIndex'], 3);
      expect(actualInstruction1['programId'], 'ComputeBudget111111111111111111111111111111');
      expect(actualInstructionDecoded1['type'], 'computeBudget');
      expect(actualInstructionDecoded1['heapFrameBytes'], 495);

      expect(actualInstruction2['programIdIndex'], 2);
      expect(actualInstruction2['programId'], '11111111111111111111111111111111');
      expect(actualInstructionDecoded2['type'], 'solTransfer');
      expect(actualInstructionDecoded2['from'], '2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19');
      expect(actualInstructionDecoded2['to'], '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z');
      expect(actualInstructionDecoded2['amount'], 1000000000);
    });
  });

  group('Tests of SolanaLegacyMessage.toString()', () {
    test('Should [return indented JSON string]', () {
      // Arrange
      Uint8List actualSolanaLegacyMessageBytes = Base58Codec.decode(
          '8XvVPnpTLZqLmFm1xXHBushdVTcZDpbgbTXtmAATXbzBDyBpaoMcvxWRRwjpBpHdeJSEC5FJUB8xDAn5eZWGetF96KzQv7cdVXP1e3H2dpkgpTaNsgJD8JLgowf8LEsjBya3oog6S3hwa7VgSDAvJHXVrGPRbCxoxt2ELwT1ZANor9BnZLz2PGhpF8SDWHZkSxyEkPWxMiCpqJGYD5WqB5hS8Br5dk2HcHpRvYxxPuzfoHygJECu4JyZLgnd39qQwk9nS8UuBiAg9wXS6B1');

      // Act
      SolanaLegacyMessage actualSolanaLegacyMessage = SolanaLegacyMessage.fromBytes(actualSolanaLegacyMessageBytes);
      String actualString = actualSolanaLegacyMessage.toString();

      // Assert
      expect(actualString, startsWith('{\n'));
      expect(actualString, contains('"numRequiredSignatures": 1'));
      expect(actualString, contains('"numReadonlySignedAccounts": 0'));
      expect(actualString, contains('"numReadonlyUnsignedAccounts": 2'));
      expect(actualString, contains('"accountKeys":'));
      expect(actualString, contains('"2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19"'));
      expect(actualString, contains('"6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z"'));
      expect(actualString, contains('"11111111111111111111111111111111"'));
      expect(actualString, contains('"ComputeBudget111111111111111111111111111111"'));
      expect(actualString, contains('"recentBlockhash": "DqdWewkZSAEPeC8sY4SFApoiMbYy6ScMP7JSVhyViNEV"'));
      expect(actualString, contains('"programIdIndex": 3'));
      expect(actualString, contains('"programId": "ComputeBudget111111111111111111111111111111"'));
      expect(actualString, contains('"accountIndices": []'));
      expect(actualString, contains('"rawDataHex": "03 00 2d 31 01 00 00 00 00"'));
      expect(actualString, contains('"decoded":'));
      expect(actualString, contains('"type": "computeBudget"'));
      expect(actualString, contains('"baseFee": 20000000'));
      expect(actualString, contains('"rawDataHex": "02 ef 01 00 00"'));
      expect(actualString, contains('"heapFrameBytes": 495'));
      expect(actualString, contains('"programIdIndex": 2'));
      expect(actualString, contains('"programId": "11111111111111111111111111111111"'));
      expect(actualString, contains('"accountIndices": '));
      expect(actualString, contains('"rawDataHex": "02 00 00 00 00 ca 9a 3b 00 00 00 00"'));
      expect(actualString, contains('"type": "solTransfer"'));
      expect(actualString, contains('"from": "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19"'));
      expect(actualString, contains('"to": "6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z"'));
      expect(actualString, contains('"amount": 1000000000'));
    });
  });
}
