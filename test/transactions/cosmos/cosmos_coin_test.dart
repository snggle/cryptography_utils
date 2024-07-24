import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/cosmos/cosmos_coin.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosCoin.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosCoin', () {
      // Arrange
      CosmosCoin actualCosmosCoin = CosmosCoin(denom: 'ukex', amount: BigInt.parse('100'));

      // Act
      Uint8List actualProtoBytes = actualCosmosCoin.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = Uint8List.fromList(<int>[10, 4, 117, 107, 101, 120, 18, 3, 49, 48, 48]);

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosCoin.toData()', () {
    test('Should [return JSON] representing CosmosCoin', () {
      // Arrange
      CosmosCoin actualCosmosCoin = CosmosCoin(denom: 'ukex', amount: BigInt.parse('100'));

      // Act
      Map<String, dynamic> actualData = actualCosmosCoin.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        'denom': 'ukex',
        'amount': '100',
      };

      expect(actualData, expectedData);
    });
  });
}
