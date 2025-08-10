import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_pubkey.dart';
import 'package:equatable/equatable.dart';

/// Address Lookup Tables, commonly referred to as "lookup tables" or "ALTs" for short,
/// allow developers to create a collection of related addresses to efficiently load more addresses in a single transaction.
///
/// https://solana.com/developers/guides/advanced/lookup-tables
class SolanaAddressLookupTable extends Equatable {
  final SolanaPubKey accountKey;
  final List<int> writableIndexesList;
  final List<int> readonlyIndexesList;

  const SolanaAddressLookupTable({
    required this.accountKey,
    required this.writableIndexesList,
    required this.readonlyIndexesList,
  });

  static SolanaAddressLookupTable fromSerializedData(ByteReader byteReader) {
    int publicKeyLength = 32;

    Uint8List key = byteReader.shiftRightBy(publicKeyLength);
    SolanaPubKey pubKey = SolanaPubKey.fromBytes(key);

    int writableCount = CompactU16Decoder.decode(byteReader);
    List<int> writableIndexes = List<int>.generate(writableCount, (_) {
      int index = byteReader.shiftRight();
      return index;
    });

    int readonlyCount = CompactU16Decoder.decode(byteReader);
    List<int> readonlyIndexes = List<int>.generate(readonlyCount, (_) {
      int index = byteReader.shiftRight();
      return index;
    });

    return SolanaAddressLookupTable(
      accountKey: pubKey,
      writableIndexesList: writableIndexes,
      readonlyIndexesList: readonlyIndexes,
    );
  }

  @override
  List<Object?> get props => <Object?>[accountKey, writableIndexesList, readonlyIndexesList];
}
