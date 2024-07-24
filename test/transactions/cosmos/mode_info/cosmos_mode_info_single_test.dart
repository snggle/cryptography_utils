import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosModeInfoSingle.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosModeInfoSingle', () {
      // Arrange
      CosmosModeInfoSingle actualCosmosModeInfoSingle = CosmosModeInfoSingle(CosmosSignMode.signModeDirect);

      // Act
      Uint8List actualProtoBytes = actualCosmosModeInfoSingle.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = Uint8List.fromList(<int>[8, 1]);

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosModeInfoSingle.toProtoJson()', () {
    test('Should [return JSON] representing CosmosModeInfoSingle', () {
      // Arrange
      CosmosModeInfoSingle actualCosmosModeInfoSingle = CosmosModeInfoSingle(CosmosSignMode.signModeDirect);

      // Act
      Map<String, dynamic> actualData = actualCosmosModeInfoSingle.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{'mode': 'SIGN_MODE_DIRECT'};

      expect(actualData, expectedData);
    });
  });
}
