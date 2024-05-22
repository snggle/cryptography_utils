import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EthereumSigner.signPersonalMessage()', () {
    test('Should [return EthereumSignature] representing proof of signing message with given private key (raw message)', () {
      // Arrange
      Uint8List actualMessage = base64Decode(
          'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==');

      EthereumSigner actualEthereumSigner = EthereumSigner(ECPrivateKey.fromBytes(
        HexEncoder.decode('cd23c9f2e2c096ee3be3c4e0e58199800c0036ea27b7cd4e838bbde8b21788b3'),
        CurvePoints.generatorSecp256k1,
      ));

      // Act
      EthereumSignature actualEthereumSignature = actualEthereumSigner.signPersonalMessage(actualMessage);

      // Assert
      EthereumSignature expectedEthereumSignature = EthereumSignature(
        s: BigInt.parse('36222244382827590323135961201757911250681705622179828894477285117051514176442'),
        r: BigInt.parse('79811951847007813003344473820027835692028927650397904684881010183343632217467'),
        v: 27,
      );

      expect(actualEthereumSignature, expectedEthereumSignature);
    });
  });

  group('Tests of EthereumSigner.sign()', () {
    test('Should [return EthereumSignature] representing proof of signing message with given private key (EIP1559 transaction)', () {
      // Arrange
      Uint8List actualMessage = base64Decode('AvGDqjanAYRZaC8AhFu8hkmCUgiUmRXqJnURVwItUdZ/p1U77jJWNP2HEcN5N+CAAIDA');

      EthereumSigner actualEthereumSigner = EthereumSigner(ECPrivateKey.fromBytes(
        HexEncoder.decode('cd23c9f2e2c096ee3be3c4e0e58199800c0036ea27b7cd4e838bbde8b21788b3'),
        CurvePoints.generatorSecp256k1,
      ));

      // Act
      EthereumSignature actualEthereumSignature = actualEthereumSigner.sign(actualMessage);

      // Assert
      EthereumSignature expectedEthereumSignature = EthereumSignature(
        s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
        r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
        v: 28,
      );

      expect(actualEthereumSignature, expectedEthereumSignature);
    });
  });
}
