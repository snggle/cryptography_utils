import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaV0Message.fromBytes()', () {
    test('Should [return SolanaV0Message] from bytes', () {
      // Arrange
      Uint8List actualSolanaV0MessageBytes = base64Decode(
          'gAEACRCsVML2Bg3dHy0Va9dcV1Z/NhGHyVYhJ0jE+0MRGFemVlZ3NFh19IgWu+pj5UeQzMrHbNYffxTTr/qv3cxI4kqkZn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yRxM32R3yvnX/HBzojB9fApPOfuRWL27j4EX6B/qtMR3YqLvMXqaJtR7xJ7zz/wsSOSpUxQmyAwTUxIhtPBZFuDzN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Szf79GhSuUqLOYVkL1+ideK6TTiYEoL0lh29rNcfXJYfgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAAEedVb8jHAbu50xW7OaBUH/bGy3qP0jlECsc2iVrwTjwbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpUmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXqMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WZqAC/9MhzaIlsIPwUBz6/HLWqN1/oH+Tb3IK6Tft154tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5ejnStls42Wf0xNRAChL93gEW4UQqPNOSYySLu5vwwX4aYsnkR0YRptLIlfQajrMt0F6AtCnIcxppx3jdg3dGvKxBwgABQLGggMACAAJA1IqNQAAAAAADAYABAAXBwoBAQcCAAQMAgAAAM8ntAgAAAAACgEEAREJJwoNAAQDAgUXGgYJDgkZEg8LEBEDARMTGA0KGRUPCxYUAgETExMNCirBIJszQdacgQICAAAAOgFkAAE6AGQBAs8ntAgAAAAACKmKAQAAAAAyAFAKAwQAAAEJAsFXUcXB+MMMeYa6oBoJLmvxqJ7+KcwGc/y1N+Qd8kpZBHd2eHkEBnp1Uxbx7FnCE40ksuuuv14pM6i4jtdWtEsGPK0+XdwvqvOLA76/uwA=');

      // Act
      SolanaV0Message actualSolanaV0Message = SolanaV0Message.fromBytes(actualSolanaV0MessageBytes);

      Map<String, dynamic> actualJson = actualSolanaV0Message.toJson();
      List<dynamic> actualInstructionsList = actualJson['instructions'] as List<dynamic>;
      List<Map<String, dynamic>> actualInstructions = List<Map<String, dynamic>>.from(actualJson['instructions'] as List<dynamic>);
      Map<String, dynamic> actualInstruction0 = actualInstructions[0];
      Map<String, dynamic> actualInstruction1 = actualInstructions[1];
      Map<String, dynamic> actualInstruction2 = actualInstructions[2];
      Map<String, dynamic> actualInstruction3 = actualInstructions[3];
      Map<String, dynamic> actualInstruction4 = actualInstructions[4];
      Map<String, dynamic> actualInstruction5 = actualInstructions[5];
      Map<String, dynamic> actualInstruction6 = actualInstructions[6];

      Map<String, dynamic> actualInstructionDecoded0 = actualInstruction0['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded1 = actualInstruction1['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded2 = actualInstruction2['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded3 = actualInstruction3['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded4 = actualInstruction4['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded5 = actualInstruction5['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded6 = actualInstruction6['decoded'] as Map<String, dynamic>;

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

      expect(actualSolanaV0Message.numRequiredSignatures, 1);
      expect(actualSolanaV0Message.numReadonlySignedAccounts, 0);
      expect(actualSolanaV0Message.numReadonlyUnsignedAccounts, 9);
      expect(actualSolanaV0Message.accountKeys.map(Base58Codec.encode).toList(), expectedAccountKeys);
      expect(Base58Codec.encode(actualSolanaV0Message.recentBlockhash), 'ANCfTi42idFEoiqwvagoqehUzArgbq3N6obb3Lgvhmfv');

      expect(actualJson['addressTableLookups'], <Map<String, Object>>[
        <String, Object>{
          'accountKey': 'E1iuryq4fcxyqfQZginfahXTyBC3XmDNsVjSDukkyUrc',
          'writableIndexes': <int>[119, 118, 120, 121],
          'readonlyIndexes': <int>[6, 122, 117, 83]
        },
        <String, Object>{
          'accountKey': '2YZvo6LkePK8V2G2ZaS8UxBYX2Ph6udCu5iuaYAqVM38',
          'writableIndexes': <int>[190, 191, 187],
          'readonlyIndexes': <int>[]
        }
      ]);

      expect(actualInstructionsList.length, 7);

      expect(actualInstruction0['programIdIndex'], 8);
      expect(actualInstruction0['programId'], 'ComputeBudget111111111111111111111111111111');
      expect(actualInstruction0['rawDataHex'], '02 c6 82 03 00');
      expect(actualInstructionDecoded0['type'], 'computeBudget');
      expect(actualInstructionDecoded0['heapFrameBytes'], 230086);

      expect(actualInstruction1['programIdIndex'], 8);
      expect(actualInstruction1['programId'], 'ComputeBudget111111111111111111111111111111');
      expect(actualInstructionDecoded1['baseFee'], 3484242);

      expect(actualInstruction2['programIdIndex'], 12);
      expect(actualInstruction2['programId'], 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL');
      expect(actualInstructionDecoded2['type'], 'swap');
      expect(actualInstructionDecoded2['from'], 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7');
      expect(actualInstructionDecoded2['to'], 'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY');

      expect(actualInstruction3['programId'], '11111111111111111111111111111111');
      expect(actualInstructionDecoded3['type'], 'solTransfer');
      expect(actualInstructionDecoded3['amount'], 146024399);

      expect(actualInstruction4['programId'], 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');
      expect(actualInstructionDecoded4['type'], 'unknown');

      expect(actualInstruction5['programId'], 'JUP6LkbZbjS1jKKwapdHNy74zcZ3tLUZoi5QNyVTaV4');
      expect(actualInstructionDecoded5['type'], 'unknown');

      expect(actualInstruction6['programId'], 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');
      expect(actualInstructionDecoded6['type'], 'unknown');
    });
  });

  group('Tests of SolanaV0Message.toJson()', () {
    test('Should [convert SolanaV0Message to JSON]', () {
      // Arrange
      Uint8List actualSolanaV0MessageBytes = base64Decode(
          'gAEACRCsVML2Bg3dHy0Va9dcV1Z/NhGHyVYhJ0jE+0MRGFemVlZ3NFh19IgWu+pj5UeQzMrHbNYffxTTr/qv3cxI4kqkZn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yRxM32R3yvnX/HBzojB9fApPOfuRWL27j4EX6B/qtMR3YqLvMXqaJtR7xJ7zz/wsSOSpUxQmyAwTUxIhtPBZFuDzN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Szf79GhSuUqLOYVkL1+ideK6TTiYEoL0lh29rNcfXJYfgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAAEedVb8jHAbu50xW7OaBUH/bGy3qP0jlECsc2iVrwTjwbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpUmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXqMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WZqAC/9MhzaIlsIPwUBz6/HLWqN1/oH+Tb3IK6Tft154tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5ejnStls42Wf0xNRAChL93gEW4UQqPNOSYySLu5vwwX4aYsnkR0YRptLIlfQajrMt0F6AtCnIcxppx3jdg3dGvKxBwgABQLGggMACAAJA1IqNQAAAAAADAYABAAXBwoBAQcCAAQMAgAAAM8ntAgAAAAACgEEAREJJwoNAAQDAgUXGgYJDgkZEg8LEBEDARMTGA0KGRUPCxYUAgETExMNCirBIJszQdacgQICAAAAOgFkAAE6AGQBAs8ntAgAAAAACKmKAQAAAAAyAFAKAwQAAAEJAsFXUcXB+MMMeYa6oBoJLmvxqJ7+KcwGc/y1N+Qd8kpZBHd2eHkEBnp1Uxbx7FnCE40ksuuuv14pM6i4jtdWtEsGPK0+XdwvqvOLA76/uwA=');

      // Act
      String actualSolanaV0MessageString = SolanaV0Message.fromBytes(actualSolanaV0MessageBytes).toString();

      expect(actualSolanaV0MessageString, contains('"numRequiredSignatures": 1'));
      expect(actualSolanaV0MessageString, contains('"recentBlockhash": "ANCfTi42idFEoiqwvagoqehUzArgbq3N6obb3Lgvhmfv"'));
    });
  });

  group('Tests of SolanaV0Message.toJson()', () {
    test('Should [convert SolanaV0Message to JSON]', () {
      // Arrange
      Uint8List actualSolanaV0MessageBytes = base64Decode(
          'gAEACRCsVML2Bg3dHy0Va9dcV1Z/NhGHyVYhJ0jE+0MRGFemVlZ3NFh19IgWu+pj5UeQzMrHbNYffxTTr/qv3cxI4kqkZn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yRxM32R3yvnX/HBzojB9fApPOfuRWL27j4EX6B/qtMR3YqLvMXqaJtR7xJ7zz/wsSOSpUxQmyAwTUxIhtPBZFuDzN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Szf79GhSuUqLOYVkL1+ideK6TTiYEoL0lh29rNcfXJYfgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAAEedVb8jHAbu50xW7OaBUH/bGy3qP0jlECsc2iVrwTjwbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpUmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXqMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WZqAC/9MhzaIlsIPwUBz6/HLWqN1/oH+Tb3IK6Tft154tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5ejnStls42Wf0xNRAChL93gEW4UQqPNOSYySLu5vwwX4aYsnkR0YRptLIlfQajrMt0F6AtCnIcxppx3jdg3dGvKxBwgABQLGggMACAAJA1IqNQAAAAAADAYABAAXBwoBAQcCAAQMAgAAAM8ntAgAAAAACgEEAREJJwoNAAQDAgUXGgYJDgkZEg8LEBEDARMTGA0KGRUPCxYUAgETExMNCirBIJszQdacgQICAAAAOgFkAAE6AGQBAs8ntAgAAAAACKmKAQAAAAAyAFAKAwQAAAEJAsFXUcXB+MMMeYa6oBoJLmvxqJ7+KcwGc/y1N+Qd8kpZBHd2eHkEBnp1Uxbx7FnCE40ksuuuv14pM6i4jtdWtEsGPK0+XdwvqvOLA76/uwA=');

      // Act
      SolanaV0Message actualSolanaV0Message = SolanaV0Message.fromBytes(actualSolanaV0MessageBytes);
      Map<String, dynamic> actualJson = actualSolanaV0Message.toJson();

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

      expect(actualJson['numRequiredSignatures'], 1);
      expect(actualJson['numReadonlySignedAccounts'], 0);
      expect(actualJson['numReadonlyUnsignedAccounts'], 9);
      expect(actualJson['accountKeys'], expectedAccountKeys);
      expect(actualJson['recentBlockhash'], 'ANCfTi42idFEoiqwvagoqehUzArgbq3N6obb3Lgvhmfv');
      expect(actualJson['instructions'], isA<List<dynamic>>());
      expect((actualJson['instructions'] as List<dynamic>).length, 7);

      List<dynamic> actualInstructionsList = actualJson['instructions'] as List<dynamic>;
      List<Map<String, dynamic>> actualInstructions = List<Map<String, dynamic>>.from(actualJson['instructions'] as List<dynamic>);
      Map<String, dynamic> actualInstruction0 = actualInstructions[0];
      Map<String, dynamic> actualInstruction1 = actualInstructions[1];
      Map<String, dynamic> actualInstruction2 = actualInstructions[2];
      Map<String, dynamic> actualInstruction3 = actualInstructions[3];
      Map<String, dynamic> actualInstruction4 = actualInstructions[4];
      Map<String, dynamic> actualInstruction5 = actualInstructions[5];
      Map<String, dynamic> actualInstruction6 = actualInstructions[6];

      Map<String, dynamic> actualInstructionDecoded0 = actualInstruction0['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded1 = actualInstruction1['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded2 = actualInstruction2['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded3 = actualInstruction3['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded4 = actualInstruction4['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded5 = actualInstruction5['decoded'] as Map<String, dynamic>;
      Map<String, dynamic> actualInstructionDecoded6 = actualInstruction6['decoded'] as Map<String, dynamic>;

      expect(actualInstructionsList.length, 7);

      expect(actualInstruction0['programIdIndex'], 8);
      expect(actualInstruction0['programId'], 'ComputeBudget111111111111111111111111111111');
      expect(actualInstruction0['rawDataHex'], '02 c6 82 03 00');
      expect(actualInstructionDecoded0['type'], 'computeBudget');
      expect(actualInstructionDecoded0['heapFrameBytes'], 230086);

      expect(actualInstruction1['programIdIndex'], 8);
      expect(actualInstruction1['programId'], 'ComputeBudget111111111111111111111111111111');
      expect(actualInstructionDecoded1['baseFee'], 3484242);

      expect(actualInstruction2['programIdIndex'], 12);
      expect(actualInstruction2['programId'], 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL');
      expect(actualInstructionDecoded2['type'], 'swap');
      expect(actualInstructionDecoded2['from'], 'Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7');
      expect(actualInstructionDecoded2['to'], 'AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY');

      expect(actualInstruction3['programId'], '11111111111111111111111111111111');
      expect(actualInstructionDecoded3['type'], 'solTransfer');
      expect(actualInstructionDecoded3['amount'], 146024399);

      expect(actualInstruction4['programId'], 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');
      expect(actualInstructionDecoded4['type'], 'unknown');

      expect(actualInstruction5['programId'], 'JUP6LkbZbjS1jKKwapdHNy74zcZ3tLUZoi5QNyVTaV4');
      expect(actualInstructionDecoded5['type'], 'unknown');

      expect(actualInstruction6['programId'], 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA');
      expect(actualInstructionDecoded6['type'], 'unknown');
    });
  });

  group('Tests of SolanaV0Message.toString()', () {
    test('Should [return indented JSON string]', () {
      // Arrange
      Uint8List actualSolanaV0MessageBytes = base64Decode(
          'gAEACRCsVML2Bg3dHy0Va9dcV1Z/NhGHyVYhJ0jE+0MRGFemVlZ3NFh19IgWu+pj5UeQzMrHbNYffxTTr/qv3cxI4kqkZn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yRxM32R3yvnX/HBzojB9fApPOfuRWL27j4EX6B/qtMR3YqLvMXqaJtR7xJ7zz/wsSOSpUxQmyAwTUxIhtPBZFuDzN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Szf79GhSuUqLOYVkL1+ideK6TTiYEoL0lh29rNcfXJYfgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAAEedVb8jHAbu50xW7OaBUH/bGy3qP0jlECsc2iVrwTjwbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpUmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXqMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WZqAC/9MhzaIlsIPwUBz6/HLWqN1/oH+Tb3IK6Tft154tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5ejnStls42Wf0xNRAChL93gEW4UQqPNOSYySLu5vwwX4aYsnkR0YRptLIlfQajrMt0F6AtCnIcxppx3jdg3dGvKxBwgABQLGggMACAAJA1IqNQAAAAAADAYABAAXBwoBAQcCAAQMAgAAAM8ntAgAAAAACgEEAREJJwoNAAQDAgUXGgYJDgkZEg8LEBEDARMTGA0KGRUPCxYUAgETExMNCirBIJszQdacgQICAAAAOgFkAAE6AGQBAs8ntAgAAAAACKmKAQAAAAAyAFAKAwQAAAEJAsFXUcXB+MMMeYa6oBoJLmvxqJ7+KcwGc/y1N+Qd8kpZBHd2eHkEBnp1Uxbx7FnCE40ksuuuv14pM6i4jtdWtEsGPK0+XdwvqvOLA76/uwA=');

      // Act
      SolanaV0Message actualSolanaV0Message = SolanaV0Message.fromBytes(actualSolanaV0MessageBytes);
      String actualString = actualSolanaV0Message.toString();

      // Assert
      expect(actualString, startsWith('{\n'));
      expect(actualString, contains('"numRequiredSignatures": 1'));
      expect(actualString, contains('"numReadonlySignedAccounts": 0'));
      expect(actualString, contains('"numReadonlyUnsignedAccounts": 9'));
      expect(actualString, contains('"accountKeys":'));
      expect(actualString, contains('"Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7"'));
      expect(actualString, contains('"6pXVFSACE5BND2C3ibGRWMG1fNtV7hfynWrfNKtCXhN3"'));
      expect(actualString, contains('"7u7cD7NxcZEuzRCBaYo8uVpotRdqZwez47vvuwzCov43"'));
      expect(actualString, contains('"8ctcHN52LY21FEipCjr1MVWtoZa1irJQTPyAaTj72h7S"'));
      expect(actualString, contains('"AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY"'));
      expect(actualString, contains('"EnkAmi1xfv2rFnuU26uKn1jnAaKrg2CET3L6oF6r4Nh1"'));
      expect(actualString, contains('"G5A1npyNuMZ69GNjLTidScK42z3UZNJsmDprHfnrhCcM"'));
      expect(actualString, contains('"11111111111111111111111111111111"'));
      expect(actualString, contains('"ComputeBudget111111111111111111111111111111"'));
      expect(actualString, contains('"JUP6LkbZbjS1jKKwapdHNy74zcZ3tLUZoi5QNyVTaV4"'));
      expect(actualString, contains('"TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA"'));
      expect(actualString, contains('"6YawcNeZ74tRyCv4UfGydYMr7eho7vbUR6ScVffxKAb3"'));
      expect(actualString, contains('"ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL"'));
      expect(actualString, contains('"BQ72nSv9f3PRyRKCBnHLVrerrv37CYTHm5h3s9VSGQDV"'));
      expect(actualString, contains('"D8cy77BBepLMngZx6ZukaTff5hCt1HrWyKk3Hnd9oitf"'));
      expect(actualString, contains('"GZsNmWKbqhMYtdSkkvMdEyQF9k5mLmP7tTKYWZjcHVPE"'));
      expect(actualString, contains('"recentBlockhash": "ANCfTi42idFEoiqwvagoqehUzArgbq3N6obb3Lgvhmfv"'));
      expect(actualString, contains('"programIdIndex": 8'));
      expect(actualString, contains('"programId": "ComputeBudget111111111111111111111111111111"'));
      expect(actualString, contains('"accountIndices": []'));
      expect(actualString, contains('"rawDataHex": "02 c6 82 03 00"'));
      expect(actualString, contains('"decoded":'));
      expect(actualString, contains('"type": "computeBudget"'));
      expect(actualString, contains('"heapFrameBytes": 230086'));
      expect(actualString, contains('"programId": "11111111111111111111111111111111"'));
      expect(actualString, contains('"type": "swap"'));
      expect(actualString, contains('"from": "Cbi65bkTUnJWG8uesnCHg2gAEj4ujeD1SamJPe78fdq7"'));
      expect(actualString, contains('"to": "AKpr7UPK7JdQ1BjqkNmo1HQUMwve8EW6EZQhZRbiHPPY"'));
    });
  });
}
