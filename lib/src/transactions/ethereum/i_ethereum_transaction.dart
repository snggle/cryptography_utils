import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/ethereum/ethereum_eip1559_transaction.dart';

abstract interface class IEthereumTransaction {
  Uint8List serialize();

  static IEthereumTransaction fromSerializedData(Uint8List data) {
    int txType = data[0];
    if (txType <= 0x7f) {
      switch (txType) {
        case EthereumEIP1559Transaction.txType:
          return EthereumEIP1559Transaction.fromSerializedData(data);
        default:
          throw UnimplementedError('Transaction type $txType is not supported yet.');
      }
    } else {
      throw UnimplementedError('Legacy transactions are not supported yet.');
    }
  }
}
