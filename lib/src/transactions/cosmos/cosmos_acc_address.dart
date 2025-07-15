import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';

/// Class representing a Cosmos account address
/// https://docs.cosmos.network/v0.46/basics/accounts.html#addresses
class CosmosAccAddress extends AProtobufField {
  /// The human-readable part of the address
  final String hrp;

  /// The bytes of the address
  final Uint8List uint8List;

  /// Creates [CosmosAccountAddress] from a Bech32 encoded address.
  factory CosmosAccAddress(String address) {
    Bech32 decodedBech32 = Bech32Decoder().decode(address);
    return CosmosAccAddress._(decodedBech32.hrp, decodedBech32.uint8List);
  }

  /// Private constructor used by the factory to initialize the hrp and bytes.
  const CosmosAccAddress._(this.hrp, this.uint8List);

  @override
  List<int> encode(int fieldNumber) {
    return ProtobufBytes(uint8List).encode(fieldNumber);
  }

  /// Returns the Bech32 encoded address as a string.
  String get value {
    return Bech32Encoder().encode(Bech32(hrp, uint8List));
  }

  @override
  List<Object?> get props => <Object?>[hrp, uint8List];

  @override
  String toString() => value;
}
