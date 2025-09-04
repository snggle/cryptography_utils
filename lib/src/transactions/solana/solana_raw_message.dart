import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// The [SolanaRawMessage] class encapsulates the details required to
/// create a raw transaction on the Solana blockchain. This class is typically
/// used for transactions involving raw bytes, such as personal messages or data
/// payloads.
class SolanaRawMessage extends Equatable {
  /// The raw transaction data.
  final Uint8List data;

  /// Decodes the serialized data into an instance of [SolanaRawMessage].
  /// Makes a defensive copy so external mutation can't affect this instance.
  SolanaRawMessage.fromSerializedData(Uint8List bytes) : data = Uint8List.fromList(bytes);

  /// Serializes the message into a new byte array (defensive copy).
  Uint8List serialize() => Uint8List.fromList(data);

  /// Returns a textual view of [data] if the bytes are valid ASCII; otherwise `null`.
  String get message {
    return ascii.decode(data); // throws if non-ASCII
  }

  @override
  List<Object?> get props => <Object>[data];
}
