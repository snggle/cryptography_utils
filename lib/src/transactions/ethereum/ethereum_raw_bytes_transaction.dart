import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// The [EthereumRawBytesTransaction] class encapsulates the details required to
/// create a raw transaction on the Ethereum blockchain. This class is typically
/// used for transactions involving raw bytes, such as personal messages or data
/// payloads.
class EthereumRawBytesTransaction extends AEthereumTransaction {
  /// The raw transaction data.
  final Uint8List data;

  /// Decodes the serialized data into an instance of [EthereumRawBytesTransaction].
  @override
  const EthereumRawBytesTransaction.fromSerializedData(this.data);

  /// Serializes the transaction into a byte array.
  @override
  Uint8List serialize() {
    return Uint8List.fromList(data);
  }

  /// Returns the signature of the signed transaction.
  @override
  EthereumSignature sign(ECPrivateKey ecPrivateKey) {
    EthereumSigner ethereumSigner = EthereumSigner(ecPrivateKey);
    EthereumSignature ethereumSignature = ethereumSigner.signPersonalMessage(data);
    return ethereumSignature;
  }

  /// Returns the message contained in the transaction data.
  @override
  String get message {
    return ascii.decode(data);
  }

  @override
  List<Object?> get props => <Object>[data];
}
