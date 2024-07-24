import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/cosmos/public_key/cosmos_legacy_amino_multisig_public_key.dart';
import 'package:cryptography_utils/src/transactions/cosmos/public_key/cosmos_simple_public_key.dart';
import 'package:test/test.dart';

void main() {
  group('Test of CosmosLegacyAminoMultisigPublicKey.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosLegacyAminoMultisigPublicKey', () {
      // Arrange
      CosmosLegacyAminoMultisigPublicKey actualCosmosLegacyAminoMultisigPublicKey = CosmosLegacyAminoMultisigPublicKey(
        threshold: 1,
        publicKeys: <CosmosSimplePublicKey>[
          CosmosSimplePublicKey(base64Decode('AurroA7jvfPd1AadmmOvWM2rJSwipXfRf8yD6pLbA2DJ')),
        ],
      );

      // Act
      Uint8List actualProtoBytes = actualCosmosLegacyAminoMultisigPublicKey.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = base64Decode('CAESRgofL2Nvc21vcy5jcnlwdG8uc2VjcDI1NmsxLlB1YktleRIjCiEC6uugDuO9893UBp2aY69YzaslLCKld9F/zIPqktsDYMk=');

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosLegacyAminoMultisigPublicKey.toProtoJson()', () {
    test('Should [return JSON] representing CosmosLegacyAminoMultisigPublicKey', () {
      // Arrange
      CosmosLegacyAminoMultisigPublicKey actualCosmosLegacyAminoMultisigPublicKey = CosmosLegacyAminoMultisigPublicKey(
        threshold: 1,
        publicKeys: <CosmosSimplePublicKey>[
          CosmosSimplePublicKey(base64Decode('AurroA7jvfPd1AadmmOvWM2rJSwipXfRf8yD6pLbA2DJ')),
        ],
      );

      // Act
      Map<String, dynamic> actualData = actualCosmosLegacyAminoMultisigPublicKey.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        '@type': '/cosmos.crypto.multisig.LegacyAminoPubKey',
        'threshold': 1,
        'public_keys': <Map<String, String>>[
          <String, String>{
            '@type': '/cosmos.crypto.secp256k1.PubKey',
            'key': 'AurroA7jvfPd1AadmmOvWM2rJSwipXfRf8yD6pLbA2DJ',
          }
        ]
      };

      expect(actualData, expectedData);
    });
  });
}
