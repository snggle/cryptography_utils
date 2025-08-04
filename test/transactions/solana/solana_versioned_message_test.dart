import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaV0Message.fromSerializedData()', ()
  {
    test('Should [return SolanaV0Message] from serialized data', () {
      // Arrange
      Uint8List actualSolanaV0MessageBytes = base64Decode(
          'gAEACRCsVML2Bg3dHy0Va9dcV1Z/NhGHyVYhJ0jE+0MRGFemVlZ3NFh19IgWu+pj5UeQzMrHbNYffxTTr/qv3cxI4kqkZn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yRxM32R3yvnX/HBzojB9fApPOfuRWL27j4EX6B/qtMR3YqLvMXqaJtR7xJ7zz/wsSOSpUxQmyAwTUxIhtPBZFuDzN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Szf79GhSuUqLOYVkL1+ideK6TTiYEoL0lh29rNcfXJYfgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAAEedVb8jHAbu50xW7OaBUH/bGy3qP0jlECsc2iVrwTjwbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpUmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXqMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WZqAC/9MhzaIlsIPwUBz6/HLWqN1/oH+Tb3IK6Tft154tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5ejnStls42Wf0xNRAChL93gEW4UQqPNOSYySLu5vwwX4aYsnkR0YRptLIlfQajrMt0F6AtCnIcxppx3jdg3dGvKxBwgABQLGggMACAAJA1IqNQAAAAAADAYABAAXBwoBAQcCAAQMAgAAAM8ntAgAAAAACgEEAREJJwoNAAQDAgUXGgYJDgkZEg8LEBEDARMTGA0KGRUPCxYUAgETExMNCirBIJszQdacgQICAAAAOgFkAAE6AGQBAs8ntAgAAAAACKmKAQAAAAAyAFAKAwQAAAEJAsFXUcXB+MMMeYa6oBoJLmvxqJ7+KcwGc/y1N+Qd8kpZBHd2eHkEBnp1Uxbx7FnCE40ksuuuv14pM6i4jtdWtEsGPK0+XdwvqvOLA76/uwA=');

      // Act
      SolanaV0Message actualSolanaV0Message = SolanaV0Message.fromSerializedData(actualSolanaV0MessageBytes);

      // Assert
      List<String> expectedAccountKeys = <String>[
        'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7',
        '6pXVFSACE5BND2C3ibGRWMG1fNtV7hfynWrfNKtCXhN3',
        '7u7cD7NxcZEuzRCBaYo8uVpotRdqZwez47vvuwzCov43',
        '8ctcHN52LY21FEipCjr1MVWtoZa1irJQTPyAaTj72h7S',
        'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY',
        'EnkAmi1xfv2rFnuU26uKn1jnAaKrg2CET3L6oF6r4Nh1',
        'G5A1npyNuMZ69GNjLTidScK42z3UZNJsmDprHfnrhCcM',
        '11111111111111111111111111111111',
        'ComputeBudget111111111111111111111111111111',
        'JUP6LkbZbjS1jKKwapdHNy74zcZ3tLUZoi5QNyVTaV4',
        'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
        '6YawcNeZ74tRyCv4UfGydYMr7eho7vbUR6ScVffxKAb3',
        'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL',
        'BQ72nSv9f3PRyRKCBnHLVrerrv37CYTHm5h3s9VSGQDV',
        'D8cy77BBepLMngZx6ZukaTff5hCt1HrWyKk3Hnd9oitf',
        'GZsNmWKbqhMYtdSkkvMdEyQF9k5mLmP7tTKYWZjcHVPE'
      ];

      expect(actualSolanaV0Message.header.numRequiredSignatures, 1);
      expect(actualSolanaV0Message.header.numReadonlySignedAccounts, 0);
      expect(actualSolanaV0Message.header.numReadonlyUnsignedAccounts, 9);
      expect(actualSolanaV0Message.accountKeysList.map(Base58Codec.encode).toList(), expectedAccountKeys);
      expect(Base58Codec.encode(actualSolanaV0Message.recentBlockhash), 'ANCfTi42idFEoiqwvagoqehUzArgbq3N6obb3Lgvhmfv');
      expect(actualSolanaV0Message.solanaInstructionList.length, 7);

      ASolanaInstructionDecoded actualSolanaInstruction0Decoded =
      ASolanaInstructionDecoded.decode(actualSolanaV0Message.solanaInstructionList[0], actualSolanaV0Message.accountKeysList);
      ASolanaInstructionDecoded actualSolanaInstruction1Decoded =
      ASolanaInstructionDecoded.decode(actualSolanaV0Message.solanaInstructionList[1], actualSolanaV0Message.accountKeysList);
      ASolanaInstructionDecoded actualSolanaInstruction2Decoded =
      ASolanaInstructionDecoded.decode(actualSolanaV0Message.solanaInstructionList[2], actualSolanaV0Message.accountKeysList);
      ASolanaInstructionDecoded actualSolanaInstruction3Decoded =
      ASolanaInstructionDecoded.decode(actualSolanaV0Message.solanaInstructionList[3], actualSolanaV0Message.accountKeysList);
      ASolanaInstructionDecoded actualSolanaInstruction4Decoded =
      ASolanaInstructionDecoded.decode(actualSolanaV0Message.solanaInstructionList[4], actualSolanaV0Message.accountKeysList);
      ASolanaInstructionDecoded actualSolanaInstruction5Decoded =
      ASolanaInstructionDecoded.decode(actualSolanaV0Message.solanaInstructionList[5], actualSolanaV0Message.accountKeysList);
      ASolanaInstructionDecoded actualSolanaInstruction6Decoded =
      ASolanaInstructionDecoded.decode(actualSolanaV0Message.solanaInstructionList[6], actualSolanaV0Message.accountKeysList);

      expect(actualSolanaInstruction0Decoded, isA<ComputeBudgetUnitLimitInstruction>());
      expect(actualSolanaInstruction0Decoded.programId, 'ComputeBudget111111111111111111111111111111');
      expect(actualSolanaInstruction0Decoded.unitLimit, 230086);

      expect(actualSolanaInstruction1Decoded, isA<ComputeBudgetUnitPriceInstruction>());
      expect(actualSolanaInstruction1Decoded.programId, 'ComputeBudget111111111111111111111111111111');
      expect(actualSolanaInstruction1Decoded.unitPrice, 3484242);

      expect(actualSolanaInstruction2Decoded, isA<SwapInstruction>());
      expect(actualSolanaInstruction2Decoded.programId, 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL');
      expect(actualSolanaInstruction2Decoded.sender, 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7');
      expect(actualSolanaInstruction2Decoded.recipient, 'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY');

      expect(actualSolanaInstruction3Decoded, isA<SystemTransferInstruction>());
      expect(actualSolanaInstruction3Decoded.programId, '11111111111111111111111111111111');
      expect(actualSolanaInstruction3Decoded.sender, 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7');
      expect(actualSolanaInstruction3Decoded.recipient, 'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY');

      expect(actualSolanaInstruction4Decoded, isA<UnknownInstruction>());
      expect(actualSolanaInstruction4Decoded.programId, 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');

      expect(actualSolanaInstruction5Decoded, isA<UnknownInstruction>());
      expect(actualSolanaInstruction5Decoded.programId, 'JUP6LkbZbjS1jKKwapdHNy74zcZ3tLUZoi5QNyVTaV4');

      expect(actualSolanaInstruction6Decoded, isA<UnknownInstruction>());
      expect(actualSolanaInstruction6Decoded.programId, 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');
    });
  });
}
