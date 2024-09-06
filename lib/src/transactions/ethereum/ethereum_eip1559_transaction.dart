// Class was shaped by the influence of JavaScript key sources including:
// https://github.com/ethereumjs/ethereumjs-monorepo/tree/master/packages/tx
//
// Mozilla Public License Version 2.0
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/abi_decoder.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_function.dart';
import 'package:cryptography_utils/src/utils/ethereum_utils.dart';

/// Represents an Ethereum transaction adhering to the EIP-1559 standard.
class EthereumEIP1559Transaction extends AEthereumTransaction {
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

  /// ABI data sent with the transaction
  final Uint8List data;

  /// An access list specifying storage keys and addresses that the transaction intends to access.
  final List<AccessListBytesItem> accessList;

  /// An optional digital signature of the transaction, which is used to authenticate the sender of the transaction.
  /// This field is null when the transaction is unsigned.
  final EthereumSignature? signature;

  /// The decoded ABI function from the transaction data.
  final AbiFunction? _abiFunction;

  /// Creates a new instance of [EthereumEIP1559Transaction] with the specified parameters.
  EthereumEIP1559Transaction({
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
  }) : _abiFunction = data.isNotEmpty ? AbiDecoder().decodeInput(data) : null;

  /// Decodes the serialized data into an instance of [EthereumEIP1559Transaction].
  factory EthereumEIP1559Transaction.fromSerializedData(Uint8List data) {
    int actualTxType = data[0];
    if (actualTxType != txType) {
      throw ArgumentError('Invalid transaction type: $actualTxType. Expected EIP-1559 transaction (${txType}) got $actualTxType.');
    }

    Uint8List serializedEIP1559Transaction = data.sublist(1);
    IRLPElement rlpElement = RLPCodec.decode(serializedEIP1559Transaction);

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

  EthereumEIP1559Transaction copyWith({
    BigInt? chainId,
    BigInt? nonce,
    BigInt? maxPriorityFeePerGas,
    BigInt? maxFeePerGas,
    BigInt? gasLimit,
    String? to,
    BigInt? value,
    Uint8List? data,
    List<AccessListBytesItem>? accessList,
    EthereumSignature? signature,
  }) {
    return EthereumEIP1559Transaction(
      chainId: chainId ?? this.chainId,
      nonce: nonce ?? this.nonce,
      maxPriorityFeePerGas: maxPriorityFeePerGas ?? this.maxPriorityFeePerGas,
      maxFeePerGas: maxFeePerGas ?? this.maxFeePerGas,
      gasLimit: gasLimit ?? this.gasLimit,
      to: to ?? this.to,
      value: value ?? this.value,
      data: data ?? this.data,
      accessList: accessList ?? this.accessList,
      signature: signature ?? this.signature,
    );
  }

  /// Returns decoded ABI function from the transaction data.
  @override
  AbiFunction? get abiFunction => _abiFunction;

  /// Returns address of the contract to which the transaction is directed.
  @override
  String? get contractAddress {
    if (abiFunction == null) {
      return null;
    } else {
      return to;
    }
  }

  /// Returns the amount of token used.
  @override
  TokenAmount getAmount(TokenDenominationType tokenDenominationType) {
    BigInt amountInWei = value;

    if (amountInWei == BigInt.zero && abiFunction?.amount != null) {
      return TokenAmount.fromBigInt(denomination: '', amount: abiFunction!.amount!);
    }

    switch (tokenDenominationType) {
      case TokenDenominationType.lowest:
        return TokenAmount.fromBigInt(denomination: EthereumUtils.weiSymbol, amount: amountInWei);
      case TokenDenominationType.network:
        return TokenAmount(denomination: EthereumUtils.ethSymbol, amount: EthereumUtils.convertWeiToEth(amountInWei));
    }
  }

  /// Returns the fee for the transaction.
  @override
  TokenAmount getFee(TokenDenominationType tokenDenominationType) {
    BigInt estimatedFeeInWei = maxFeePerGas * gasLimit;

    switch (tokenDenominationType) {
      case TokenDenominationType.lowest:
        return TokenAmount.fromBigInt(denomination: EthereumUtils.weiSymbol, amount: estimatedFeeInWei);
      case TokenDenominationType.network:
        return TokenAmount(denomination: EthereumUtils.ethSymbol, amount: EthereumUtils.convertWeiToEth(estimatedFeeInWei));
    }
  }

  /// Returns the recipient address of the transaction.
  @override
  String? get recipientAddress {
    if (abiFunction == null) {
      return to;
    } else {
      return abiFunction?.recipient;
    }
  }

  /// Serializes the transaction into a byte array.
  @override
  Uint8List serialize() {
    IRLPElement rlpElement = _toRLP();
    Uint8List serializedData = RLPCodec.encode(rlpElement);
    return Uint8List.fromList(<int>[txType, ...serializedData]);
  }

  /// Returns the signature of the signed transaction.
  @override
  EthereumSignature sign(ECPrivateKey ecPrivateKey) {
    EthereumSigner ethereumSigner = EthereumSigner(ecPrivateKey);
    EthereumSignature ethereumSignature = ethereumSigner.sign(serialize());
    return ethereumSignature;
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
      if (value == BigInt.zero) RLPBytes.empty() else RLPBytes.fromBigInt(value),
      RLPBytes(data),
      RLPList(accessList.map((AccessListBytesItem e) => e.toRLP()).toList()),
    ];

    if (signature != null) {
      values.addAll(<IRLPElement>[
        RLPBytes.fromBigInt(BigInt.from(signature!.v)),
        RLPBytes(signature!.rBytes),
        RLPBytes(signature!.sBytes),
      ]);
    }

    return RLPList(values);
  }

  @override
  List<Object?> get props => <Object?>[chainId, nonce, maxPriorityFeePerGas, maxFeePerGas, gasLimit, to, value, data, accessList, signature];
}
