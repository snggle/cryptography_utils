import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_any.dart';
import 'package:test/test.dart';

import 'test_data/test_msg_send.dart';

void main() {
  group('Tests of CosmosSignDoc.toProtoBytes()', () {
    test('Should [return protobuf bytes] representing CosmosSignDoc', () {
      // Arrange
      CosmosSignDoc actualCosmosSignDoc = CosmosSignDoc(
        chainId: 'testnet-1',
        accountNumber: 4,
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
        txBody: CosmosTxBody(
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
      );

      // Act
      Uint8List actualProtoBytes = actualCosmosSignDoc.toProtoBytes();

      // Assert
      Uint8List expectedProtoBytes = base64Decode(
        'CpEBCoYBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEmYKK2tpcmExNDNxOHZ4cHZ1eWt0OXBxNTBlNmhuZzlzMzh2bXk4NDRuOGs5d3gSK2tpcmExNDNxOHZ4cHZ1eWt0OXBxNTBlNmhuZzlzMzh2bXk4NDRuOGs5d3gaCgoEdWtleBICMTISBjEyMzEyMxJnClIKSAofL2Nvc21vcy5jcnlwdG8uc2VjcDI1NmsxLlB1YktleRIlCiMKIQJS2rPAiepZucmSfIdFOULvZ81b4L7JIB7lETwd471MfBIECgIIARgiEhEKCwoEdWtleBIDMTAwEKCcARoJdGVzdG5ldC0xIAQ=',
      );
      expect(actualProtoBytes, expectedProtoBytes);
    });
  });

  group('Tests of CosmosSignDoc.getDirectSignBytes()', () {
    test('Should [return protobuf bytes] representing CosmosSignDoc', () {
      // Arrange
      CosmosSignDoc actualCosmosSignDoc = CosmosSignDoc(
        txBody: CosmosTxBody(
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
        chainId: 'testnet-1',
        accountNumber: 4,
      );

      // Act
      Uint8List actualDirectSignBytes = actualCosmosSignDoc.getDirectSignBytes();

      // Assert
      Uint8List expectedDirectSignBytes = base64Decode(
        'CpEBCoYBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEmYKK2tpcmExNDNxOHZ4cHZ1eWt0OXBxNTBlNmhuZzlzMzh2bXk4NDRuOGs5d3gSK2tpcmExNDNxOHZ4cHZ1eWt0OXBxNTBlNmhuZzlzMzh2bXk4NDRuOGs5d3gaCgoEdWtleBICMTISBjEyMzEyMxJnClIKSAofL2Nvc21vcy5jcnlwdG8uc2VjcDI1NmsxLlB1YktleRIlCiMKIQJS2rPAiepZucmSfIdFOULvZ81b4L7JIB7lETwd471MfBIECgIIARgiEhEKCwoEdWtleBIDMTAwEKCcARoJdGVzdG5ldC0xIAQ=',
      );
      expect(actualDirectSignBytes, expectedDirectSignBytes);
    });
  });
}
