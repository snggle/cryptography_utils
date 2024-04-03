import 'dart:typed_data';

class AddressLookupTable {
  final Uint8List accountKey;
  final List<int> writableIndexes;
  final List<int> readonlyIndexes;

  AddressLookupTable({
    required this.accountKey,
    required this.writableIndexes,
    required this.readonlyIndexes,
  });
}