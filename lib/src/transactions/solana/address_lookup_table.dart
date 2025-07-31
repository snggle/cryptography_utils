import 'dart:typed_data';

class AddressLookupTable {
  final Uint8List accountKey;
  final List<int> writableIndexesList;
  final List<int> readonlyIndexesList;

  AddressLookupTable({
    required this.accountKey,
    required this.writableIndexesList,
    required this.readonlyIndexesList,
  });
}