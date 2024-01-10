import 'dart:typed_data';

import 'package:pointycastle/digests/ripemd160.dart';

/// [Ripemd160] is an implementation of RIPEMD-160  algorithm which is a secure hash function
/// producing a 160-bit output, used for secure data processing and digital signatures.
class Ripemd160 {
  Uint8List process(Uint8List data) {
    // TODO(dominik): Implement custom version of RIPEMD16 hashing.
    return RIPEMD160Digest().process(data);
  }
}
