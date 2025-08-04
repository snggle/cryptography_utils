import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of AEthereumTransaction.fromSerializedData()', () {
    test('Should [return EthereumEIP1559Transaction] from given bytes', () {
      // Arrange
      Uint8List actualSerializedData = base64Decode(
        'AvhvAYH6hAX14QCFAU0neb+DAV79lORTw0CfitKx/h7QjhiWNNNZcFpbgLhEqQWcuwAAAAAAAAAAAAAAAJkV6iZ1EVcCLVHWf6dVO+4yVjT9AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACf30L25IAADA',
      );

      // Act
      AEthereumTransaction actualEthereumTransaction = AEthereumTransaction.fromSerializedData(EthereumSignDataType.typedTransaction, actualSerializedData);

      // Assert
      EthereumEIP1559Transaction expectedEthereumTransaction = EthereumEIP1559Transaction(
        chainId: BigInt.parse('1'),
        nonce: BigInt.parse('250'),
        maxPriorityFeePerGas: BigInt.parse('100000000'),
        maxFeePerGas: BigInt.parse('5589399999'),
        gasLimit: BigInt.parse('89853'),
        to: '0xe453c3409f8ad2b1fe1ed08e189634d359705a5b',
        value: BigInt.parse('0'),
        data: base64Decode('qQWcuwAAAAAAAAAAAAAAAJkV6iZ1EVcCLVHWf6dVO+4yVjT9AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACf30L25IAAA='),
        accessList: const <AccessListBytesItem>[],
        signature: null,
      );

      expect(actualEthereumTransaction, expectedEthereumTransaction);
    });

    test('Should [return EthereumRawBytesTransaction] from given bytes', () {
      // Arrange
      Uint8List actualSerializedData = base64Decode(
        'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
      );

      // Act
      AEthereumTransaction actualEthereumTransaction = AEthereumTransaction.fromSerializedData(EthereumSignDataType.rawBytes, actualSerializedData);

      // Assert
      EthereumRawBytesTransaction expectedEthereumTransaction = EthereumRawBytesTransaction.fromSerializedData(
        base64Decode(
          'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ==',
        ),
      );

      expect(actualEthereumTransaction, expectedEthereumTransaction);
    });
  });
}
