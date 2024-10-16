import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of CosmosModeInfo.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosModeInfo with CosmosModeInfoMulti', () {
      // Arrange
      CosmosModeInfo actualCosmosModeInfo = CosmosModeInfo.multi(
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
      Uint8List actualProtoBytes = actualCosmosModeInfo.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = Uint8List.fromList(<int>[18, 19, 10, 5, 8, 1, 18, 1, 1, 18, 4, 10, 2, 8, 1, 18, 4, 10, 2, 8, 1]);

      expect(actualProtoBytes, expectedProtoBytes);
    });

    test('Should [return protobuf bytes] representing CosmosModeInfo with CosmosModeInfoSingle', () {
      // Arrange
      CosmosModeInfo actualCosmosModeInfo = CosmosModeInfo.single(CosmosSignMode.signModeDirect);

      // Act
      Uint8List actualProtoBytes = actualCosmosModeInfo.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = Uint8List.fromList(<int>[10, 2, 8, 1]);

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosModeInfo.toProtoJson()', () {
    test('Should [return JSON] representing CosmosModeInfo with CosmosModeInfoMulti', () {
      // Arrange
      CosmosModeInfo actualCosmosModeInfo = CosmosModeInfo.multi(
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
      Map<String, dynamic> actualData = actualCosmosModeInfo.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        'multi': <String, Object>{
          'bitarray': <String, Object>{'extra_bits_stored': 1, 'elems': 'AQ=='},
          'mode_infos': <Map<String, Map<String, String>>>[
            <String, Map<String, String>>{
              'single': <String, String>{'mode': 'SIGN_MODE_DIRECT'}
            },
            <String, Map<String, String>>{
              'single': <String, String>{'mode': 'SIGN_MODE_DIRECT'}
            }
          ]
        }
      };

      expect(actualData, expectedData);
    });

    test('Should [return JSON] representing CosmosModeInfo with CosmosModeInfoSingle', () {
      // Arrange
      CosmosModeInfo actualCosmosModeInfo = CosmosModeInfo.single(CosmosSignMode.signModeDirect);

      // Act
      Map<String, dynamic> actualData = actualCosmosModeInfo.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        'single': <String, String>{'mode': 'SIGN_MODE_DIRECT'}
      };

      expect(actualData, expectedData);
    });
  });
}
