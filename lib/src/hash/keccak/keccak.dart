import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [Keccak] is an implementation of Keccak algorithm which is a secure hash
/// function that creates fixed-size outputs from variable-length inputs.
class Keccak {
  /// A static lists constants used in the Keccak-f[1600] permutation
  static const int _hashDataArea = 136;
  static const List<int> _rotationConstants = <int>[1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 2, 14, 27, 41, 56, 8, 25, 43, 62, 18, 39, 61, 20, 44];
  static const List<int> _lanePositions = <int>[10, 7, 11, 17, 18, 3, 5, 16, 8, 21, 24, 4, 15, 23, 19, 13, 12, 2, 20, 14, 22, 9, 6, 1];
  static final List<BigInt> _roundConstants = <BigInt>[
    BigInt.parse('0x0000000000000001'),
    BigInt.parse('0x0000000000008082'),
    BigInt.parse('0x800000000000808A'),
    BigInt.parse('0x8000000080008000'),
    BigInt.parse('0x000000000000808B'),
    BigInt.parse('0x0000000080000001'),
    BigInt.parse('0x8000000080008081'),
    BigInt.parse('0x8000000000008009'),
    BigInt.parse('0x000000000000008A'),
    BigInt.parse('0x0000000000000088'),
    BigInt.parse('0x0000000080008009'),
    BigInt.parse('0x000000008000000A'),
    BigInt.parse('0x000000008000808B'),
    BigInt.parse('0x800000000000008B'),
    BigInt.parse('0x8000000000008089'),
    BigInt.parse('0x8000000000008003'),
    BigInt.parse('0x8000000000008002'),
    BigInt.parse('0x8000000000000080'),
    BigInt.parse('0x000000000000800A'),
    BigInt.parse('0x800000008000000A'),
    BigInt.parse('0x8000000080008081'),
    BigInt.parse('0x8000000000008080'),
    BigInt.parse('0x0000000080000001'),
    BigInt.parse('0x8000000080008008'),
  ];

  /// Specifies the number of rounds to be performed in the Keccak-f[1600] permutation.
  final int roundsCount;

  /// The size of the hash in bits.
  final int bitsSize;

  /// The size of the hash in bytes.
  final int outputLength;

  Keccak(
    this.bitsSize, {
    this.roundsCount = 24,
  }) : outputLength = bitsSize ~/ 8;

  /// Computes Keccak hash for a given input.
  Uint8List process(Uint8List input) {
    if (outputLength > 32) {
      throw ArgumentError('Output length must be 32 bytes or less!');
    }

    Uint64List result = _calculateHash(input, 32);
    Uint8List output = Uint8List(outputLength);

    for (int i = 0; i < min(outputLength, 32); i++) {
      output[i] = result[i];
    }

    return output;
  }

  /// Calculates a Keccak hash from input
  Uint64List _calculateHash(Uint8List input, int outputSize) {
    Uint64List state = Uint64List(25);
    Uint8List temp = Uint8List(144);
    ByteData inp = input.buffer.asByteData();

    int inputLength = input.length;
    int offset = 0;

    int capacity = state.lengthInBytes == outputSize ? _hashDataArea : 200 - 2 * outputSize;
    int capacityBytes = capacity ~/ 8;

    for (; inputLength >= capacity; inputLength -= capacity, offset += capacity) {
      for (int i = 0; i < capacityBytes; i++) {
        state[i] ^= inp.getUint64(offset + (i * 8), Endian.host);
      }
      _performKeccakPermutation(state, roundsCount);
    }

    for (int i = 0; i < inputLength; i++) {
      temp[i] = input[offset + i];
    }
    temp[inputLength++] = 1;
    for (int i = 0; i < capacity - inputLength; i++) {
      temp[inputLength + i] = 0;
    }
    temp[capacity - 1] |= 0x80;

    ByteData tempData = temp.buffer.asByteData();
    for (int i = 0; i < capacityBytes; i++) {
      state[i] ^= tempData.getUint64(i * 8, Endian.host);
    }

    _performKeccakPermutation(state, roundsCount);

    return state.buffer.asUint64List();
  }

  /// Performs the Keccak-f[1600] permutation on the given state.
  void _performKeccakPermutation(Uint64List state, int rounds) {
    int t;
    Uint64List bc = Uint64List(5);

    for (int round = 0; round < rounds; round++) {
      // Theta
      for (int i = 0; i < 5; i++) {
        bc[i] = state[i] ^ state[i + 5] ^ state[i + 10] ^ state[i + 15] ^ state[i + 20];
      }

      for (int i = 0; i < 5; i++) {
        t = bc[(i + 4) % 5] ^ BinaryUtils.rotl64(bc[(i + 1) % 5], 1);
        for (int j = 0; j < 25; j += 5) {
          state[j + i] ^= t;
        }
      }

      // Rho Pi
      t = state[1];
      for (int i = 0; i < 24; i++) {
        int j = _lanePositions[i];
        bc[0] = state[j];
        state[j] = BinaryUtils.rotl64(t, _rotationConstants[i]);
        t = bc[0];
      }

      // Chi
      for (int j = 0; j < 25; j += 5) {
        for (int i = 0; i < 5; i++) {
          bc[i] = state[j + i];
        }
        for (int i = 0; i < 5; i++) {
          state[j + i] ^= (~bc[(i + 1) % 5]) & bc[(i + 2) % 5];
        }
      }

      // Iota
      state[0] ^= _roundConstants[round].toSigned(64).toInt();
    }
  }
}
