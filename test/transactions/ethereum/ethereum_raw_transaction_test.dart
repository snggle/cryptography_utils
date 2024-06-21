import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/ethereum/ethereum_raw_transaction.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EthereumRawTransaction.fromSerializedData() constructor', () {
    test('Should [return EthereumRawTransaction] from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );

      // Act
      EthereumRawTransaction actualEthereumRawTransaction = EthereumRawTransaction.fromSerializedData(actualBytes);

      // Assert
      Uint8List expectedBytes = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );

      expect(actualEthereumRawTransaction.data, expectedBytes);
    });
  });

  group('Tests of EthereumRawTransaction.serialize()', () {
    test('Should [return bytes] representing serialized transaction', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );
      EthereumRawTransaction actualEthereumRawTransaction = EthereumRawTransaction.fromSerializedData(actualBytes);

      // Act
      Uint8List actualSerializedData = actualEthereumRawTransaction.serialize();

      // Assert
      Uint8List expectedSerializedData = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );

      expect(actualSerializedData, expectedSerializedData);
    });
  });

  group('Tests of EthereumRawTransaction.message getter', () {
    test('Should [return message] if bytes are ASCII encoded String', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );
      EthereumRawTransaction actualEthereumRawTransaction = EthereumRawTransaction.fromSerializedData(actualBytes);

      // Act
      String actualMessage = actualEthereumRawTransaction.message;

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

    test('Should [return hex] if bytes are NOT ASCII encoded String', () {
      // Arrange
      Uint8List actualBytes = base64Decode('///wgIE=');
      EthereumRawTransaction actualEthereumRawTransaction = EthereumRawTransaction.fromSerializedData(actualBytes);

      // Act
      String actualMessage = actualEthereumRawTransaction.message;

      // Assert
      String expectedMessage = '0xfffff08081';

      expect(actualMessage, expectedMessage);
    });
  });
}
