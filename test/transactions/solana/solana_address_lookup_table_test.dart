// ignore_for_file: cascade_invocations
import 'dart:convert';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_address_lookup_table.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_pubkey.dart';
import 'package:test/test.dart';

void main() {
  group('SolanaAddressLookupTable.fromSerializedData()', () {
    test('Should [return SolanaAddressLookupTable] from serialized data', () {
      // Act
      SolanaAddressLookupTable actualSolanaAddressLookupTable = SolanaAddressLookupTable.fromSerializedData(
          ByteReader(base64Decode('wVdRxcH4wwx5hrqgGgkua/Gonv4pzAZz/LU35B3ySlkEd3Z4eQQGenVTFvHsWcITjSSy666/XikzqLiO11a0SwY8rT5d3C+q84sDvr+7AA==')));

      // Assert
      SolanaAddressLookupTable expectedSolanaAddressLookupTable = SolanaAddressLookupTable(
          accountKey: SolanaPubKey.fromBytes(base64Decode('wVdRxcH4wwx5hrqgGgkua/Gonv4pzAZz/LU35B3ySlk=')),
          writableIndexesList: const <int>[119, 118, 120, 121],
          readonlyIndexesList: const <int>[6, 122, 117, 83]);

      expect(actualSolanaAddressLookupTable, expectedSolanaAddressLookupTable);
    });

    test('Should [return SolanaAddressLookupTable] from serialized data with zero-length index lists', () {
      // Act
      SolanaAddressLookupTable actualSolanaAddressLookupTable = SolanaAddressLookupTable.fromSerializedData(
          ByteReader(base64Decode('wVdRxcH4wwx5hrqgGgkua/Gonv4pzAZz/LU35B3ySlkAABbx7FnCE40ksuuuv14pM6i4jtdWtEsGPK0+XdwvqvOLA76/uwA=')));

      // Assert
      SolanaAddressLookupTable expectedSolanaAddressLookupTable = SolanaAddressLookupTable(
          accountKey: SolanaPubKey.fromBytes(base64Decode('wVdRxcH4wwx5hrqgGgkua/Gonv4pzAZz/LU35B3ySlk=')),
          writableIndexesList: const <int>[],
          readonlyIndexesList: const <int>[]);

      expect(actualSolanaAddressLookupTable, expectedSolanaAddressLookupTable);
    });
  });
}
