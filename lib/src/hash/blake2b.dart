import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// Provides functionality for hashing data using the Blake2 hash function
class Blake2d {
  final int digestSize;
  final Blake2bDigest blake2bDigest;

  Blake2d({this.digestSize = 64}) : blake2bDigest = Blake2bDigest(digestSize: digestSize);

  Uint8List process(Uint8List data) {
    return blake2bDigest.process(data);
  }
}
