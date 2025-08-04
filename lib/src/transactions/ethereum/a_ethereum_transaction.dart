import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_function.dart';
import 'package:equatable/equatable.dart';

/// Generic abstract class defining Ethereum transaction
abstract class AEthereumTransaction extends Equatable {
  const AEthereumTransaction();

  /// Creates a new instance of [AEthereumTransaction] from the serialized data.
  static AEthereumTransaction fromSerializedData(EthereumSignDataType signDataType, Uint8List data) {
    if (signDataType == EthereumSignDataType.rawBytes) {
      return EthereumRawBytesTransaction.fromSerializedData(data);
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

  /// Returns decoded ABI function from the transaction data.
  AbiFunction? get abiFunction => null;

  /// Returns address of the contract to which the transaction is directed.
  String? get contractAddress => null;

  /// Returns the amount of token used.
  TokenAmount? getAmount(TokenDenominationType tokenDenominationType) => null;

  /// Returns the fee for the transaction.
  TokenAmount? getFee(TokenDenominationType tokenDenominationType) => null;

  /// Returns the raw message to sign
  String? get message => null;

  /// Returns the recipient address of the transaction.
  String? get recipientAddress => null;

  /// Serializes the transaction into a byte array.
  Uint8List serialize();

  /// Returns the signature of the signed transaction.
  EthereumSignature sign(ECPrivateKey ecPrivateKey);
}
