import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_address_lookup_table.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaV0Message.fromSerializedData()', () {
    test('Should [return SolanaV0Message] from serialized data', () {
      // Act
      SolanaV0Message actualSolanaV0Message = SolanaV0Message.fromSerializedData(base64Decode(
          'gAEACRCsVML2Bg3dHy0Va9dcV1Z/NhGHyVYhJ0jE+0MRGFemVlZ3NFh19IgWu+pj5UeQzMrHbNYffxTTr/qv3cxI4kqkZn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y1yRxM32R3yvnX/HBzojB9fApPOfuRWL27j4EX6B/qtMR3YqLvMXqaJtR7xJ7zz/wsSOSpUxQmyAwTUxIhtPBZFuDzN/gj1H6SStJcojxfyVSBM4CsNHf9s8Fuywijv3R7Szf79GhSuUqLOYVkL1+ideK6TTiYEoL0lh29rNcfXJYfgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAAEedVb8jHAbu50xW7OaBUH/bGy3qP0jlECsc2iVrwTjwbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpUmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXqMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WZqAC/9MhzaIlsIPwUBz6/HLWqN1/oH+Tb3IK6Tft154tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5ejnStls42Wf0xNRAChL93gEW4UQqPNOSYySLu5vwwX4aYsnkR0YRptLIlfQajrMt0F6AtCnIcxppx3jdg3dGvKxBwgABQLGggMACAAJA1IqNQAAAAAADAYABAAXBwoBAQcCAAQMAgAAAM8ntAgAAAAACgEEAREJJwoNAAQDAgUXGgYJDgkZEg8LEBEDARMTGA0KGRUPCxYUAgETExMNCirBIJszQdacgQICAAAAOgFkAAE6AGQBAs8ntAgAAAAACKmKAQAAAAAyAFAKAwQAAAEJAsFXUcXB+MMMeYa6oBoJLmvxqJ7+KcwGc/y1N+Qd8kpZBHd2eHkEBnp1Uxbx7FnCE40ksuuuv14pM6i4jtdWtEsGPK0+XdwvqvOLA76/uwA='));

      // Assert
      SolanaV0Message expectedSolanaV0Message = SolanaV0Message(
          header: const SolanaMessageHeader(numRequiredSignatures: 1, numReadonlySignedAccounts: 0, numReadonlyUnsignedAccounts: 9),
          accountKeysList: <SolanaPubKey>[
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
          ],
          recentBlockhash: Base58Codec.decode('ANCfTi42idFEoiqwvagoqehUzArgbq3N6obb3Lgvhmfv'),
          compiledInstructions: <SolanaCompiledInstruction>[
            SolanaCompiledInstruction(programIdIndex: 8, accounts: Uint8List(0), data: Uint8List.fromList(<int>[2, 198, 130, 3, 0])),
            SolanaCompiledInstruction(programIdIndex: 8, accounts: Uint8List(0), data: Uint8List.fromList(<int>[3, 82, 42, 53, 0, 0, 0, 0, 0])),
            SolanaCompiledInstruction(
                programIdIndex: 12, accounts: Uint8List.fromList(<int>[0, 4, 0, 23, 7, 10]), data: Uint8List.fromList(<int>[1])),
            SolanaCompiledInstruction(
                programIdIndex: 7,
                accounts: Uint8List.fromList(<int>[0, 4]),
                data: Uint8List.fromList(<int>[2, 0, 0, 0, 207, 39, 180, 8, 0, 0, 0, 0])),
            SolanaCompiledInstruction(programIdIndex: 10, accounts: Uint8List.fromList(<int>[4]), data: Uint8List.fromList(<int>[17])),
            SolanaCompiledInstruction(
                programIdIndex: 9,
                accounts: base64Decode('Cg0ABAMCBRcaBgkOCRkSDwsQEQMBExMYDQoZFQ8LFhQCARMTEw0K'),
                data: base64Decode('wSCbM0HWnIECAgAAADoBZAABOgBkAQLPJ7QIAAAAAAipigEAAAAAMgBQ')),
            SolanaCompiledInstruction(programIdIndex: 10, accounts: Uint8List.fromList(<int>[4, 0, 0]), data: Uint8List.fromList(<int>[9])),
          ],
          addressLookupTableList: <SolanaAddressLookupTable>[
            SolanaAddressLookupTable(
                accountKey: SolanaPubKey.fromBytes(base64Decode('wVdRxcH4wwx5hrqgGgkua/Gonv4pzAZz/LU35B3ySlk=')),
                writableIndexesList: const <int>[119, 118, 120, 121],
                readonlyIndexesList: const <int>[6, 122, 117, 83]),
            SolanaAddressLookupTable(
                accountKey: SolanaPubKey.fromBytes(base64Decode('FvHsWcITjSSy666/XikzqLiO11a0SwY8rT5d3C+q84s=')),
                readonlyIndexesList: const <int>[],
                writableIndexesList: const <int>[190, 191, 187])
          ]);

      expect(actualSolanaV0Message, expectedSolanaV0Message);
    });
  });
}
