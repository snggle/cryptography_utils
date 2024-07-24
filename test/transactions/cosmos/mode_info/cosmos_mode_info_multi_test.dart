import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosModeInfoMulti.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosModeInfoMulti', () {
      // Arrange
      CosmosModeInfoMulti actualCosmosModeInfoMulti = CosmosModeInfoMulti(
        bitArray: CosmosCompactBitArray(
          extraBitsStored: 1,
          elems: base64Decode('AQ=='),
        ),
        modeInfos: <CosmosModeInfo>[
          CosmosModeInfo.single(CosmosSignMode.signModeDirect),
          CosmosModeInfo.single(CosmosSignMode.signModeDirect),
        ],
      );

      // Act
      Uint8List actualProtoBytes = actualCosmosModeInfoMulti.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = Uint8List.fromList(<int>[10, 5, 8, 1, 18, 1, 1, 18, 4, 10, 2, 8, 1, 18, 4, 10, 2, 8, 1]);

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosModeInfoMulti.toProtoJson()', () {
    test('Should [return JSON] representing CosmosModeInfoMulti', () {
      // Arrange
      CosmosModeInfoMulti actualCosmosModeInfoMulti = CosmosModeInfoMulti(
        bitArray: CosmosCompactBitArray(
          extraBitsStored: 1,
          elems: base64Decode('AQ=='),
        ),
        modeInfos: <CosmosModeInfo>[
          CosmosModeInfo.single(CosmosSignMode.signModeDirect),
          CosmosModeInfo.single(CosmosSignMode.signModeDirect),
        ],
      );

      // Act
      Map<String, dynamic> actualData = actualCosmosModeInfoMulti.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        'bitarray': <String, Object>{'extra_bits_stored': 1, 'elems': 'AQ=='},
        'mode_infos': <Map<String, Map<String, String>>>[
          <String, Map<String, String>>{
            'single': <String, String>{'mode': 'SIGN_MODE_DIRECT'}
          },
          <String, Map<String, String>>{
            'single': <String, String>{'mode': 'SIGN_MODE_DIRECT'}
          }
        ]
      };

      expect(actualData, expectedData);
    });
  });
}
