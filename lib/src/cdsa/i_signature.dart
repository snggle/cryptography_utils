import 'dart:typed_data';

abstract interface class ISignature {
  String get base64;

  Uint8List get bytes;

  int get length;
}
