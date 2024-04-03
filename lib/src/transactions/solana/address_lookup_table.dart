import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';

class AddressLookupTable {
  final Uint8List accountKey;
  final List<int> writableIndexesList;
  final List<int> readonlyIndexesList;

  AddressLookupTable({
    required this.accountKey,
    required this.writableIndexesList,
    required this.readonlyIndexesList,
  });

  static AddressLookupTable fromSerializedData(ByteReader byteReader) {
    int publicKeyLength = 32;

    Uint8List accountKey = byteReader.shiftRightBy(publicKeyLength);

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

    return AddressLookupTable(
      accountKey: accountKey,
      writableIndexesList: writableIndexes,
      readonlyIndexesList: readonlyIndexes,
    );
  }
}