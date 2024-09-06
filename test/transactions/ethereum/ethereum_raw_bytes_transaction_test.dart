import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EthereumRawBytesTransaction.fromSerializedData() constructor', () {
    test('Should [return EthereumRawBytesTransaction] from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );

      // Act
      EthereumRawBytesTransaction actualEthereumRawBytesTransaction = EthereumRawBytesTransaction.fromSerializedData(actualBytes);

      // Assert
      Uint8List expectedBytes = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );

      expect(actualEthereumRawBytesTransaction.data, expectedBytes);
    });
  });

  group('Tests of EthereumRawBytesTransaction.serialize()', () {
    test('Should [return bytes] representing serialized transaction', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );
      EthereumRawBytesTransaction actualEthereumRawBytesTransaction = EthereumRawBytesTransaction.fromSerializedData(actualBytes);

      // Act
      Uint8List actualSerializedData = actualEthereumRawBytesTransaction.serialize();

      // Assert
      Uint8List expectedSerializedData = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );

      expect(actualSerializedData, expectedSerializedData);
    });
  });

  group('Tests of EthereumRawBytesTransaction.message getter', () {
    test('Should [return message] decoded from ASCII bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );
      EthereumRawBytesTransaction actualEthereumRawBytesTransaction = EthereumRawBytesTransaction.fromSerializedData(actualBytes);

      // Act
      String actualMessage = actualEthereumRawBytesTransaction.message;

      // Assert
      String expectedMessage = 'Welcome to OpenSea!\n'
          '\n'
          'Click to sign in and accept the OpenSea Terms of Service (https://opensea.io/tos) and Privacy Policy (https://opensea.io/privacy).\n'
          '\n'
          'This request will not trigger a blockchain transaction or cost any gas fees.\n'
          '\n'
          'Wallet address:\n'
          '0xd6c63265857c51ee794964d2f98431b02db87ee7\n'
          '\n'
          'Nonce:\n'
          '72976a39-c249-4336-b935-a6dc51e62755';

      expect(actualMessage, expectedMessage);
    });
  });

  group('Tests of EthereumEIP1559Transaction.sign()', () {
    test('Should [return EthereumSignature] representing signed EthereumEIP1559Transaction', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );
      EthereumRawBytesTransaction actualEthereumRawBytesTransaction = EthereumRawBytesTransaction.fromSerializedData(actualBytes);

      // Act
      EthereumSignature actualEthereumSignature = actualEthereumRawBytesTransaction.sign(ECPrivateKey.fromBytes(
        HexCodec.decode('cd23c9f2e2c096ee3be3c4e0e58199800c0036ea27b7cd4e838bbde8b21788b3'),
        CurvePoints.generatorSecp256k1,
      ));

      // Assert
      EthereumSignature expectedEthereumSignature = EthereumSignature(
          s: BigInt.parse('36222244382827590323135961201757911250681705622179828894477285117051514176442'),
          r: BigInt.parse('79811951847007813003344473820027835692028927650397904684881010183343632217467'),
          v: 27,
          eip155Bool: true);

      expect(actualEthereumSignature, expectedEthereumSignature);
    });
  });
}
