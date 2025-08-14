import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:equatable/equatable.dart';

/// An account's public key.
///
/// https://solana.com/docs/core/transactions#accountmeta
class SolanaPubKey extends Equatable {
  static const int publicKeyLength = 32;

  final Uint8List _bytes;

  const SolanaPubKey(Uint8List bytes) : _bytes = bytes;

  /// Decodes Base58-encoded data and creates a new instance of [SolanaPubKey] from bytes.
  factory SolanaPubKey.fromBase58(String base58) {
    Uint8List decodedBytes = Base58Codec.decode(base58);
    return SolanaPubKey.fromBytes(decodedBytes);
  }

  /// Creates a new instance of [SolanaPubKey] from bytes.
  factory SolanaPubKey.fromBytes(Uint8List bytes) {
    if (bytes.length != publicKeyLength) {
      throw Exception('Solana public key must be 32 bytes');
    }
    return SolanaPubKey(bytes);
  }

  Uint8List get bytes => _bytes;

  String toBase58() => Base58Codec.encode(_bytes);

  @override
  List<Object?> get props => <Object?>[_bytes];
}
