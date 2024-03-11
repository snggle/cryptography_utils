import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/cupertino.dart';

abstract class ARipemdBase {
  static final List<int> zl = base64Decode('AAECAwQFBgcICQoLDA0ODwcEDQEKBg8DDAAJBQIOCwgDCg4ECQ8IAQIHAAYNCwUMAQkLCgAIDAQNAwcPDgUGAgQABQkHDAIKDgEDCAsGDw0=');
  static final List<int> zr = base64Decode('BQ4HAAkCCwQNBg8IAQoDDAYLAwcADQUKDg8IDAQJAQIPBQEDBw4GCQsIDAIKAAQNCAYEAQMLDwAFDAINCQcKDgwPCgQBBQgHBgINDgADCQs=');
  static final List<int> sl = base64Decode('Cw4PDAUIBwkLDQ4PBgcJCAcGCA0LCQcPBwwPCQsHDQwLDQYHDgkNDw4IDQYFDAcFCwwODw4PCQgJDgUGCAYFDAkPBQsGCA0MBQwNDgsIBQY=');
  static final List<int> sr = base64Decode('CAkJCw0PDwUHBwgLDg4MBgkNDwcMCAkLBwcMBwYPDQsJBw8LCAYGDgwNBQ4NDQcFDwUICw4OBg4GCQwJDAUPCAgFDAkMBQ4GCA0GBQ8NCws=');

  final int digestSize;

  /// Represents the current internal state of the digest computation.
  late final List<int> state;

  /// Buffer holding the input data yet to be processed.
  late final List<int> buffer;

  /// Buffer holding the chunk of data currently being processed.
  late final List<int> currentChunk;
  late int lengthInBytes;

  ARipemdBase(this.digestSize) {
    state = _readState(digestSize);
    buffer = List<int>.empty(growable: true);
    currentChunk = List<int>.filled(16, 0);
    lengthInBytes = 0;
  }

  /// Generic class used to compute Ripemd hash for a given input.
  Uint8List process(Uint8List data) {
    lengthInBytes += data.length;
    buffer.addAll(data.map((int e) => e & 0xFF).toList());
    _iterate();
    return _digest;
  }

  /// Performs bitwise transformations based on the round number in the RIPEMD algorithm.
  @protected
  int transform(int i, int x, int y, int z) {
    return switch (i) {
      < 16 => _f1(x, y, z),
      < 32 => (_f2(x, y, z) + 0x5a827999) & 0xFFFFFFFF,
      < 48 => (_f3(x, y, z) + 0x6ed9eba1) & 0xFFFFFFFF,
      < 64 => (_f4(x, y, z) + 0x8f1bbcdc) & 0xFFFFFFFF,
      (_) => (_f5(x, y, z) + 0xa953fd4e) & 0xFFFFFFFF,
    };
  }

  /// Performs specific transformations for a digest size of 80 bits or specific stages in the RIPEMD algorithm
  @protected
  int transform80bits(int i, int x, int y, int z) {
    return switch (i) {
      < 16 => (_f5(x, y, z) + 0x50a28be6) & 0xFFFFFFFF,
      < 32 => (_f4(x, y, z) + 0x5c4dd124) & 0xFFFFFFFF,
      < 48 => (_f3(x, y, z) + 0x6d703ef3) & 0xFFFFFFFF,
      < 64 => (_f2(x, y, z) + 0x7a6d76e9) & 0xFFFFFFFF,
      (_) => _f1(x, y, z),
    };
  }

  /// Abstract method used to perform transformation for specific RIPEMD implementation.
  @protected
  void processChunk(List<int> chunk);

  /// Initializes the state of the RIPEMD algorithm based on the digest size.
  List<int> _readState(int digestSize) {
    List<int> state = List<int>.filled(digestSize ~/ 4, 0);
    state[0] = 0x67452301;
    state[1] = 0xefcdab89;
    state[2] = 0x98badcfe;
    state[3] = 0x10325476;
    switch (digestSize) {
      case 20:
        state[4] = 0xc3d2e1f0;
        break;
      case 32:
        state[4] = 0x76543210;
        state[5] = 0xfedcba98;
        state[6] = 0x89abcdef;
        state[7] = 0x01234567;
        break;
      case 40:
        state[4] = 0xc3d2e1f0;
        state[5] = 0x76543210;
        state[6] = 0xfedcba98;
        state[7] = 0x89abcdef;
        state[8] = 0x01234567;
        state[9] = 0x3c2d1e0f;
    }
    return state;
  }

  /// Pads the buffer and appends the length of the processed data to finalise the data for hashing.
  void _finalize() {
    buffer.add(0x80);

    int contentsLength = lengthInBytes + 9;
    int finalizedLength = (contentsLength + 63) & -64;
    for (int i = 0; i < finalizedLength - contentsLength; i++) {
      buffer.add(0);
    }

    int lengthInBits = lengthInBytes * 8;
    int offset = buffer.length;

    buffer.addAll(List<int>.filled(8, 0));

    int highBits = lengthInBits ~/ 0x100000000;
    int lowBits = lengthInBits & 0xFFFFFFFF;

    BinaryUtils.writeUint32LE(lowBits, buffer, offset);
    BinaryUtils.writeUint32LE(highBits, buffer, offset + 4);
  }

  /// Iterates over all remaining data blocks in the buffer to process them.
  void _iterate() {
    int pendingDataChunks = buffer.length ~/ 64;
    for (int i = 0; i < pendingDataChunks; i++) {
      for (int j = 0; j < currentChunk.length; j++) {
        currentChunk[j] = BinaryUtils.readUint32LE(buffer, i * 64 + j * 4);
      }
      processChunk(currentChunk);
    }

    // Remove all pending data up to the last clean chunk break.
    buffer.removeRange(0, pendingDataChunks * 64);
  }

  /// Finalises the data processing and returns the hash of the processed data
  Uint8List get _digest {
    _finalize();
    _iterate();

    List<int> out = List<int>.filled(digestSize, 0);
    for (int i = 0; i < state.length; i++) {
      BinaryUtils.writeUint32LE(state[i], out, i * 4);
    }
    return Uint8List.fromList(out);
  }

  /// Performs a specific RIPEMD operation (x ^ y ^ z) used in block transformation
  int _f1(int x, int y, int z) => x ^ y ^ z;

  /// Performs a specific RIPEMD operation (x & y) | (~x & z) used in block transformation
  int _f2(int x, int y, int z) => (x & y) | (~x & z);

  /// Performs a specific RIPEMD operation ((x | ~y) ^ z) used in block transformation
  int _f3(int x, int y, int z) => (x | ~y) ^ z;

  /// Performs a specific RIPEMD operation ((x & z) | (y & ~z)) used in block transformation
  int _f4(int x, int y, int z) => (x & z) | (y & ~z);

  /// Performs a specific RIPEMD operation (x ^ (y | ~z)) used in block transformation
  int _f5(int x, int y, int z) => x ^ (y | ~z);
}
