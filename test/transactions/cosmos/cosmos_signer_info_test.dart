import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosSignerInfo.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosSignerInfo', () {
      // Arrange
      CosmosSignerInfo actualCosmosSignerInfo = CosmosSignerInfo(
        publicKey: CosmosSimplePublicKey(base64Decode('CiECUtqzwInqWbnJknyHRTlC72fNW+C+ySAe5RE8HeO9THw=')),
        modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
        sequence: 34,
      );

      // Act
      Uint8List actualProtoBytes = actualCosmosSignerInfo.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = base64Decode(
        'CkgKHy9jb3Ntb3MuY3J5cHRvLnNlY3AyNTZrMS5QdWJLZXkSJQojCiECUtqzwInqWbnJknyHRTlC72fNW+C+ySAe5RE8HeO9THwSBAoCCAEYIg==',
      );

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosSignerInfo.toProtoJson()', () {
    test('Should [return JSON] representing CosmosSignerInfo', () {
      // Arrange
      CosmosSignerInfo actualCosmosSignerInfo = CosmosSignerInfo(
        publicKey: CosmosSimplePublicKey(base64Decode('CiECUtqzwInqWbnJknyHRTlC72fNW+C+ySAe5RE8HeO9THw=')),
        modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
        sequence: 34,
      );

      // Act
      Map<String, dynamic> actualData = actualCosmosSignerInfo.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        'public_key': <String, String>{
          '@type': '/cosmos.crypto.secp256k1.PubKey',
          'key': 'CiECUtqzwInqWbnJknyHRTlC72fNW+C+ySAe5RE8HeO9THw=',
        },
        'mode_info': <String, Map<String, String>>{
          'single': <String, String>{'mode': 'SIGN_MODE_DIRECT'}
        },
        'sequence': '34'
      };

      expect(actualData, expectedData);
    });
  });
}
