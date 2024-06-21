import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/string_utils.dart';

/// The [EthereumRawTransaction] class encapsulates the details required to
/// create a raw transaction on the Ethereum blockchain. This class is typically
/// used for transactions involving raw bytes, such as personal messages or data
/// payloads.
class EthereumRawTransaction extends AEthereumTransaction {
  /// The raw transaction data.
  final Uint8List data;

  /// Decodes the serialized data into an instance of [EthereumRawTransaction].
  @override
  const EthereumRawTransaction.fromSerializedData(this.data);

  /// Serializes the transaction into a byte array.
  @override
  Uint8List serialize() {
    return Uint8List.fromList(data);
  }

  /// Returns the message contained in the transaction data.
  @override
  String get message {
    if (StringUtils.areASCIIBytes(data)) {
      return ascii.decode(data);
    } else {
      return '0x${HexEncoder.encode(data)}';
    }
  }

  @override
  List<Object?> get props => <Object>[data];
}
