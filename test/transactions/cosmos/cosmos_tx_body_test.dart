import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

import 'test_data/test_msg_send.dart';

void main() {
  group('Tests of CosmosTxBody.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosTxBody', () {
      // Arrange
      CosmosTxBody actualCosmosTxBody = CosmosTxBody(
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
      );

      // Act
      Uint8List actualProtoBytes = actualCosmosTxBody.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = base64Decode(
        'CoYBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEmYKK2tpcmExNDNxOHZ4cHZ1eWt0OXBxNTBlNmhuZzlzMzh2bXk4NDRuOGs5d3gSK2tpcmExNDNxOHZ4cHZ1eWt0OXBxNTBlNmhuZzlzMzh2bXk4NDRuOGs5d3gaCgoEdWtleBICMTISBjEyMzEyMw==',
      );

      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosTxBody.toProtoJson()', () {
    test('Should [return JSON] representing CosmosTxBody', () {
      // Arrange
      CosmosTxBody actualCosmosTxBody = CosmosTxBody(
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
      );

      // Act
      Map<String, dynamic> actualData = actualCosmosTxBody.toProtoJson();

      // Assert
      Map<String, dynamic> expectedData = <String, dynamic>{
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
      };

      expect(actualData, expectedData);
    });
  });
}
