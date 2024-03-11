/// [Keccak] is an implementation of Keccak algorithm which is a secure hash
/// function that creates fixed-size outputs from variable-length inputs.
class Keccak {
  static final List<List<int>> _keccakRoundConstants = List<List<int>>.from(<List<int>>[
    <int>[0x00000000, 0x00000001],
    <int>[0x00000000, 0x00008082],
    <int>[0x80000000, 0x0000808a],
    <int>[0x80000000, 0x80008000],
    <int>[0x00000000, 0x0000808b],
    <int>[0x00000000, 0x80000001],
    <int>[0x80000000, 0x80008081],
    <int>[0x80000000, 0x00008009],
    <int>[0x00000000, 0x0000008a],
    <int>[0x00000000, 0x00000088],
    <int>[0x00000000, 0x80008009],
    <int>[0x00000000, 0x8000000a],
    <int>[0x00000000, 0x8000808b],
    <int>[0x80000000, 0x0000008b],
    <int>[0x80000000, 0x00008089],
    <int>[0x80000000, 0x00008003],
    <int>[0x80000000, 0x00008002],
    <int>[0x80000000, 0x00000080],
    <int>[0x00000000, 0x0000800a],
    <int>[0x80000000, 0x8000000a],
    <int>[0x80000000, 0x80008081],
    <int>[0x80000000, 0x00008080],
    <int>[0x00000000, 0x80000001],
    <int>[0x80000000, 0x80008008]
  ]);

  /// hash state
  final List<int> _state = List<int>.filled(200, 0);

  late int _bitLength;
  late int _bytesLength;
  late int _capacity;
  late int _blockSize;

  /// position in state to XOR bytes into
  int _pos = 0;

  /// whether the hash was finalized
  bool _finished = false;

  Keccak([int bitLength = 288]) {
    switch (bitLength) {
      case 128:
      case 224:
      case 256:
      case 288:
      case 384:
      case 512:
        init(bitLength);
        break;
      default:
        throw StateError(
            'invalid bitLength ($bitLength) for Keccak must only be 128,224,256,288,384,512');
    }
  }

  void init(int bitLength) {
    _bitLength = bitLength;
    _bytesLength = bitLength ~/ 8;
    _capacity = 2 * _bytesLength;
    _blockSize = 200 - _capacity;
  }

  void reset() {
    init(_bitLength);
  }

  void update(List<int> data) {
    if (_finished) {
      throw MessageException("SHA3: can't update because hash was finished");
    }

    for (var i = 0; i < data.length; i++) {
      _state[_pos++] ^= data[i] & mask8;

      if (_pos >= blockSize) {
        _keccakf(_sh, _sl, _state);
        _pos = 0;
      }
    }
  }

  void _keccakf(List<int> sh, List<int> sl, List<int> buf) {
    int bch0, bch1, bch2, bch3, bch4;
    int bcl0, bcl1, bcl2, bcl3, bcl4;
    int th, tl;

    for (int i = 0; i < 25; i++) {
      sl[i] = readUint32LE(buf, i * 8);
      sh[i] = readUint32LE(buf, i * 8 + 4);
    }
    for (int r = 0; r < 24; r++) {
      // Theta
      bch0 = sh[0] ^ sh[5] ^ sh[10] ^ sh[15] ^ sh[20];
      bch1 = sh[1] ^ sh[6] ^ sh[11] ^ sh[16] ^ sh[21];
      bch2 = sh[2] ^ sh[7] ^ sh[12] ^ sh[17] ^ sh[22];
      bch3 = sh[3] ^ sh[8] ^ sh[13] ^ sh[18] ^ sh[23];
      bch4 = sh[4] ^ sh[9] ^ sh[14] ^ sh[19] ^ sh[24];
      bcl0 = sl[0] ^ sl[5] ^ sl[10] ^ sl[15] ^ sl[20];
      bcl1 = sl[1] ^ sl[6] ^ sl[11] ^ sl[16] ^ sl[21];
      bcl2 = sl[2] ^ sl[7] ^ sl[12] ^ sl[17] ^ sl[22];
      bcl3 = sl[3] ^ sl[8] ^ sl[13] ^ sl[18] ^ sl[23];
      bcl4 = sl[4] ^ sl[9] ^ sl[14] ^ sl[19] ^ sl[24];
      th = bch4 ^ ((bch1 << 1) | (bcl1 & mask32) >> (32 - 1));
      tl = bcl4 ^ ((bcl1 << 1) | (bch1 & mask32) >> (32 - 1));

      sh[0] ^= th;
      sh[5] ^= th;
      sh[10] ^= th;
      sh[15] ^= th;
      sh[20] ^= th;
      sl[0] ^= tl;
      sl[5] ^= tl;
      sl[10] ^= tl;
      sl[15] ^= tl;
      sl[20] ^= tl;
      th = bch0 ^ ((bch2 << 1) | (bcl2 & mask32) >> (32 - 1));
      tl = bcl0 ^ ((bcl2 << 1) | (bch2 & mask32) >> (32 - 1));

      sh[1] ^= th;
      sh[6] ^= th;
      sh[11] ^= th;
      sh[16] ^= th;
      sh[21] ^= th;
      sl[1] ^= tl;
      sl[6] ^= tl;
      sl[11] ^= tl;
      sl[16] ^= tl;
      sl[21] ^= tl;
      th = bch1 ^ ((bch3 << 1) | (bcl3 & mask32) >> (32 - 1));
      tl = bcl1 ^ ((bcl3 << 1) | (bch3 & mask32) >> (32 - 1));

      sh[2] ^= th;
      sh[7] ^= th;
      sh[12] ^= th;
      sh[17] ^= th;
      sh[22] ^= th;
      sl[2] ^= tl;
      sl[7] ^= tl;
      sl[12] ^= tl;
      sl[17] ^= tl;
      sl[22] ^= tl;
      th = bch2 ^ ((bch4 << 1) | (bcl4 & mask32) >> (32 - 1));
      tl = bcl2 ^ ((bcl4 << 1) | (bch4 & mask32) >> (32 - 1));

      sh[3] ^= th;
      sl[3] ^= tl;
      sh[8] ^= th;
      sl[8] ^= tl;
      sh[13] ^= th;
      sl[13] ^= tl;
      sh[18] ^= th;
      sl[18] ^= tl;
      sh[23] ^= th;
      sl[23] ^= tl;
      th = bch3 ^ ((bch0 << 1) | (bcl0 & mask32) >> (32 - 1));
      tl = bcl3 ^ ((bcl0 << 1) | (bch0 & mask32) >> (32 - 1));

      sh[4] ^= th;
      sh[9] ^= th;
      sh[14] ^= th;
      sh[19] ^= th;
      sh[24] ^= th;
      sl[4] ^= tl;
      sl[9] ^= tl;
      sl[14] ^= tl;
      sl[19] ^= tl;
      sl[24] ^= tl;
      // Rho Pi
      th = sh[1];
      tl = sl[1];
      bch0 = sh[10];
      bcl0 = sl[10];
      sh[10] = (th << 1) | (tl & mask32) >> (32 - 1);
      sl[10] = (tl << 1) | (th & mask32) >> (32 - 1);

      th = bch0;
      tl = bcl0;
      bch0 = sh[7];
      bcl0 = sl[7];
      sh[7] = (th << 3) | (tl & mask32) >> (32 - 3);
      sl[7] = (tl << 3) | (th & mask32) >> (32 - 3);
      th = bch0;
      tl = bcl0;

      bch0 = sh[11];
      bcl0 = sl[11];
      sh[11] = (th << 6) | (tl & mask32) >> (32 - 6);
      sl[11] = (tl << 6) | (th & mask32) >> (32 - 6);
      th = bch0;
      tl = bcl0;
      bch0 = sh[17];
      bcl0 = sl[17];
      sh[17] = (th << 10) | (tl & mask32) >> (32 - 10);
      sl[17] = (tl << 10) | (th & mask32) >> (32 - 10);
      th = bch0;
      tl = bcl0;
      bch0 = sh[18];
      bcl0 = sl[18];
      sh[18] = (th << 15) | (tl & mask32) >> (32 - 15);
      sl[18] = (tl << 15) | (th & mask32) >> (32 - 15);
      th = bch0;
      tl = bcl0;
      bch0 = sh[3];
      bcl0 = sl[3];
      sh[3] = (th << 21) | (tl & mask32) >> (32 - 21);
      sl[3] = (tl << 21) | (th & mask32) >> (32 - 21);
      th = bch0;
      tl = bcl0;
      bch0 = sh[5];
      bcl0 = sl[5];
      sh[5] = (th << 28) | (tl & mask32) >> (32 - 28);
      sl[5] = (tl << 28) | (th & mask32) >> (32 - 28);
      th = bch0;
      tl = bcl0;
      bch0 = sh[16];
      bcl0 = sl[16];
      sh[16] = (tl << 4) | (th & mask32) >> (32 - 4);
      sl[16] = (th << 4) | (tl & mask32) >> (32 - 4);
      th = bch0;
      tl = bcl0;
      bch0 = sh[8];
      bcl0 = sl[8];
      sh[8] = (tl << 13) | (th & mask32) >> (32 - 13);
      sl[8] = (th << 13) | (tl & mask32) >> (32 - 13);
      th = bch0;
      tl = bcl0;
      bch0 = sh[21];
      bcl0 = sl[21];
      sh[21] = (tl << 23) | (th & mask32) >> (32 - 23);
      sl[21] = (th << 23) | (tl & mask32) >> (32 - 23);
      th = bch0;
      tl = bcl0;
      bch0 = sh[24];
      bcl0 = sl[24];
      sh[24] = (th << 2) | (tl & mask32) >> (32 - 2);
      sl[24] = (tl << 2) | (th & mask32) >> (32 - 2);
      th = bch0;
      tl = bcl0;
      bch0 = sh[4];
      bcl0 = sl[4];
      sh[4] = (th << 14) | (tl & mask32) >> (32 - 14);
      sl[4] = (tl << 14) | (th & mask32) >> (32 - 14);
      th = bch0;
      tl = bcl0;
      bch0 = sh[15];
      bcl0 = sl[15];
      sh[15] = (th << 27) | (tl & mask32) >> (32 - 27);
      sl[15] = (tl << 27) | (th & mask32) >> (32 - 27);
      th = bch0;
      tl = bcl0;
      bch0 = sh[23];
      bcl0 = sl[23];
      sh[23] = (tl << 9) | (th & mask32) >> (32 - 9);
      sl[23] = (th << 9) | (tl & mask32) >> (32 - 9);
      th = bch0;
      tl = bcl0;
      bch0 = sh[19];
      bcl0 = sl[19];
      sh[19] = (tl << 24) | (th & mask32) >> (32 - 24);
      sl[19] = (th << 24) | (tl & mask32) >> (32 - 24);
      th = bch0;
      tl = bcl0;
      bch0 = sh[13];
      bcl0 = sl[13];
      sh[13] = (th << 8) | (tl & mask32) >> (32 - 8);
      sl[13] = (tl << 8) | (th & mask32) >> (32 - 8);
      th = bch0;
      tl = bcl0;
      bch0 = sh[12];
      bcl0 = sl[12];
      sh[12] = (th << 25) | (tl & mask32) >> (32 - 25);
      sl[12] = (tl << 25) | (th & mask32) >> (32 - 25);
      th = bch0;
      tl = bcl0;
      bch0 = sh[2];
      bcl0 = sl[2];
      sh[2] = (tl << 11) | (th & mask32) >> (32 - 11);
      sl[2] = (th << 11) | (tl & mask32) >> (32 - 11);
      th = bch0;
      tl = bcl0;
      bch0 = sh[20];
      bcl0 = sl[20];
      sh[20] = (tl << 30) | (th & mask32) >> (32 - 30);
      sl[20] = (th << 30) | (tl & mask32) >> (32 - 30);
      th = bch0;
      tl = bcl0;
      bch0 = sh[14];
      bcl0 = sl[14];
      sh[14] = (th << 18) | (tl & mask32) >> (32 - 18);
      sl[14] = (tl << 18) | (th & mask32) >> (32 - 18);
      th = bch0;
      tl = bcl0;
      bch0 = sh[22];
      bcl0 = sl[22];
      sh[22] = (tl << 7) | (th & mask32) >> (32 - 7);
      sl[22] = (th << 7) | (tl & mask32) >> (32 - 7);
      th = bch0;
      tl = bcl0;
      bch0 = sh[9];
      bcl0 = sl[9];
      sh[9] = (tl << 29) | (th & mask32) >> (32 - 29);
      sl[9] = (th << 29) | (tl & mask32) >> (32 - 29);
      th = bch0;
      tl = bcl0;
      bch0 = sh[6];
      bcl0 = sl[6];
      sh[6] = (th << 20) | (tl & mask32) >> (32 - 20);
      sl[6] = (tl << 20) | (th & mask32) >> (32 - 20);
      th = bch0;
      tl = bcl0;
      bch0 = sh[1];
      bcl0 = sl[1];
      sh[1] = (tl << 12) | (th & mask32) >> (32 - 12);
      sl[1] = (th << 12) | (tl & mask32) >> (32 - 12);

      th = bch0;
      tl = bcl0;
      // Chi
      bch0 = sh[0];
      bch1 = sh[1];
      bch2 = sh[2];
      bch3 = sh[3];
      bch4 = sh[4];
      sh[0] ^= (~bch1) & bch2;
      sh[1] ^= (~bch2) & bch3;
      sh[2] ^= (~bch3) & bch4;
      sh[3] ^= (~bch4) & bch0;
      sh[4] ^= (~bch0) & bch1;
      bcl0 = sl[0];
      bcl1 = sl[1];
      bcl2 = sl[2];
      bcl3 = sl[3];
      bcl4 = sl[4];
      sl[0] ^= (~bcl1) & bcl2;
      sl[1] ^= (~bcl2) & bcl3;
      sl[2] ^= (~bcl3) & bcl4;
      sl[3] ^= (~bcl4) & bcl0;
      sl[4] ^= (~bcl0) & bcl1;
      bch0 = sh[5];
      bch1 = sh[6];
      bch2 = sh[7];
      bch3 = sh[8];
      bch4 = sh[9];
      sh[5] ^= (~bch1) & bch2;
      sh[6] ^= (~bch2) & bch3;
      sh[7] ^= (~bch3) & bch4;
      sh[8] ^= (~bch4) & bch0;
      sh[9] ^= (~bch0) & bch1;
      bcl0 = sl[5];
      bcl1 = sl[6];
      bcl2 = sl[7];
      bcl3 = sl[8];
      bcl4 = sl[9];
      sl[5] ^= (~bcl1) & bcl2;
      sl[6] ^= (~bcl2) & bcl3;
      sl[7] ^= (~bcl3) & bcl4;
      sl[8] ^= (~bcl4) & bcl0;
      sl[9] ^= (~bcl0) & bcl1;
      bch0 = sh[10];
      bch1 = sh[11];
      bch2 = sh[12];
      bch3 = sh[13];
      bch4 = sh[14];
      sh[10] ^= (~bch1) & bch2;
      sh[11] ^= (~bch2) & bch3;
      sh[12] ^= (~bch3) & bch4;
      sh[13] ^= (~bch4) & bch0;
      sh[14] ^= (~bch0) & bch1;
      bcl0 = sl[10];
      bcl1 = sl[11];
      bcl2 = sl[12];
      bcl3 = sl[13];
      bcl4 = sl[14];
      sl[10] ^= (~bcl1) & bcl2;
      sl[11] ^= (~bcl2) & bcl3;
      sl[12] ^= (~bcl3) & bcl4;
      sl[13] ^= (~bcl4) & bcl0;
      sl[14] ^= (~bcl0) & bcl1;
      bch0 = sh[15];
      bch1 = sh[16];
      bch2 = sh[17];
      bch3 = sh[18];
      bch4 = sh[19];
      sh[15] ^= (~bch1) & bch2;
      sh[16] ^= (~bch2) & bch3;
      sh[17] ^= (~bch3) & bch4;
      sh[18] ^= (~bch4) & bch0;
      sh[19] ^= (~bch0) & bch1;
      bcl0 = sl[15];
      bcl1 = sl[16];
      bcl2 = sl[17];
      bcl3 = sl[18];
      bcl4 = sl[19];
      sl[15] ^= (~bcl1) & bcl2;
      sl[16] ^= (~bcl2) & bcl3;
      sl[17] ^= (~bcl3) & bcl4;
      sl[18] ^= (~bcl4) & bcl0;
      sl[19] ^= (~bcl0) & bcl1;
      bch0 = sh[20];
      bch1 = sh[21];
      bch2 = sh[22];
      bch3 = sh[23];
      bch4 = sh[24];
      sh[20] ^= (~bch1) & bch2;
      sh[21] ^= (~bch2) & bch3;
      sh[22] ^= (~bch3) & bch4;
      sh[23] ^= (~bch4) & bch0;
      sh[24] ^= (~bch0) & bch1;
      bcl0 = sl[20];
      bcl1 = sl[21];
      bcl2 = sl[22];
      bcl3 = sl[23];
      bcl4 = sl[24];
      sl[20] ^= (~bcl1) & bcl2;
      sl[21] ^= (~bcl2) & bcl3;
      sl[22] ^= (~bcl3) & bcl4;
      sl[23] ^= (~bcl4) & bcl0;
      sl[24] ^= (~bcl0) & bcl1;
      //  Iota
      sh[0] ^= _keccakRoundConstants[0][r];
      sl[0] ^= _keccakRoundConstants[1][r];
    }

    for (int i = 0; i < 25; i++) {
      writeUint32LE(sl[i], buf, i * 8);
      writeUint32LE(sh[i], buf, i * 8 + 4);
    }
  }
}
