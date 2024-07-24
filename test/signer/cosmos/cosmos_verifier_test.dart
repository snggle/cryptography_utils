import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/protobuf/protobuf_any.dart';
import 'package:test/test.dart';

import '../../transactions/cosmos/test_data/test_msg_send.dart';

void main() {
  CosmosVerifier actualCosmosVerifier = CosmosVerifier(ECPublicKey(
    CurvePoints.generatorSecp256k1,
    ECPoint(
      curve: CurvePoints.generatorSecp256k1.curve,
      n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
      x: BigInt.parse('103541830980023606809613093633067363502594290705821036222890728111110906420509'),
      y: BigInt.parse('75808906644622006047938879719654783679105512040910575915102508326553703647166'),
      z: BigInt.parse('3190226348536498292494465017020441737630476122313049345633869118655223224149'),
    ),
  ));

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

  group('Tests of EthereumVerifier.isSignatureValid()', () {
    test('Should [return TRUE] if [signature VALID]', () {
      // Arrange
      CosmosSignature actualCosmosSignature = CosmosSignature(
        s: BigInt.parse('25762741804310061202983426251141315765040090201449012852222856059029735330091'),
        r: BigInt.parse('38405229888052653976493395571873434429328497679884784055390575135932131163697'),
      );

      // Act
      bool actualSignatureValidBool = actualCosmosVerifier.isSignatureValid(actualCosmosSignDoc, actualCosmosSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return FALSE] if [signature INVALID]', () {
      // Arrange
      CosmosSignature actualCosmosSignature = CosmosSignature(
        s: BigInt.parse('6835855700083175663074049776142580319076931796729422201778649332595916663970'),
        r: BigInt.parse('32362148283266006124111739650771005129442507022876757984837887947616516157578'),
      );

      // Act
      bool actualSignatureValidBool = actualCosmosVerifier.isSignatureValid(actualCosmosSignDoc, actualCosmosSignature);

      // Assert
      expect(actualSignatureValidBool, false);
    });
  });
}
