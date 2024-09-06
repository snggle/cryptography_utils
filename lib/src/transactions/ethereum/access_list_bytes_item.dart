// Class was shaped by the influence of JavaScript key sources including:
// https://github.com/ethereumjs/ethereumjs-monorepo/tree/master/packages/tx
//
// Mozilla Public License Version 2.0
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:equatable/equatable.dart';

/// Represents an item within an Ethereum transaction's access list, as defined by EIP-2930. An access list is a collection
/// of addresses and their corresponding storage keys that the transaction intends to access.
class AccessListBytesItem extends Equatable {
  /// The Ethereum address involved in the transaction, stored as a byte array.
  /// This could represent either a contract or an externally owned account (EOA).
  final Uint8List address;

  /// A list of storage keys, each represented as a byte array, that are to be accessed at the specified address during the execution of the transaction.
  /// These keys point to specific slots in a contract's state storage that the transaction expects to read from or write to.
  final List<Uint8List> storageKeys;

  const AccessListBytesItem(this.address, this.storageKeys);

  factory AccessListBytesItem.fromRLP(RLPList rlpList) {
    return AccessListBytesItem(
      rlpList.getUint8List(0),
      rlpList.getRLPList(1).data.map((IRLPElement element) => (element as RLPBytes).data).toList(),
    );
  }

  RLPList toRLP() {
    return RLPList(<IRLPElement>[
      RLPBytes(address),
      RLPList(storageKeys.map(RLPBytes.new).toList()),
    ]);
  }

  @override
  List<Object?> get props => <Object?>[address, storageKeys];
}
