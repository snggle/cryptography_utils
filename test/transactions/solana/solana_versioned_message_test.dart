import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_address_lookup_table.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaV0Message.fromSerializedData()', () {
    test('Should [return SolanaV0Message] from serialized data', () {
      // Arrange
      Uint8List actualSolanaV0MessageBytes = base64Decode(
          'gAEACRCsVML2Bg3dHy0Va9dcV1Z/NhGHyVYhJ0jE+0MRGFemVlZ3NFh19IgWu+pj5UeQzMrHbNYffxTTr/qv3cxI4kqkZn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yRxM32R3yvnX/HBzojB9fApPOfuRWL27j4EX6B/qtMR3YqLvMXqaJtR7xJ7zz/wsSOSpUxQmyAwTUxIhtPBZFuDzN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Szf79GhSuUqLOYVkL1+ideK6TTiYEoL0lh29rNcfXJYfgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAAEedVb8jHAbu50xW7OaBUH/bGy3qP0jlECsc2iVrwTjwbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpUmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXqMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WZqAC/9MhzaIlsIPwUBz6/HLWqN1/oH+Tb3IK6Tft154tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5ejnStls42Wf0xNRAChL93gEW4UQqPNOSYySLu5vwwX4aYsnkR0YRptLIlfQajrMt0F6AtCnIcxppx3jdg3dGvKxBwgABQLGggMACAAJA1IqNQAAAAAADAYABAAXBwoBAQcCAAQMAgAAAM8ntAgAAAAACgEEAREJJwoNAAQDAgUXGgYJDgkZEg8LEBEDARMTGA0KGRUPCxYUAgETExMNCirBIJszQdacgQICAAAAOgFkAAE6AGQBAs8ntAgAAAAACKmKAQAAAAAyAFAKAwQAAAEJAsFXUcXB+MMMeYa6oBoJLmvxqJ7+KcwGc/y1N+Qd8kpZBHd2eHkEBnp1Uxbx7FnCE40ksuuuv14pM6i4jtdWtEsGPK0+XdwvqvOLA76/uwA=');

      // Act
      SolanaV0Message actualSolanaV0Message = SolanaV0Message.fromSerializedData(actualSolanaV0MessageBytes);

      // Assert
      SolanaMessageHeader expectedSolanaMessageHeader =
          const SolanaMessageHeader(numRequiredSignatures: 1, numReadonlySignedAccounts: 0, numReadonlyUnsignedAccounts: 9);
      List<SolanaPubKey> expectedAccountKeys = <SolanaPubKey>[
        SolanaPubKey.fromBase58('Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7'),
        SolanaPubKey.fromBase58('6pXVFSACE5BND2C3ibGRWMG1fNtV7hfynWrfNKtCXhN3'),
        SolanaPubKey.fromBase58('7u7cD7NxcZEuzRCBaYo8uVpotRdqZwez47vvuwzCov43'),
        SolanaPubKey.fromBase58('8ctcHN52LY21FEipCjr1MVWtoZa1irJQTPyAaTj72h7S'),
        SolanaPubKey.fromBase58('AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY'),
        SolanaPubKey.fromBase58('EnkAmi1xfv2rFnuU26uKn1jnAaKrg2CET3L6oF6r4Nh1'),
        SolanaPubKey.fromBase58('G5A1npyNuMZ69GNjLTidScK42z3UZNJsmDprHfnrhCcM'),
        SolanaPubKey.fromBase58('11111111111111111111111111111111'),
        SolanaPubKey.fromBase58('ComputeBudget111111111111111111111111111111'),
        SolanaPubKey.fromBase58('JUP6LkbZbjS1jKKwapdHNy74zcZ3tLUZoi5QNyVTaV4'),
        SolanaPubKey.fromBase58('TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA'),
        SolanaPubKey.fromBase58('6YawcNeZ74tRyCv4UfGydYMr7eho7vbUR6ScVffxKAb3'),
        SolanaPubKey.fromBase58('ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL'),
        SolanaPubKey.fromBase58('BQ72nSv9f3PRyRKCBnHLVrerrv37CYTHm5h3s9VSGQDV'),
        SolanaPubKey.fromBase58('D8cy77BBepLMngZx6ZukaTff5hCt1HrWyKk3Hnd9oitf'),
        SolanaPubKey.fromBase58('GZsNmWKbqhMYtdSkkvMdEyQF9k5mLmP7tTKYWZjcHVPE')
      ];
      List<SolanaCompiledInstruction> expectedCompiledInstructions = <SolanaCompiledInstruction>[
        SolanaCompiledInstruction(programIdIndex: 8, accounts: Uint8List(0), data: Uint8List.fromList(<int>[2, 198, 130, 3, 0])),
        SolanaCompiledInstruction(programIdIndex: 8, accounts: Uint8List(0), data: Uint8List.fromList(<int>[3, 82, 42, 53, 0, 0, 0, 0, 0])),
        SolanaCompiledInstruction(programIdIndex: 12, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1])),
        SolanaCompiledInstruction(programIdIndex: 7, accounts: Uint8List.fromList(<int>[0, 4]), data: Uint8List.fromList(<int>[2, 0, 0, 0, 207, 39, 180, 8, 0, 0, 0, 0])),
        SolanaCompiledInstruction(programIdIndex: 10, accounts: Uint8List.fromList(<int>[4]), data: Uint8List.fromList(<int>[17])),
        SolanaCompiledInstruction(programIdIndex: 9, accounts: Uint8List.fromList(<int>[10, 13, 0, 4, 3, 2, 5, 23, 26, 6, 9, 14, 9, 25, 18, 15, 11, 16, 17, 3, 1, 19, 19, 24, 13, 10, 25, 21, 15, 11, 22, 20, 2, 1, 19, 19, 19, 13, 10]), data: Uint8List.fromList(<int>[193, 32, 155, 51, 65, 214, 156, 129, 2, 2, 0, 0, 0, 58, 1, 100, 0, 1, 58, 0, 100, 1, 2, 207, 39, 180, 8, 0, 0, 0, 0, 8, 169, 138, 1, 0, 0, 0, 0, 50, 0, 80])),
        SolanaCompiledInstruction(programIdIndex: 10, accounts: Uint8List.fromList(<int>[4, 0, 0]), data: Uint8List.fromList(<int>[9])),
      ];
      Uint8List expecyedRecentBlockhash = Base58Codec.decode('ANCfTi42idFEoiqwvagoqehUzArgbq3N6obb3Lgvhmfv');
      List<SolanaAddressLookupTable> expectedAddressLookupTableList = <SolanaAddressLookupTable>[SolanaAddressLookupTable(accountKey: SolanaPubKey.fromBytes(Uint8List.fromList(<int>[193, 87, 81, 197, 193, 248, 195, 12, 121, 134, 186, 160, 26, 9, 46, 107, 241, 168, 158, 254, 41, 204, 6, 115, 252, 181, 55, 228, 29, 242, 74, 89])), writableIndexesList: const <int>[119, 118, 120, 121], readonlyIndexesList: const <int>[6, 122, 117, 83]), SolanaAddressLookupTable(accountKey: SolanaPubKey.fromBytes(Uint8List.fromList(<int>[22, 241, 236, 89, 194, 19, 141, 36, 178, 235, 174, 191, 94, 41, 51, 168, 184, 142, 215, 86, 180, 75, 6, 60, 173, 62, 93, 220, 47, 170, 243, 139])), readonlyIndexesList: const <int>[], writableIndexesList: const <int>[190, 191, 187])];
      SolanaV0Message expectedSolanaV0Message = SolanaV0Message(
          header: expectedSolanaMessageHeader,
          accountKeysList: expectedAccountKeys,
          recentBlockhash: expecyedRecentBlockhash,
          compiledInstructions: expectedCompiledInstructions,
          addressLookupTableList: expectedAddressLookupTableList);

      ASolanaInstructionDecoded actualSolanaComputeBudgetUnitLimitInstruction = actualSolanaV0Message.decodedInstructions[0];
      ASolanaInstructionDecoded actualSolanaComputeBudgetUnitPriceInstruction = actualSolanaV0Message.decodedInstructions[1];
      ASolanaInstructionDecoded actualSolanaSwapInstruction = actualSolanaV0Message.decodedInstructions[2];
      ASolanaInstructionDecoded actualSolanaSystemTransferInstruction = actualSolanaV0Message.decodedInstructions[3];
      ASolanaInstructionDecoded actualSolanaUnknownInstruction1 = actualSolanaV0Message.decodedInstructions[4];
      ASolanaInstructionDecoded actualSolanaUnknownInstruction2 = actualSolanaV0Message.decodedInstructions[5];
      ASolanaInstructionDecoded actualSolanaUnknownInstruction3 = actualSolanaV0Message.decodedInstructions[6];

      SolanaComputeBudgetUnitLimitInstruction expectedSolanaComputeBudgetUnitLimitInstruction =
          const SolanaComputeBudgetUnitLimitInstruction(programId: 'ComputeBudget111111111111111111111111111111', unitLimit: 230086);
      SolanaComputeBudgetUnitPriceInstruction expectedSolanaComputeBudgetUnitPriceInstruction =
          const SolanaComputeBudgetUnitPriceInstruction(programId: 'ComputeBudget111111111111111111111111111111', unitPrice: 3484242);
      SolanaSwapInstruction expectedSolanaSwapInstruction = const SolanaSwapInstruction(
          programId: 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL',
          associatedProgram: '11111111111111111111111111111111',
          signer: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
          tokenProgram: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
          recipient: 'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY',
          sender: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7');
      SolanaSystemTransferInstruction expectedSolanaSystemTransferInstruction = const SolanaSystemTransferInstruction(
          programId: '11111111111111111111111111111111',
          amount: 146024399,
          recipient: 'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY',
          sender: 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7');
      SolanaUnknownInstruction expectedSolanaUnknownInstruction1 =
          const SolanaUnknownInstruction(programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');
      SolanaUnknownInstruction expectedSolanaUnknownInstruction2 =
          const SolanaUnknownInstruction(programId: 'JUP6LkbZbjS1jKKwapdHNy74zcZ3tLUZoi5QNyVTaV4');
      SolanaUnknownInstruction expectedSolanaUnknownInstruction3 =
          const SolanaUnknownInstruction(programId: 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');

      expect(actualSolanaV0Message, expectedSolanaV0Message);
      expect(actualSolanaComputeBudgetUnitLimitInstruction, expectedSolanaComputeBudgetUnitLimitInstruction);
      expect(actualSolanaComputeBudgetUnitPriceInstruction, expectedSolanaComputeBudgetUnitPriceInstruction);
      expect(actualSolanaSwapInstruction, expectedSolanaSwapInstruction);
      expect(actualSolanaSystemTransferInstruction, expectedSolanaSystemTransferInstruction);
      expect(actualSolanaUnknownInstruction1, expectedSolanaUnknownInstruction1);
      expect(actualSolanaUnknownInstruction2, expectedSolanaUnknownInstruction2);
      expect(actualSolanaUnknownInstruction3, expectedSolanaUnknownInstruction3);
    });
  });
}
