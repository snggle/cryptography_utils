import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/rlp/rlp_coder.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of IEthereumTransaction.fromSerializedData()', () {
    test('Should [return EthereumEIP1559Transaction] from given bytes', () {
      // Arrange
      Uint8List actualSerializedData = base64Decode('AvhvAYH6hAX14QCFAU0neb+DAV79lORTw0CfitKx/h7QjhiWNNNZcFpbgLhEqQWcuwAAAAAAAAAAAAAAAJkV6iZ1EVcCLVHWf6dVO+4yVjT9AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACf30L25IAADA');

      // Act
      AEthereumTransaction actualEthereumTransaction = AEthereumTransaction.fromSerializedData(actualSerializedData);

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

      List<int> abi = <int>[169, 5, 156, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 153, 21, 234, 38, 117, 17, 87, 2, 45, 81, 214, 127, 167, 85, 59, 238, 50, 86, 52, 253, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 253, 244, 47, 110, 72, 0, 0];
      print('0x${HexEncoder.encode(abi)}');

    });
  });
}
