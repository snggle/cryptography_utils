import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  EthereumVerifier ethereumVerifier = EthereumVerifier(ECPublicKey(
    CurvePoints.generatorSecp256k1,
    ECPoint(
      curve: CurvePoints.generatorSecp256k1.curve,
      n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
      x: BigInt.parse('61270922283953566032355063420946347253373158589537574658530686468859493196428'),
      y: BigInt.parse('73721839767093736094675729723437884970830724129602863205276366289853508391084'),
      z: BigInt.parse('101661161206340518770245259490641426187975698948732747361264514092439380819304'),
    ),
  ));

  group('Tests of EthereumVerifier.isSignatureValid()', () {
    test('Should [return TRUE] if [signature VALID] (EIP1559 transaction)', () {
      // Arrange
      Uint8List actualMessage = base64Decode('AvGDqjanAYRZaC8AhFu8hkmCUgiUmRXqJnURVwItUdZ/p1U77jJWNP2HEcN5N+CAAIDA');

      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
        r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
        v: 28,
      );

      // Act
      bool actualSignatureValidBool = ethereumVerifier.isSignatureValid(actualMessage, actualEthereumSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return TRUE] if [signature VALID] (raw message)', () {
      // Arrange
      Uint8List actualMessage = base64Decode(
          'GUV0aGVyZXVtIFNpZ25lZCBNZXNzYWdlOgozMzRXZWxjb21lIHRvIE9wZW5TZWEhCgpDbGljayB0byBzaWduIGluIGFuZCBhY2NlcHQgdGhlIE9wZW5TZWEgVGVybXMgb2YgU2VydmljZSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3RvcykgYW5kIFByaXZhY3kgUG9saWN5IChodHRwczovL29wZW5zZWEuaW8vcHJpdmFjeSkuCgpUaGlzIHJlcXVlc3Qgd2lsbCBub3QgdHJpZ2dlciBhIGJsb2NrY2hhaW4gdHJhbnNhY3Rpb24gb3IgY29zdCBhbnkgZ2FzIGZlZXMuCgpXYWxsZXQgYWRkcmVzczoKMHhkNmM2MzI2NTg1N2M1MWVlNzk0OTY0ZDJmOTg0MzFiMDJkYjg3ZWU3CgpOb25jZToKNzI5NzZhMzktYzI0OS00MzM2LWI5MzUtYTZkYzUxZTYyNzU1');

      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('36222244382827590323135961201757911250681705622179828894477285117051514176442'),
        r: BigInt.parse('79811951847007813003344473820027835692028927650397904684881010183343632217467'),
        v: 27,
      );

      // Act
      bool actualSignatureValidBool = ethereumVerifier.isSignatureValid(actualMessage, actualEthereumSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return FALSE] if [signature INVALID]', () {
      // Arrange
      Uint8List actualMessage = base64Decode('AvGDqjanAYRZaC8AhFu8hkmCUgiUmRXqJnURVwItUdZ/p1U77jJWNP2HEcN5N+CAAIDA');

      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('4856317028341934470222309855748259823621908598480935746971063162847589368710'),
        r: BigInt.parse('59281370219490304620930624578333027491320701558265756386395503687319242295862'),
        v: 27,
      );

      // Act
      bool actualSignatureValidBool = ethereumVerifier.isSignatureValid(actualMessage, actualEthereumSignature);

      // Assert
      expect(actualSignatureValidBool, false);
    });
  });
}
