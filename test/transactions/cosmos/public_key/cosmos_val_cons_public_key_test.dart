import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/cosmos/public_key/cosmos_val_cons_public_key.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosValConsPublicKey.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosValConsPublicKey', () {
      // Arrange
      CosmosValConsPublicKey actualCosmosValConsPublicKey = CosmosValConsPublicKey(base64Decode('HlixoxNZBPq4pBOYEimtSq9Ak4peBISVsIbI5ZHrEAU='));

      // Act
      Uint8List actualProtoBytes = actualCosmosValConsPublicKey.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = base64Decode('CiAeWLGjE1kE+rikE5gSKa1Kr0CTil4EhJWwhsjlkesQBQ==');

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosValConsPublicKey.toProtoJson()', () {
    test('Should [return JSON] representing CosmosValConsPublicKey', () {
      // Arrange
      CosmosValConsPublicKey actualCosmosValConsPublicKey = CosmosValConsPublicKey(base64Decode('HlixoxNZBPq4pBOYEimtSq9Ak4peBISVsIbI5ZHrEAU='));

      // Act
      Map<String, dynamic> actualData = actualCosmosValConsPublicKey.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        '@type': '/cosmos.crypto.ed25519.PubKey',
        'key': 'HlixoxNZBPq4pBOYEimtSq9Ak4peBISVsIbI5ZHrEAU=',
      };

      expect(actualData, expectedData);
    });
  });
}
