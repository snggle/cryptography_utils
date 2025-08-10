// test/solana_address_lookup_table_test.dart
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_address_lookup_table.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_pubkey.dart';
import 'package:test/test.dart';

void main() {
  group('SolanaAddressLookupTable.fromSerializedData()', () {
    test('Should [return SolanaAddressLookupTable] from serialized data', () {
      // Arrange
      List<int> actualPubkeyBytes = List<int>.generate(32, (int i) => i);
      List<int> actualRawData = <int>[...actualPubkeyBytes, 2, 5, 7, 3, 9, 10, 11];
      ByteReader actualByteReader = ByteReader(Uint8List.fromList(actualRawData));

      // Act
      SolanaAddressLookupTable actualSolanaAddressLookupTable = SolanaAddressLookupTable.fromSerializedData(actualByteReader);

      // Assert
      SolanaPubKey expectedAccountKey = SolanaPubKey.fromBytes(Uint8List.fromList(actualPubkeyBytes));
      SolanaAddressLookupTable expectedSolanaAddressLookupTable = SolanaAddressLookupTable(
          accountKey: expectedAccountKey, writableIndexesList: const <int>[5, 7], readonlyIndexesList: const <int>[9, 10, 11]);

      expect(actualSolanaAddressLookupTable, expectedSolanaAddressLookupTable);
    });

    test('Should [return SolanaAddressLookupTable] with zero-length index lists', () {
      // Arrange
      List<int> actualPubkeyBytes = List<int>.filled(32, 7);
      List<int> actualRawData = <int>[...actualPubkeyBytes, 0, 0];
      ByteReader actualByteReader = ByteReader(Uint8List.fromList(actualRawData));

      // Act
      SolanaAddressLookupTable actualSolanaAddressLookupTable = SolanaAddressLookupTable.fromSerializedData(actualByteReader);

      // Assert
      SolanaPubKey expectedAccountKey = SolanaPubKey.fromBytes(Uint8List.fromList(actualPubkeyBytes));
      SolanaAddressLookupTable expectedSolanaAddressLookupTable = SolanaAddressLookupTable(
        accountKey: expectedAccountKey,
        writableIndexesList: const <int>[],
        readonlyIndexesList: const <int>[],
      );

      expect(actualSolanaAddressLookupTable, expectedSolanaAddressLookupTable);
    });

    test('Should [throw RangeError] if there is incomplete data', () {
      // Arrange
      List<int> actualPubkeyBytes = List<int>.generate(32, (int i) => i + 10);
      List<int> actualRawData = <int>[...actualPubkeyBytes, 2, 5, 1];
      ByteReader actualByteReader = ByteReader(Uint8List.fromList(actualRawData));

      // Assert
      expect(
        () => SolanaAddressLookupTable.fromSerializedData(actualByteReader),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
