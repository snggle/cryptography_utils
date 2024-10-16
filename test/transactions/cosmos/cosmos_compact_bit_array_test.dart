import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosCompactBitArray.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosCompactBitArray', () {
      // Arrange
      CosmosCompactBitArray actualCosmosCompactBitArray = CosmosCompactBitArray(extraBitsStored: 1, elems: base64Decode('AQ=='));

      // Act
      Uint8List actualProtoBytes = actualCosmosCompactBitArray.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = Uint8List.fromList(<int>[8, 1, 18, 1, 1]);

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosCompactBitArray.toData()', () {
    test('Should [return JSON] representing CosmosCompactBitArray', () {
      // Arrange
      CosmosCompactBitArray actualCosmosCompactBitArray = CosmosCompactBitArray(extraBitsStored: 1, elems: base64Decode('AQ=='));

      // Act
      Map<String, dynamic> actualData = actualCosmosCompactBitArray.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        'extra_bits_stored': 1,
        'elems': 'AQ==',
      };

      expect(actualData, expectedData);
    });
  });
}
