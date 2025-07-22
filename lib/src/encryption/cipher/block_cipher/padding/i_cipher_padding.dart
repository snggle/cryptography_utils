import 'dart:typed_data';

abstract interface class ICipherPadding {
  int addPadding(Uint8List uint8List, int offset);

  int countPadding(Uint8List uint8List);
}
