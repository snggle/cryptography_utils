import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

import 'test_data/test_msg_send.dart';

void main() {
  group('Tests of CosmosTx.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosTx', () {
      // Arrange
      CosmosTx actualCosmosTx = CosmosTx.signed(
        body: CosmosTxBody(
          messages: <ProtobufAny>[
            TestMsgSend(
              fromAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
              toAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
              amount: <CosmosCoin>[
                CosmosCoin(denom: 'ukex', amount: BigInt.from(12)),
              ],
            ),
          ],
          memo: '123123',
        ),
        authInfo: CosmosAuthInfo(
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
        ),
        signatures: <CosmosSignature>[
          CosmosSignature(
            s: BigInt.parse('25762741804310061202983426251141315765040090201449012852222856059029735330091'),
            r: BigInt.parse('38405229888052653976493395571873434429328497679884784055390575135932131163697'),
          ),
        ],
      );

      // Act
      Uint8List actualProtoBytes = actualCosmosTx.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = base64Decode(
        'CpEBCoYBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEmYKK2tpcmExNDNxOHZ4cHZ1eWt0OXBxNTBlNmhuZzlzMzh2bXk4NDRuOGs5d3gSK2tpcmExNDNxOHZ4cHZ1eWt0OXBxNTBlNmhuZzlzMzh2bXk4NDRuOGs5d3gaCgoEdWtleBICMTISBjEyMzEyMxJnClIKSAofL2Nvc21vcy5jcnlwdG8uc2VjcDI1NmsxLlB1YktleRIlCiMKIQJS2rPAiepZucmSfIdFOULvZ81b4L7JIB7lETwd471MfBIECgIIARgiEhEKCwoEdWtleBIDMTAwEKCcARpAVOiW/TF7pRINaMatMux1KZP3GRiXkAbvXdoQEQr1vjE49THzl1gerUme+MsMjIBoWw9LUiMc6T/NfnLhr1vRKw==',
      );

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosTx.toProtoJson()', () {
    test('Should [return JSON] representing CosmosTx', () {
      // Arrange
      CosmosTx actualCosmosTx = CosmosTx.signed(
        body: CosmosTxBody(
          messages: <ProtobufAny>[
            TestMsgSend(
              fromAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
              toAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
              amount: <CosmosCoin>[
                CosmosCoin(denom: 'ukex', amount: BigInt.from(12)),
              ],
            ),
          ],
          memo: '123123',
        ),
        authInfo: CosmosAuthInfo(
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
        ),
        signatures: <CosmosSignature>[
          CosmosSignature(
            s: BigInt.parse('25762741804310061202983426251141315765040090201449012852222856059029735330091'),
            r: BigInt.parse('38405229888052653976493395571873434429328497679884784055390575135932131163697'),
          ),
        ],
      );

      // Act
      Map<String, dynamic> actualData = actualCosmosTx.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
        'body': <String, Object>{
          'messages': <Map<String, Object>>[
            <String, Object>{
              '@type': '/cosmos.bank.v1beta1.MsgSend',
              'from_address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
              'to_address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
              'amount': <Map<String, String>>[
                <String, String>{'denom': 'ukex', 'amount': '12'}
              ]
            }
          ],
          'memo': '123123',
          'timeout_height': '0',
          'extension_options': <dynamic>[],
          'non_critical_extension_options': <dynamic>[]
        },
        'auth_info': <String, Object>{
          'signer_infos': <Map<String, Object>>[
            <String, Object>{
              'public_key': <String, String>{'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'CiECUtqzwInqWbnJknyHRTlC72fNW+C+ySAe5RE8HeO9THw='},
              'mode_info': <String, Map<String, String>>{
                'single': <String, String>{'mode': 'SIGN_MODE_DIRECT'}
              },
              'sequence': '34'
            }
          ],
          'fee': <String, Object?>{
            'gas_limit': '20000',
            'amount': <Map<String, String>>[
              <String, String>{'denom': 'ukex', 'amount': '100'}
            ],
            'payer': null,
            'granter': null
          }
        },
        'signatures': <String>['VOiW/TF7pRINaMatMux1KZP3GRiXkAbvXdoQEQr1vjE49THzl1gerUme+MsMjIBoWw9LUiMc6T/NfnLhr1vRKw==']
      };

      expect(actualData, expectedData);
    });
  });

  group('Tests of CosmosTx.getTransactionHash()', () {
    test('Should [return hash] representing transaction ID', () {
      // Arrange
      CosmosTx actualCosmosTx = CosmosTx.signed(
        body: CosmosTxBody(
          messages: <ProtobufAny>[
            TestMsgSend(
              fromAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
              toAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
              amount: <CosmosCoin>[
                CosmosCoin(denom: 'ukex', amount: BigInt.from(12)),
              ],
            ),
          ],
          memo: '123123',
        ),
        authInfo: CosmosAuthInfo(
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
        ),
        signatures: <CosmosSignature>[
          CosmosSignature(
            s: BigInt.parse('25762741804310061202983426251141315765040090201449012852222856059029735330091'),
            r: BigInt.parse('38405229888052653976493395571873434429328497679884784055390575135932131163697'),
          ),
        ],
      );

      // Act
      String actualTransactionHash = actualCosmosTx.getTransactionHash();

      // Assert
      String expectedTransactionHash = '0xd7120d2b6059168953c9bad21db6ee3f346ed5787fdec57a8e9b13992359fd8a';

      expect(actualTransactionHash, expectedTransactionHash);
    });
  });
}
