import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/ethereum/ethereum_eip1559_transaction.dart';
import 'package:cryptography_utils/src/transactions/ethereum/ethereum_raw_transaction.dart';
import 'package:cryptography_utils/src/transactions/token_amount.dart';
import 'package:cryptography_utils/src/transactions/token_denomination_type.dart';
import 'package:cryptography_utils/src/transactions/transaction_type.dart';
import 'package:equatable/equatable.dart';

abstract class AEthereumTransaction extends Equatable {
  const AEthereumTransaction();

  static AEthereumTransaction fromSerializedData(TransactionType ethereumTransactionType, Uint8List data) {
    if( ethereumTransactionType == TransactionType.text ) {
      return EthereumRawTransaction.fromSerializedData(data);
    }

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

  Uint8List serialize();

  TokenAmount? getAmount(TokenDenominationType tokenDenominationType) => null;

  TokenAmount? getFee(TokenDenominationType tokenDenominationType) => null;

  String? get message => null;

  String? get recipientAddress => null;

  String? get contractAddress => null;
}
