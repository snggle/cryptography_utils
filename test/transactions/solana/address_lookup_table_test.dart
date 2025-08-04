import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/solana/address_lookup_table.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of AddressLookupTable constructor', () {
    test('Should [return AddressLookupTable]', () {
      // Act
      AddressLookupTable actualAddressLookupTable = AddressLookupTable(
        accountKey: Uint8List.fromList(List<int>.generate(32, (int i) => i)),
        writableIndexesList: <int>[1, 2, 3],
        readonlyIndexesList: <int>[4, 5, 6],
      );

      // Assert
      Uint8List expectedAccountKey = Uint8List.fromList(List<int>.generate(32, (int i) => i));
      List<int> expectedWritableIndexes = <int>[1, 2, 3];
      List<int> expectedReadonlyIndexes = <int>[4, 5, 6];

      expect(actualAddressLookupTable.accountKey, expectedAccountKey);
      expect(actualAddressLookupTable.writableIndexesList, expectedWritableIndexes);
      expect(actualAddressLookupTable.readonlyIndexesList, expectedReadonlyIndexes);
    });
  });
}
