import 'dart:typed_data';

import 'package:pointycastle/digests/keccak.dart';

/// [Keccak] is an implementation of Keccak algorithm which is a secure hash
/// function that creates fixed-size outputs from variable-length inputs.
class Keccak {
  final int digestSize;

  Keccak(this.digestSize);

  Uint8List process(Uint8List data) {
    // TODO(dominik): Implement custom version of Keccak hashing.
    return KeccakDigest(digestSize).process(data);
  }
}
