import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:equatable/equatable.dart';

/// Class representing a Cosmos account address
/// https://docs.cosmos.network/v0.46/basics/accounts.html#addresses
class CosmosAccAddress extends Equatable {
  /// The human-readable part of the address
  final String hrp;

  /// The bytes of the address
  final Uint8List bytes;

  /// Creates [CosmosAccountAddress] from a Bech32 encoded address.
  factory CosmosAccAddress(String address) {
    Bech32Pair decodedBech32 = Bech32Codec.decode(address);
    return CosmosAccAddress._(decodedBech32.hrp, decodedBech32.data);
  }

  /// Private constructor used by the factory to initialize the hrp and bytes.
  const CosmosAccAddress._(this.hrp, this.bytes);

  /// Returns the Bech32 encoded address as a string.
  String get value => Bech32Codec.encode(Bech32Pair(hrp: hrp, data: bytes));

  @override
  List<Object?> get props => <Object?>[hrp, bytes];

  @override
  String toString() => value;
}
