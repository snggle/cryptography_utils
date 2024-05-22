// Class was shaped by the influence of JavaScript key sources including:
// https://github.com/ethereumjs/ethereumjs-monorepo/tree/master/packages/tx
//
// Mozilla Public License Version 2.0
import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/generic_encoder/rlp/rlp_coder.dart';
import 'package:cryptography_utils/src/signer/ethereum/ethereum_signature.dart';
import 'package:cryptography_utils/src/transactions/ethereum/access_list_bytes_item.dart';
import 'package:cryptography_utils/src/transactions/ethereum/i_ethereum_transaction.dart';
import 'package:equatable/equatable.dart';

/// Represents an Ethereum transaction adhering to the EIP-1559 standard.
class EthereumEIP1559Transaction extends Equatable implements IEthereumTransaction {
  /// Type identifier for EIP-1559 transactions.
  static const int txType = 2;

  /// The unique identifier of the Ethereum network (chain) on which the transaction is intended.
  /// Each Ethereum network (like mainnet, ropsten, etc.) has a specific chain ID.
  final BigInt chainId;

  /// The nonce represents the number of transactions previously sent from the sender's address.
  /// It is used to order transactions from the same address and prevent replay of the same transaction.
  final BigInt nonce;

  /// The maximum amount of wei (smallest unit of ether) the sender is willing to pay per unit of gas.
  final BigInt maxPriorityFeePerGas;

  /// The maximum total amount of wei the sender is willing to pay per unit of gas. This value must be
  /// equal to or greater than the sum of the base fee and maxPriorityFeePerGas.
  final BigInt maxFeePerGas;

  /// The limit on the amount of gas that can be used by this transaction.
  final BigInt gasLimit;

  /// The Ethereum address of the recipient. This can be a contract address or an externally owned account (EOA).
  final String to;

  /// The amount of ether (in wei) to be transferred from the sender to the recipient.
  final BigInt value;

  /// Encoded call data sent with the transaction. This can include function signatures and arguments
  /// for contract interactions.
  final Uint8List data;

  /// An access list specifying storage keys and addresses that the transaction intends to access.
  final List<AccessListBytesItem> accessList;

  /// An optional digital signature of the transaction, which is used to authenticate the sender of the transaction.
  /// This field is null when the transaction is unsigned.
  final EthereumSignature? signature;

  /// Creates a new instance of [EthereumEIP1559Transaction] with the specified parameters.
  const EthereumEIP1559Transaction({
    required this.chainId,
    required this.nonce,
    required this.maxPriorityFeePerGas,
    required this.maxFeePerGas,
    required this.gasLimit,
    required this.to,
    required this.value,
    required this.data,
    required this.accessList,
    this.signature,
  });

  /// Decodes the serialized data into an instance of [EthereumEIP1559Transaction].
  factory EthereumEIP1559Transaction.fromSerializedData(Uint8List data) {
    int actualTxType = data[0];
    if (actualTxType != txType) {
      throw ArgumentError('Invalid transaction type: $actualTxType. Expected EIP-1559 transaction (${txType}) got $actualTxType.');
    }

    Uint8List serializedEIP1559Transaction = data.sublist(1);
    IRLPElement rlpElement = RLPCoder.decode(serializedEIP1559Transaction);

    return EthereumEIP1559Transaction._fromRLP(rlpElement as RLPList);
  }

  /// Decodes the RLP-encoded data into an instance of [EthereumEIP1559Transaction].
  factory EthereumEIP1559Transaction._fromRLP(RLPList rlpList) {
    if (rlpList.length != 9 && rlpList.length != 12) {
      throw ArgumentError('Invalid EIP-1559 transaction: Only expecting 9 values (for unsigned tx) or 12 values (for signed tx)');
    }

    EthereumSignature? signature;
    if (rlpList.length == 12) {
      signature = EthereumSignature(
        v: rlpList.getBigInt(9).toInt(),
        r: rlpList.getBigInt(10),
        s: rlpList.getBigInt(11),
      );
    }

    return EthereumEIP1559Transaction(
      chainId: rlpList.getBigInt(0),
      nonce: rlpList.getBigInt(1),
      maxPriorityFeePerGas: rlpList.getBigInt(2),
      maxFeePerGas: rlpList.getBigInt(3),
      gasLimit: rlpList.getBigInt(4),
      to: rlpList.getHex(5),
      value: rlpList.getBigInt(6),
      data: rlpList.getUint8List(7),
      accessList: rlpList.getRLPList(8).data.map((IRLPElement element) => AccessListBytesItem.fromRLP(element as RLPList)).toList(),
      signature: signature,
    );
  }

  /// Serializes the transaction into a byte array.
  @override
  Uint8List serialize() {
    IRLPElement rlpElement = _toRLP();
    Uint8List serializedData = RLPCoder.encode(rlpElement);
    return Uint8List.fromList(<int>[txType, ...serializedData]);
  }

  /// Encodes the transaction into an RLP-encoded data.
  IRLPElement _toRLP() {
    List<IRLPElement> values = <IRLPElement>[
      RLPBytes.fromBigInt(chainId),
      RLPBytes.fromBigInt(nonce),
      RLPBytes.fromBigInt(maxPriorityFeePerGas),
      RLPBytes.fromBigInt(maxFeePerGas),
      RLPBytes.fromBigInt(gasLimit),
      RLPBytes.fromHex(to),
      RLPBytes.fromBigInt(value),
      RLPBytes(data),
      RLPList(accessList.map((AccessListBytesItem e) => e.toRLP()).toList()),
    ];

    if (signature != null) {
      values.addAll(<IRLPElement>[
        RLPBytes.fromBigInt(BigInt.from(signature!.getV(eip155Bool: true))),
        RLPBytes(signature!.rBytes),
        RLPBytes(signature!.sBytes),
      ]);
    }

    return RLPList(values);
  }

  @override
  List<Object?> get props => <Object?>[chainId, nonce, maxPriorityFeePerGas, maxFeePerGas, gasLimit, to, value, data, accessList, signature];
}
