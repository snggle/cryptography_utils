import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Hash-based Message Authentication Code.
/// It computes a MAC using a given hash function with a secret key and input data.
class HMAC {
  final Hash hash;
  late final List<int> key;

  final List<Uint8List> _chunks = <Uint8List>[];
  late final Uint8List oKeyPad;
  late final Uint8List iKeyPad;

  HMAC({required this.hash, required List<int> key}) {
    Uint8List normalizedKey = _normalizeKey(key);

    this.key = normalizedKey;

    oKeyPad = Uint8List(digestSize);
    iKeyPad = Uint8List(digestSize);

    for (int i = 0; i < digestSize; i++) {
      oKeyPad[i] = 0x5c ^ normalizedKey[i];
      iKeyPad[i] = 0x36 ^ normalizedKey[i];
    }
  }

  /// Computes HMAC for a given chunk.
  Uint8List process(List<int> message) {
    HMAC hmac = HMAC(hash: hash, key: key)..update(message);
    return hmac.digest;
  }

  /// Computes HMAC for a given list of chunks.
  Uint8List processChunks(List<List<int>> chunks) {
    HMAC hmac = HMAC(hash: hash, key: key);
    for (List<int> chunk in chunks) {
      hmac.update(chunk);
    }
    return hmac.digest;
  }

  /// Updates HMAC computation with a given chunk.
  void update(List<int> data) {
    _chunks.add(Uint8List.fromList(data));
  }

  /// Finalizes HMAC computation and returns the digest.
  Uint8List get digest {
    Uint8List message = _chunks.fold(Uint8List(0), (Uint8List previous, Uint8List chunk) => Uint8List.fromList(previous + chunk));

    List<int> innerHash = hash.convert(iKeyPad + message).bytes;
    List<int> finalHash = hash.convert(oKeyPad + innerHash).bytes;

    return Uint8List.fromList(finalHash);
  }

  /// Ensures that the key is the same length as the block size of the hash function by either hashing it or padding it with zeros.
  Uint8List _normalizeKey(List<int> key) {
    Uint8List normalizedKey = Uint8List.fromList(key);
    if (normalizedKey.length > digestSize) {
      normalizedKey = Uint8List.fromList(hash.convert(key).bytes);
    }
    if (normalizedKey.length < digestSize) {
      List<int> padding = List<int>.filled(digestSize - normalizedKey.length, 0);
      normalizedKey = Uint8List.fromList(<int>[...normalizedKey, ...padding]);
    }
    return normalizedKey;
  }

  /// Returns the size of the digest produced by the hash function.
  int get digestSize => hash.blockSize;
}
