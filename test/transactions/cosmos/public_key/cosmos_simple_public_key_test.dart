import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/cosmos/public_key/cosmos_simple_public_key.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosSimplePublicKey.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosSimplePublicKey', () {
      // Arrange
      CosmosSimplePublicKey actualCosmosSimplePublicKey = CosmosSimplePublicKey(base64Decode('AurroA7jvfPd1AadmmOvWM2rJSwipXfRf8yD6pLbA2DJ'));

      // Act
      Uint8List actualProtoBytes = actualCosmosSimplePublicKey.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = base64Decode('CiEC6uugDuO9893UBp2aY69YzaslLCKld9F/zIPqktsDYMk=');

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosSimplePublicKey.toProtoJson()', () {
    test('Should [return JSON] representing CosmosSimplePublicKey', () {
      // Arrange
      CosmosSimplePublicKey actualCosmosSimplePublicKey = CosmosSimplePublicKey(base64Decode('AurroA7jvfPd1AadmmOvWM2rJSwipXfRf8yD6pLbA2DJ'));

      // Act
      Map<String, dynamic> actualData = actualCosmosSimplePublicKey.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        '@type': '/cosmos.crypto.secp256k1.PubKey',
        'key': 'AurroA7jvfPd1AadmmOvWM2rJSwipXfRf8yD6pLbA2DJ',
      };

      expect(actualData, expectedData);
    });
  });
}
