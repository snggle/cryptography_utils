import 'dart:convert';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

import '../../transactions/cosmos/test_data/test_msg_send.dart';

void main() {
  CosmosSigner actualCosmosSigner = CosmosSigner(ECPrivateKey.fromBytes(
    base64Decode('OVXyPYAZbAQFwsUfHLEk64sYnyy8OThTIWCC82Iir7U='),
    CurvePoints.generatorSecp256k1,
  ));

  group('Tests of CosmosSigner.signDirect()', () {
    test('Should [return CosmosSignature] representing proof of signing CosmosSignDoc with given private key ', () {
      // Arrange
      CosmosSignDoc actualCosmosSignDoc = CosmosSignDoc(
        chainId: 'testnet-1',
        accountNumber: 4,
        authInfo: CosmosAuthInfo(
          signerInfos: <CosmosSignerInfo>[
            CosmosSignerInfo(
              publicKey: CosmosSimplePublicKey(base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8')),
              modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
              sequence: 27,
            ),
          ],
          fee: CosmosFee(
            gasLimit: BigInt.from(20000),
            amount: <CosmosCoin>[CosmosCoin(denom: 'ukex', amount: BigInt.from(100))],
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
      CosmosSignature actualCosmosSignature = actualCosmosSigner.signDirect(actualCosmosSignDoc);

      // Assert
      CosmosSignature expectedCosmosSignature = CosmosSignature(
        s: BigInt.parse('25762741804310061202983426251141315765040090201449012852222856059029735330091'),
        r: BigInt.parse('38405229888052653976493395571873434429328497679884784055390575135932131163697'),
      );

      expect(actualCosmosSignature, expectedCosmosSignature);
    });
  });
}
