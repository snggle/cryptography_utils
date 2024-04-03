import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/solana/address_lookup_table.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of AddressLookupTable', () {
    test('Should [construct AddressLookupTable] with correct fields', () {
      // Arrange
      Uint8List expectedAccountKey = Uint8List.fromList(List<int>.generate(32, (int i) => i));
      List<int> expectedWritableIndexes = <int>[1, 2, 3];
      List<int> expectedReadonlyIndexes = <int>[4, 5, 6];

      // Act
      AddressLookupTable actualAddressLookupTable = AddressLookupTable(
        accountKey: expectedAccountKey,
        writableIndexes: expectedWritableIndexes,
        readonlyIndexes: expectedReadonlyIndexes,
      );

      // Assert
      expect(actualAddressLookupTable.accountKey, expectedAccountKey);
      expect(actualAddressLookupTable.writableIndexes, expectedWritableIndexes);
      expect(actualAddressLookupTable.readonlyIndexes, expectedReadonlyIndexes);
    });
  });
}
