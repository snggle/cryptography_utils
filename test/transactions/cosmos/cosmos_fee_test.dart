import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosFee.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosFee', () {
      // Arrange
      CosmosFee actualCosmosFee = CosmosFee(
        gasLimit: BigInt.parse('20000'),
        amount: <CosmosCoin>[CosmosCoin(denom: 'ukex', amount: BigInt.parse('100'))],
      );

      // Act
      Uint8List actualProtoBytes = actualCosmosFee.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = Uint8List.fromList(<int>[10, 11, 10, 4, 117, 107, 101, 120, 18, 3, 49, 48, 48, 16, 160, 156, 1]);

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosFee.toProtoJson()', () {
    test('Should [return JSON] representing CosmosFee', () {
      // Arrange
      CosmosFee actualCosmosFee = CosmosFee(
        gasLimit: BigInt.parse('20000'),
        amount: <CosmosCoin>[CosmosCoin(denom: 'ukex', amount: BigInt.parse('100'))],
      );

      // Act
      Map<String, dynamic> actualData = actualCosmosFee.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        'gas_limit': '20000',
        'amount': <Map<String, String>>[
          <String, String>{'denom': 'ukex', 'amount': '100'}
        ],
        'payer': null,
        'granter': null
      };

      expect(actualData, expectedData);
    });
  });
}
