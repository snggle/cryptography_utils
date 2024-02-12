/// Implements the Keccak-f[1600] permutation function used in the SHA-3 hash algorithm.
///
/// The `KeccakF1600` class provides the core functionality of the Keccak-f permutation,
/// a critical component of the SHA-3 cryptographic hash function. This permutation operates
/// on a 1600-bit state and is defined over a series of rounds, each of which utilizes
/// a predefined set of round constants to ensure cryptographic security and complexity.
class KeccakF1600 {
  /// A static list of round constants used in the Keccak-f[1600] permutation
  static final List<BigInt> _roundConstants = <BigInt>[
    BigInt.parse('0000000000000001', radix: 16),
    BigInt.parse('0000000000008082', radix: 16),
    BigInt.parse('800000000000808A', radix: 16),
    BigInt.parse('8000000080008000', radix: 16),
    BigInt.parse('000000000000808B', radix: 16),
    BigInt.parse('0000000080000001', radix: 16),
    BigInt.parse('8000000080008081', radix: 16),
    BigInt.parse('8000000000008009', radix: 16),
    BigInt.parse('000000000000008A', radix: 16),
    BigInt.parse('0000000000000088', radix: 16),
    BigInt.parse('0000000080008009', radix: 16),
    BigInt.parse('000000008000000A', radix: 16),
    BigInt.parse('000000008000808B', radix: 16),
    BigInt.parse('800000000000008B', radix: 16),
    BigInt.parse('8000000000008089', radix: 16),
    BigInt.parse('8000000000008003', radix: 16),
    BigInt.parse('8000000000008002', radix: 16),
    BigInt.parse('8000000000000080', radix: 16),
    BigInt.parse('000000000000800A', radix: 16),
    BigInt.parse('800000008000000A', radix: 16),
    BigInt.parse('8000000080008081', radix: 16),
    BigInt.parse('8000000000008080', radix: 16),
    BigInt.parse('0000000080000001', radix: 16),
    BigInt.parse('8000000080008008', radix: 16),
  ];

  /// Specifies the number of rounds to be performed in the Keccak-f[1600] permutation.
  final int roundsCount;

  KeccakF1600(this.roundsCount);

  /// This method applies the Keccak-f[1600] permutation to the input state array `a`,
  /// modifying it in place according to the Keccak-f permutation rules. The process
  /// involves a series of bitwise operations, transformations, and the application
  /// of round constants across the specified number of rounds defined by [roundsCount].
  void process(List<BigInt> a) {
    BigInt t;
    BigInt bc0;
    BigInt bc1;
    BigInt bc2;
    BigInt bc3;
    BigInt bc4;
    BigInt d0;
    BigInt d1;
    BigInt d2;
    BigInt d3;
    BigInt d4 = BigInt.zero.toUnsigned(64);

    for (int i = 0; i < 24; i += 4) {
      if (i + roundsCount >= 24) {
        // Combines the 5 steps in each round into 2 steps.
        // Unrolls 4 rounds per loop and spreads some steps across rounds.

        // Round 1
        bc0 = (a[0] ^ a[5] ^ a[10] ^ a[15] ^ a[20]).toUnsigned(64);
        bc1 = (a[1] ^ a[6] ^ a[11] ^ a[16] ^ a[21]).toUnsigned(64);
        bc2 = (a[2] ^ a[7] ^ a[12] ^ a[17] ^ a[22]).toUnsigned(64);
        bc3 = (a[3] ^ a[8] ^ a[13] ^ a[18] ^ a[23]).toUnsigned(64);
        bc4 = (a[4] ^ a[9] ^ a[14] ^ a[19] ^ a[24]).toUnsigned(64);
        d0 = (bc4 ^ (bc1 << 1 | bc1 >> 63)).toUnsigned(64);
        d1 = (bc0 ^ (bc2 << 1 | bc2 >> 63)).toUnsigned(64);
        d2 = (bc1 ^ (bc3 << 1 | bc3 >> 63)).toUnsigned(64);
        d3 = (bc2 ^ (bc4 << 1 | bc4 >> 63)).toUnsigned(64);
        d4 = (bc3 ^ (bc0 << 1 | bc0 >> 63)).toUnsigned(64);

        bc0 = (a[0] ^ d0).toUnsigned(64);
        t = (a[6] ^ d1).toUnsigned(64);
        bc1 = (t << 44 | t >> (64 - 44)).toUnsigned(64);
        t = (a[12] ^ d2).toUnsigned(64);
        bc2 = (t << 43 | t >> (64 - 43)).toUnsigned(64);
        t = (a[18] ^ d3).toUnsigned(64);
        bc3 = (t << 21 | t >> (64 - 21)).toUnsigned(64);
        t = (a[24] ^ d4).toUnsigned(64);
        bc4 = (t << 14 | t >> (64 - 14)).toUnsigned(64);
        a[0] = (bc0 ^ (bc2 & ~bc1) ^ _roundConstants[i]).toUnsigned(64);
        a[6] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[12] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[18] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[24] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[10] ^ d0).toUnsigned(64);
        bc2 = (t << 3 | t >> (64 - 3)).toUnsigned(64);
        t = (a[16] ^ d1).toUnsigned(64);
        bc3 = (t << 45 | t >> (64 - 45)).toUnsigned(64);
        t = (a[22] ^ d2).toUnsigned(64);
        bc4 = (t << 61 | t >> (64 - 61)).toUnsigned(64);
        t = (a[3] ^ d3).toUnsigned(64);
        bc0 = (t << 28 | t >> (64 - 28)).toUnsigned(64);
        t = (a[9] ^ d4).toUnsigned(64);
        bc1 = (t << 20 | t >> (64 - 20)).toUnsigned(64);
        a[10] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[16] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[22] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[3] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[9] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[20] ^ d0).toUnsigned(64);
        bc4 = (t << 18 | t >> (64 - 18)).toUnsigned(64);
        t = (a[1] ^ d1).toUnsigned(64);
        bc0 = (t << 1 | t >> (64 - 1)).toUnsigned(64);
        t = (a[7] ^ d2).toUnsigned(64);
        bc1 = (t << 6 | t >> (64 - 6)).toUnsigned(64);
        t = (a[13] ^ d3).toUnsigned(64);
        bc2 = (t << 25 | t >> (64 - 25)).toUnsigned(64);
        t = (a[19] ^ d4).toUnsigned(64);
        bc3 = (t << 8 | t >> (64 - 8)).toUnsigned(64);
        a[20] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[1] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[7] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[13] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[19] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[5] ^ d0).toUnsigned(64);
        bc1 = (t << 36 | t >> (64 - 36)).toUnsigned(64);
        t = (a[11] ^ d1).toUnsigned(64);
        bc2 = (t << 10 | t >> (64 - 10)).toUnsigned(64);
        t = (a[17] ^ d2).toUnsigned(64);
        bc3 = (t << 15 | t >> (64 - 15)).toUnsigned(64);
        t = (a[23] ^ d3).toUnsigned(64);
        bc4 = (t << 56 | t >> (64 - 56)).toUnsigned(64);
        t = (a[4] ^ d4).toUnsigned(64);
        bc0 = (t << 27 | t >> (64 - 27)).toUnsigned(64);
        a[5] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[11] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[17] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[23] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[4] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[15] ^ d0).toUnsigned(64);
        bc3 = (t << 41 | t >> (64 - 41)).toUnsigned(64);
        t = (a[21] ^ d1).toUnsigned(64);
        bc4 = (t << 2 | t >> (64 - 2)).toUnsigned(64);
        t = (a[2] ^ d2).toUnsigned(64);
        bc0 = (t << 62 | t >> (64 - 62)).toUnsigned(64);
        t = (a[8] ^ d3).toUnsigned(64);
        bc1 = (t << 55 | t >> (64 - 55)).toUnsigned(64);
        t = (a[14] ^ d4).toUnsigned(64);
        bc2 = (t << 39 | t >> (64 - 39)).toUnsigned(64);
        a[15] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[21] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[2] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[8] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[14] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        // Round 2
        bc0 = (a[0] ^ a[5] ^ a[10] ^ a[15] ^ a[20]).toUnsigned(64);
        bc1 = (a[1] ^ a[6] ^ a[11] ^ a[16] ^ a[21]).toUnsigned(64);
        bc2 = (a[2] ^ a[7] ^ a[12] ^ a[17] ^ a[22]).toUnsigned(64);
        bc3 = (a[3] ^ a[8] ^ a[13] ^ a[18] ^ a[23]).toUnsigned(64);
        bc4 = (a[4] ^ a[9] ^ a[14] ^ a[19] ^ a[24]).toUnsigned(64);
        d0 = (bc4 ^ (bc1 << 1 | bc1 >> 63)).toUnsigned(64);
        d1 = (bc0 ^ (bc2 << 1 | bc2 >> 63)).toUnsigned(64);
        d2 = (bc1 ^ (bc3 << 1 | bc3 >> 63)).toUnsigned(64);
        d3 = (bc2 ^ (bc4 << 1 | bc4 >> 63)).toUnsigned(64);
        d4 = (bc3 ^ (bc0 << 1 | bc0 >> 63)).toUnsigned(64);

        bc0 = (a[0] ^ d0).toUnsigned(64);
        t = (a[16] ^ d1).toUnsigned(64);
        bc1 = (t << 44 | t >> (64 - 44)).toUnsigned(64);
        t = (a[7] ^ d2).toUnsigned(64);
        bc2 = (t << 43 | t >> (64 - 43)).toUnsigned(64);
        t = (a[23] ^ d3).toUnsigned(64);
        bc3 = (t << 21 | t >> (64 - 21)).toUnsigned(64);
        t = (a[14] ^ d4).toUnsigned(64);
        bc4 = (t << 14 | t >> (64 - 14)).toUnsigned(64);
        a[0] = (bc0 ^ (bc2 & ~bc1) ^ _roundConstants[i + 1]).toUnsigned(64);
        a[16] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[7] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[23] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[14] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[20] ^ d0).toUnsigned(64);
        bc2 = (t << 3 | t >> (64 - 3)).toUnsigned(64);
        t = (a[11] ^ d1).toUnsigned(64);
        bc3 = (t << 45 | t >> (64 - 45)).toUnsigned(64);
        t = (a[2] ^ d2).toUnsigned(64);
        bc4 = (t << 61 | t >> (64 - 61)).toUnsigned(64);
        t = (a[18] ^ d3).toUnsigned(64);
        bc0 = (t << 28 | t >> (64 - 28)).toUnsigned(64);
        t = (a[9] ^ d4).toUnsigned(64);
        bc1 = (t << 20 | t >> (64 - 20)).toUnsigned(64);
        a[20] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[11] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[2] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[18] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[9] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[15] ^ d0).toUnsigned(64);
        bc4 = (t << 18 | t >> (64 - 18)).toUnsigned(64);
        t = (a[6] ^ d1).toUnsigned(64);
        bc0 = (t << 1 | t >> (64 - 1)).toUnsigned(64);
        t = (a[22] ^ d2).toUnsigned(64);
        bc1 = (t << 6 | t >> (64 - 6)).toUnsigned(64);
        t = (a[13] ^ d3).toUnsigned(64);
        bc2 = (t << 25 | t >> (64 - 25)).toUnsigned(64);
        t = (a[4] ^ d4).toUnsigned(64);
        bc3 = (t << 8 | t >> (64 - 8)).toUnsigned(64);
        a[15] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[6] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[22] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[13] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[4] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[10] ^ d0).toUnsigned(64);
        bc1 = (t << 36 | t >> (64 - 36)).toUnsigned(64);
        t = (a[1] ^ d1).toUnsigned(64);
        bc2 = (t << 10 | t >> (64 - 10)).toUnsigned(64);
        t = (a[17] ^ d2).toUnsigned(64);
        bc3 = (t << 15 | t >> (64 - 15)).toUnsigned(64);
        t = (a[8] ^ d3).toUnsigned(64);
        bc4 = (t << 56 | t >> (64 - 56)).toUnsigned(64);
        t = (a[24] ^ d4).toUnsigned(64);
        bc0 = (t << 27 | t >> (64 - 27)).toUnsigned(64);
        a[10] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[1] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[17] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[8] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[24] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[5] ^ d0).toUnsigned(64);
        bc3 = (t << 41 | t >> (64 - 41)).toUnsigned(64);
        t = (a[21] ^ d1).toUnsigned(64);
        bc4 = (t << 2 | t >> (64 - 2)).toUnsigned(64);
        t = (a[12] ^ d2).toUnsigned(64);
        bc0 = (t << 62 | t >> (64 - 62)).toUnsigned(64);
        t = (a[3] ^ d3).toUnsigned(64);
        bc1 = (t << 55 | t >> (64 - 55)).toUnsigned(64);
        t = (a[19] ^ d4).toUnsigned(64);
        bc2 = (t << 39 | t >> (64 - 39)).toUnsigned(64);
        a[5] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[21] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[12] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[3] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[19] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        // Round 3
        bc0 = (a[0] ^ a[5] ^ a[10] ^ a[15] ^ a[20]).toUnsigned(64);
        bc1 = (a[1] ^ a[6] ^ a[11] ^ a[16] ^ a[21]).toUnsigned(64);
        bc2 = (a[2] ^ a[7] ^ a[12] ^ a[17] ^ a[22]).toUnsigned(64);
        bc3 = (a[3] ^ a[8] ^ a[13] ^ a[18] ^ a[23]).toUnsigned(64);
        bc4 = (a[4] ^ a[9] ^ a[14] ^ a[19] ^ a[24]).toUnsigned(64);
        d0 = (bc4 ^ (bc1 << 1 | bc1 >> 63)).toUnsigned(64);
        d1 = (bc0 ^ (bc2 << 1 | bc2 >> 63)).toUnsigned(64);
        d2 = (bc1 ^ (bc3 << 1 | bc3 >> 63)).toUnsigned(64);
        d3 = (bc2 ^ (bc4 << 1 | bc4 >> 63)).toUnsigned(64);
        d4 = (bc3 ^ (bc0 << 1 | bc0 >> 63)).toUnsigned(64);

        bc0 = (a[0] ^ d0).toUnsigned(64);
        t = (a[11] ^ d1).toUnsigned(64);
        bc1 = (t << 44 | t >> (64 - 44)).toUnsigned(64);
        t = (a[22] ^ d2).toUnsigned(64);
        bc2 = (t << 43 | t >> (64 - 43)).toUnsigned(64);
        t = (a[8] ^ d3).toUnsigned(64);
        bc3 = (t << 21 | t >> (64 - 21)).toUnsigned(64);
        t = (a[19] ^ d4).toUnsigned(64);
        bc4 = (t << 14 | t >> (64 - 14)).toUnsigned(64);
        a[0] = (bc0 ^ (bc2 & ~bc1) ^ _roundConstants[i + 2]).toUnsigned(64);
        a[11] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[22] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[8] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[19] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[15] ^ d0).toUnsigned(64);
        bc2 = (t << 3 | t >> (64 - 3)).toUnsigned(64);
        t = (a[1] ^ d1).toUnsigned(64);
        bc3 = (t << 45 | t >> (64 - 45)).toUnsigned(64);
        t = (a[12] ^ d2).toUnsigned(64);
        bc4 = (t << 61 | t >> (64 - 61)).toUnsigned(64);
        t = (a[23] ^ d3).toUnsigned(64);
        bc0 = (t << 28 | t >> (64 - 28)).toUnsigned(64);
        t = (a[9] ^ d4).toUnsigned(64);
        bc1 = (t << 20 | t >> (64 - 20)).toUnsigned(64);
        a[15] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[1] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[12] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[23] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[9] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[5] ^ d0).toUnsigned(64);
        bc4 = (t << 18 | t >> (64 - 18)).toUnsigned(64);
        t = (a[16] ^ d1).toUnsigned(64);
        bc0 = (t << 1 | t >> (64 - 1)).toUnsigned(64);
        t = (a[2] ^ d2).toUnsigned(64);
        bc1 = (t << 6 | t >> (64 - 6)).toUnsigned(64);
        t = (a[13] ^ d3).toUnsigned(64);
        bc2 = (t << 25 | t >> (64 - 25)).toUnsigned(64);
        t = (a[24] ^ d4).toUnsigned(64);
        bc3 = (t << 8 | t >> (64 - 8)).toUnsigned(64);
        a[5] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[16] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[2] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[13] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[24] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[20] ^ d0).toUnsigned(64);
        bc1 = (t << 36 | t >> (64 - 36)).toUnsigned(64);
        t = (a[6] ^ d1).toUnsigned(64);
        bc2 = (t << 10 | t >> (64 - 10)).toUnsigned(64);
        t = (a[17] ^ d2).toUnsigned(64);
        bc3 = (t << 15 | t >> (64 - 15)).toUnsigned(64);
        t = (a[3] ^ d3).toUnsigned(64);
        bc4 = (t << 56 | t >> (64 - 56)).toUnsigned(64);
        t = (a[14] ^ d4).toUnsigned(64);
        bc0 = (t << 27 | t >> (64 - 27)).toUnsigned(64);
        a[20] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[6] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[17] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[3] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[14] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[10] ^ d0).toUnsigned(64);
        bc3 = (t << 41 | t >> (64 - 41)).toUnsigned(64);
        t = (a[21] ^ d1).toUnsigned(64);
        bc4 = (t << 2 | t >> (64 - 2)).toUnsigned(64);
        t = (a[7] ^ d2).toUnsigned(64);
        bc0 = (t << 62 | t >> (64 - 62)).toUnsigned(64);
        t = (a[18] ^ d3).toUnsigned(64);
        bc1 = (t << 55 | t >> (64 - 55)).toUnsigned(64);
        t = (a[4] ^ d4).toUnsigned(64);
        bc2 = (t << 39 | t >> (64 - 39)).toUnsigned(64);
        a[10] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[21] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[7] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[18] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[4] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        // Round 4
        bc0 = (a[0] ^ a[5] ^ a[10] ^ a[15] ^ a[20]).toUnsigned(64);
        bc1 = (a[1] ^ a[6] ^ a[11] ^ a[16] ^ a[21]).toUnsigned(64);
        bc2 = (a[2] ^ a[7] ^ a[12] ^ a[17] ^ a[22]).toUnsigned(64);
        bc3 = (a[3] ^ a[8] ^ a[13] ^ a[18] ^ a[23]).toUnsigned(64);
        bc4 = (a[4] ^ a[9] ^ a[14] ^ a[19] ^ a[24]).toUnsigned(64);
        d0 = (bc4 ^ (bc1 << 1 | bc1 >> 63)).toUnsigned(64);
        d1 = (bc0 ^ (bc2 << 1 | bc2 >> 63)).toUnsigned(64);
        d2 = (bc1 ^ (bc3 << 1 | bc3 >> 63)).toUnsigned(64);
        d3 = (bc2 ^ (bc4 << 1 | bc4 >> 63)).toUnsigned(64);
        d4 = (bc3 ^ (bc0 << 1 | bc0 >> 63)).toUnsigned(64);

        bc0 = (a[0] ^ d0).toUnsigned(64);
        t = (a[1] ^ d1).toUnsigned(64);
        bc1 = (t << 44 | t >> (64 - 44)).toUnsigned(64);
        t = (a[2] ^ d2).toUnsigned(64);
        bc2 = (t << 43 | t >> (64 - 43)).toUnsigned(64);
        t = (a[3] ^ d3).toUnsigned(64);
        bc3 = (t << 21 | t >> (64 - 21)).toUnsigned(64);
        t = (a[4] ^ d4).toUnsigned(64);
        bc4 = (t << 14 | t >> (64 - 14)).toUnsigned(64);
        a[0] = (bc0 ^ (bc2 & ~bc1) ^ _roundConstants[i + 3]).toUnsigned(64);
        a[1] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[2] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[3] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[4] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[5] ^ d0).toUnsigned(64);
        bc2 = (t << 3 | t >> (64 - 3)).toUnsigned(64);
        t = (a[6] ^ d1).toUnsigned(64);
        bc3 = (t << 45 | t >> (64 - 45)).toUnsigned(64);
        t = (a[7] ^ d2).toUnsigned(64);
        bc4 = (t << 61 | t >> (64 - 61)).toUnsigned(64);
        t = (a[8] ^ d3).toUnsigned(64);
        bc0 = (t << 28 | t >> (64 - 28)).toUnsigned(64);
        t = (a[9] ^ d4).toUnsigned(64);
        bc1 = (t << 20 | t >> (64 - 20)).toUnsigned(64);
        a[5] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[6] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[7] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[8] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[9] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[10] ^ d0).toUnsigned(64);
        bc4 = (t << 18 | t >> (64 - 18)).toUnsigned(64);
        t = (a[11] ^ d1).toUnsigned(64);
        bc0 = (t << 1 | t >> (64 - 1)).toUnsigned(64);
        t = (a[12] ^ d2).toUnsigned(64);
        bc1 = (t << 6 | t >> (64 - 6)).toUnsigned(64);
        t = (a[13] ^ d3).toUnsigned(64);
        bc2 = (t << 25 | t >> (64 - 25)).toUnsigned(64);
        t = (a[14] ^ d4).toUnsigned(64);
        bc3 = (t << 8 | t >> (64 - 8)).toUnsigned(64);
        a[10] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[11] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[12] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[13] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[14] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[15] ^ d0).toUnsigned(64);
        bc1 = (t << 36 | t >> (64 - 36)).toUnsigned(64);
        t = (a[16] ^ d1).toUnsigned(64);
        bc2 = (t << 10 | t >> (64 - 10)).toUnsigned(64);
        t = (a[17] ^ d2).toUnsigned(64);
        bc3 = (t << 15 | t >> (64 - 15)).toUnsigned(64);
        t = (a[18] ^ d3).toUnsigned(64);
        bc4 = (t << 56 | t >> (64 - 56)).toUnsigned(64);
        t = (a[19] ^ d4).toUnsigned(64);
        bc0 = (t << 27 | t >> (64 - 27)).toUnsigned(64);
        a[15] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[16] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[17] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[18] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[19] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);

        t = (a[20] ^ d0).toUnsigned(64);
        bc3 = (t << 41 | t >> (64 - 41)).toUnsigned(64);
        t = (a[21] ^ d1).toUnsigned(64);
        bc4 = (t << 2 | t >> (64 - 2)).toUnsigned(64);
        t = (a[22] ^ d2).toUnsigned(64);
        bc0 = (t << 62 | t >> (64 - 62)).toUnsigned(64);
        t = (a[23] ^ d3).toUnsigned(64);
        bc1 = (t << 55 | t >> (64 - 55)).toUnsigned(64);
        t = (a[24] ^ d4).toUnsigned(64);
        bc2 = (t << 39 | t >> (64 - 39)).toUnsigned(64);
        a[20] = (bc0 ^ (bc2 & ~bc1)).toUnsigned(64);
        a[21] = (bc1 ^ (bc3 & ~bc2)).toUnsigned(64);
        a[22] = (bc2 ^ (bc4 & ~bc3)).toUnsigned(64);
        a[23] = (bc3 ^ (bc0 & ~bc4)).toUnsigned(64);
        a[24] = (bc4 ^ (bc1 & ~bc0)).toUnsigned(64);
      }
    }
  }
}
