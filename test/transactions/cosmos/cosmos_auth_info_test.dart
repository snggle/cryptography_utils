import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosAuthInfo.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosAuthInfo', () {
      // Arrange
      CosmosAuthInfo actualCosmosAuthInfo = CosmosAuthInfo(
        signerInfos: <CosmosSignerInfo>[
          CosmosSignerInfo(
            publicKey: CosmosSimplePublicKey(base64Decode('CiECUtqzwInqWbnJknyHRTlC72fNW+C+ySAe5RE8HeO9THw=')),
            modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
            sequence: 34,
          ),
        ],
        fee: CosmosFee(
          gasLimit: BigInt.parse('20000'),
          amount: <CosmosCoin>[CosmosCoin(denom: 'ukex', amount: BigInt.parse('100'))],
        ),
      );

      // Act
      Uint8List actualProtoBytes = actualCosmosAuthInfo.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = base64Decode(
        'ClIKSAofL2Nvc21vcy5jcnlwdG8uc2VjcDI1NmsxLlB1YktleRIlCiMKIQJS2rPAiepZucmSfIdFOULvZ81b4L7JIB7lETwd471MfBIECgIIARgiEhEKCwoEdWtleBIDMTAwEKCcAQ==',
      );

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosAuthInfo.toProtoJson()', () {
    test('Should [return JSON] representing CosmosAuthInfo', () {
      // Arrange
      CosmosAuthInfo actualCosmosAuthInfo = CosmosAuthInfo(
        signerInfos: <CosmosSignerInfo>[
          CosmosSignerInfo(
            publicKey: CosmosSimplePublicKey(base64Decode('CiECUtqzwInqWbnJknyHRTlC72fNW+C+ySAe5RE8HeO9THw=')),
            modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
            sequence: 34,
          ),
        ],
        fee: CosmosFee(
          gasLimit: BigInt.parse('20000'),
          amount: <CosmosCoin>[CosmosCoin(denom: 'ukex', amount: BigInt.parse('100'))],
        ),
      );

      // Act
      Map<String, dynamic> actualData = actualCosmosAuthInfo.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        'signer_infos': <Map<String, Object>>[
          <String, Object>{
            'public_key': <String, String>{
              '@type': '/cosmos.crypto.secp256k1.PubKey',
              'key': 'CiECUtqzwInqWbnJknyHRTlC72fNW+C+ySAe5RE8HeO9THw=',
            },
            'mode_info': <String, Map<String, String>>{
              'single': <String, String>{'mode': 'SIGN_MODE_DIRECT'}
            },
            'sequence': '34',
          }
        ],
        'fee': <String, Object?>{
          'gas_limit': '20000',
          'amount': <Map<String, String>>[
            <String, String>{'denom': 'ukex', 'amount': '100'}
          ],
          'payer': null,
          'granter': null,
        }
      };

      expect(actualData, expectedData);
    });
  });
}
