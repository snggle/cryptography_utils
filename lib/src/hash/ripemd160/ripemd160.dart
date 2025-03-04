import 'dart:typed_data';
import 'package:cryptography_utils/src/hash/register64/register64.dart';

/// [CopyRipemd160] is an implementation of RIPEMD-160  algorithm which is a secure hash function
/// producing a 160-bit output, used for secure data processing and digital signatures.
class Ripemd160 {
  static const int _digestLength = 20;

  final Register64 _byteCountRegister64 = Register64(0);
  final Uint8List _wordBufferUint8List = Uint8List(4);
  final Endian _endian = Endian.little;
  final int _packedStateSize = 5;
  final int byteLength = 64;
  final List<int> bufferList;
  final List<int> stateList;
  final int _digestSize = _digestLength;
  Register64 register64 = Register64();

  late int _wordBufferOffset;
  late int bufferOffset;
  late int a;
  late int b;
  late int c;
  late int d;
  late int e;
  late int aa;
  late int bb;
  late int cc;
  late int dd;
  late int ee;

  Ripemd160()
      : stateList = List<int>.filled(5, 0, growable: false),
        bufferList = List<int>.filled(16, 0, growable: false) {
    _reset();
  }

  Uint8List process(Uint8List inputUint8List) {
    _update(inputUint8List, 0, inputUint8List.length);

    Uint8List outputUint8List = Uint8List(_digestSize);
    int length = _doFinal(outputUint8List, 0);

    return outputUint8List.sublist(0, length);
  }

  void _update(Uint8List inputUint8List, int inputOffset, int length) {
    int nbytes;
    int inputOffsetValue = inputOffset;
    int lengthValue = length;

    nbytes = _processUntilNextWord(inputUint8List, inputOffsetValue, lengthValue);
    inputOffsetValue += nbytes;
    lengthValue -= nbytes;

    nbytes = _processWholeWords(inputUint8List, inputOffsetValue, lengthValue);
    inputOffsetValue += nbytes;
    lengthValue -= nbytes;

    _processBytes(inputUint8List, inputOffsetValue, lengthValue);
  }

  int _doFinal(Uint8List outputUint8List, int outputOffset) {
    Register64 bitLengthRegister64 = Register64()
      ..setRegister64(_byteCountRegister64)
      ..shiftLeft(3);

    _processPadding();
    _processLength(bitLengthRegister64);
    _doProcessBlock();

    _packState(outputUint8List, outputOffset);

    _reset();

    return _digestSize;
  }

  void _reset() {
    _byteCountRegister64.setInt(0);

    _wordBufferOffset = 0;
    _wordBufferUint8List.fillRange(0, _wordBufferUint8List.length, 0);

    bufferOffset = 0;
    bufferList.fillRange(0, bufferList.length, 0);

    _resetState();
  }

  void _resetState() {
    stateList[0] = 0x67452301;
    stateList[1] = 0xefcdab89;
    stateList[2] = 0x98badcfe;
    stateList[3] = 0x10325476;
    stateList[4] = 0xc3d2e1f0;
  }

  int _processUntilNextWord(Uint8List inputUint8List, int inputOffset, int length) {
    int processed = 0;
    int inputOffsetValue = inputOffset;
    int lengthValue = length;

    while ((_wordBufferOffset != 0) && lengthValue > 0) {
      _updateByte(inputUint8List[inputOffsetValue]);

      inputOffsetValue++;
      lengthValue--;
      processed++;
    }
    return processed;
  }

  int _processWholeWords(Uint8List inputUint8List, int inputOffset, int length) {
    int processed = 0;
    int inputOffsetValue = inputOffset;
    int lengthValue = length;

    while (lengthValue > _wordBufferUint8List.length) {
      _processWord(inputUint8List, inputOffsetValue);

      inputOffsetValue += _wordBufferUint8List.length;
      lengthValue -= _wordBufferUint8List.length;
      _byteCountRegister64.sumInt(_wordBufferUint8List.length);
      processed += 4;
    }
    return processed;
  }

  void _processBytes(Uint8List inputUint8List, int inputOffset, int length) {
    int inputOffsetValue = inputOffset;
    int lengthValue = length;

    while (lengthValue > 0) {
      _updateByte(inputUint8List[inputOffsetValue]);

      inputOffsetValue++;
      lengthValue--;
    }
  }

  void _processPadding() {
    _updateByte(128);
    while (_wordBufferOffset != 0) {
      _updateByte(0);
    }
  }

  void _updateByte(int input) {
    _wordBufferUint8List[_wordBufferOffset++] = _mask8Bits(input);
    _processWordIfBufferFull();
    _byteCountRegister64.sumInt(1);
  }

  void _processLength(Register64 bitLengthRegister64) {
    if (bufferOffset > 14) {
      _doProcessBlock();
    }

    bufferList[14] = bitLengthRegister64.lowerHalf;
    bufferList[15] = bitLengthRegister64.upperHalf;
  }

  void _packState(Uint8List outputUint8List, int outputOffset) {
    for (int i = 0; i < _packedStateSize; i++) {
      _packInput32(stateList[i], outputUint8List, outputOffset + i * 4, _endian);
    }
  }

  void _processWordIfBufferFull() {
    if (_wordBufferOffset == _wordBufferUint8List.length) {
      _processWord(_wordBufferUint8List, 0);
      _wordBufferOffset = 0;
    }
  }

  void _processWord(Uint8List inputUint8List, int inputOffset) {
    bufferList[bufferOffset++] = _unpackInput32Bits(inputUint8List, inputOffset, _endian);

    if (bufferOffset == 16) {
      _doProcessBlock();
    }
  }

  void _doProcessBlock() {
    _processBlock();

    bufferOffset = 0;
    bufferList.fillRange(0, 16, 0);
  }

  void _processBlock() {
    a = aa = stateList[0];
    b = bb = stateList[1];
    c = cc = stateList[2];
    d = dd = stateList[3];
    e = ee = stateList[4];

    _rounds16Left();
    _rounds16Right();

    _rounds31Left();
    _rounds31Right();

    _rounds47Left();
    _rounds47Right();

    _rounds63Left();
    _rounds63Right();

    _rounds79Left();
    _round79Right();

    dd = _mask32Bits(dd + c + stateList[1]);
    stateList[1] = _mask32Bits(stateList[2] + d + ee);
    stateList[2] = _mask32Bits(stateList[3] + e + aa);
    stateList[3] = _mask32Bits(stateList[4] + a + bb);
    stateList[4] = _mask32Bits(stateList[0] + b + cc);
    stateList[0] = dd;
  }

  void _rounds16Left() {
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f1(b, c, d) + bufferList[0], 11), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f1(a, b, c) + bufferList[1], 14), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f1(e, a, b) + bufferList[2], 15), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f1(d, e, a) + bufferList[3], 12), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f1(c, d, e) + bufferList[4], 5), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f1(b, c, d) + bufferList[5], 8), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f1(a, b, c) + bufferList[6], 7), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f1(e, a, b) + bufferList[7], 9), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f1(d, e, a) + bufferList[8], 11), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f1(c, d, e) + bufferList[9], 13), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f1(b, c, d) + bufferList[10], 14), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f1(a, b, c) + bufferList[11], 15), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f1(e, a, b) + bufferList[12], 6), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f1(d, e, a) + bufferList[13], 7), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f1(c, d, e) + bufferList[14], 9), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f1(b, c, d) + bufferList[15], 8), e);
    c = register64.rotateLeft32Bits(c, 10);
  }

  void _rounds16Right() {
    int roundValue = 0x50a28be6;
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f5(bb, cc, dd) + bufferList[5] + roundValue, 8), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f5(aa, bb, cc) + bufferList[14] + roundValue, 9), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f5(ee, aa, bb) + bufferList[7] + roundValue, 9), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f5(dd, ee, aa) + bufferList[0] + roundValue, 11), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f5(cc, dd, ee) + bufferList[9] + roundValue, 13), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f5(bb, cc, dd) + bufferList[2] + roundValue, 15), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f5(aa, bb, cc) + bufferList[11] + roundValue, 15), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f5(ee, aa, bb) + bufferList[4] + roundValue, 5), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f5(dd, ee, aa) + bufferList[13] + roundValue, 7), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f5(cc, dd, ee) + bufferList[6] + roundValue, 7), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f5(bb, cc, dd) + bufferList[15] + roundValue, 8), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f5(aa, bb, cc) + bufferList[8] + roundValue, 11), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f5(ee, aa, bb) + bufferList[1] + roundValue, 14), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f5(dd, ee, aa) + bufferList[10] + roundValue, 14), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f5(cc, dd, ee) + bufferList[3] + roundValue, 12), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f5(bb, cc, dd) + bufferList[12] + roundValue, 6), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
  }

  void _rounds31Left() {
    int roundValue = 0x5a827999;
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f2(a, b, c) + bufferList[7] + roundValue, 7), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f2(e, a, b) + bufferList[4] + roundValue, 6), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f2(d, e, a) + bufferList[13] + roundValue, 8), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f2(c, d, e) + bufferList[1] + roundValue, 13), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f2(b, c, d) + bufferList[10] + roundValue, 11), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f2(a, b, c) + bufferList[6] + roundValue, 9), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f2(e, a, b) + bufferList[15] + roundValue, 7), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f2(d, e, a) + bufferList[3] + roundValue, 15), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f2(c, d, e) + bufferList[12] + roundValue, 7), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f2(b, c, d) + bufferList[0] + roundValue, 12), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f2(a, b, c) + bufferList[9] + roundValue, 15), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f2(e, a, b) + bufferList[5] + roundValue, 9), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f2(d, e, a) + bufferList[2] + roundValue, 11), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f2(c, d, e) + bufferList[14] + roundValue, 7), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f2(b, c, d) + bufferList[11] + roundValue, 13), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f2(a, b, c) + bufferList[8] + roundValue, 12), d);
    b = register64.rotateLeft32Bits(b, 10);
  }

  void _rounds31Right() {
    int roundValue = 0x5c4dd124;
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f4(aa, bb, cc) + bufferList[6] + roundValue, 9), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f4(ee, aa, bb) + bufferList[11] + roundValue, 13), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f4(dd, ee, aa) + bufferList[3] + roundValue, 15), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f4(cc, dd, ee) + bufferList[7] + roundValue, 7), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f4(bb, cc, dd) + bufferList[0] + roundValue, 12), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f4(aa, bb, cc) + bufferList[13] + roundValue, 8), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f4(ee, aa, bb) + bufferList[5] + roundValue, 9), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f4(dd, ee, aa) + bufferList[10] + roundValue, 11), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f4(cc, dd, ee) + bufferList[14] + roundValue, 7), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f4(bb, cc, dd) + bufferList[15] + roundValue, 7), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f4(aa, bb, cc) + bufferList[8] + roundValue, 12), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f4(ee, aa, bb) + bufferList[12] + roundValue, 7), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f4(dd, ee, aa) + bufferList[4] + roundValue, 6), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f4(cc, dd, ee) + bufferList[9] + roundValue, 15), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f4(bb, cc, dd) + bufferList[1] + roundValue, 13), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f4(aa, bb, cc) + bufferList[2] + roundValue, 11), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
  }

  void _rounds47Left() {
    int roundValue = 0x6ed9eba1;
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f3(e, a, b) + bufferList[3] + roundValue, 11), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f3(d, e, a) + bufferList[10] + roundValue, 13), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f3(c, d, e) + bufferList[14] + roundValue, 6), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f3(b, c, d) + bufferList[4] + roundValue, 7), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f3(a, b, c) + bufferList[9] + roundValue, 14), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f3(e, a, b) + bufferList[15] + roundValue, 9), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f3(d, e, a) + bufferList[8] + roundValue, 13), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f3(c, d, e) + bufferList[1] + roundValue, 15), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f3(b, c, d) + bufferList[2] + roundValue, 14), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f3(a, b, c) + bufferList[7] + roundValue, 8), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f3(e, a, b) + bufferList[0] + roundValue, 13), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f3(d, e, a) + bufferList[6] + roundValue, 6), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f3(c, d, e) + bufferList[13] + roundValue, 5), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f3(b, c, d) + bufferList[11] + roundValue, 12), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f3(a, b, c) + bufferList[5] + roundValue, 7), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f3(e, a, b) + bufferList[12] + roundValue, 5), c);
    a = register64.rotateLeft32Bits(a, 10);
  }

  void _rounds47Right() {
    int roundValue = 0x6d703ef3;
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f3(ee, aa, bb) + bufferList[15] + roundValue, 9), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f3(dd, ee, aa) + bufferList[5] + roundValue, 7), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f3(cc, dd, ee) + bufferList[1] + roundValue, 15), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f3(bb, cc, dd) + bufferList[3] + roundValue, 11), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f3(aa, bb, cc) + bufferList[7] + roundValue, 8), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f3(ee, aa, bb) + bufferList[14] + roundValue, 6), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f3(dd, ee, aa) + bufferList[6] + roundValue, 6), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f3(cc, dd, ee) + bufferList[9] + roundValue, 14), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f3(bb, cc, dd) + bufferList[11] + roundValue, 12), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f3(aa, bb, cc) + bufferList[8] + roundValue, 13), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f3(ee, aa, bb) + bufferList[12] + roundValue, 5), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f3(dd, ee, aa) + bufferList[2] + roundValue, 14), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f3(cc, dd, ee) + bufferList[10] + roundValue, 13), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f3(bb, cc, dd) + bufferList[0] + roundValue, 13), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f3(aa, bb, cc) + bufferList[4] + roundValue, 7), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f3(ee, aa, bb) + bufferList[13] + roundValue, 5), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
  }

  void _rounds63Left() {
    int roundsValue = 0x8f1bbcdc;
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f4(d, e, a) + bufferList[1] + roundsValue, 11), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f4(c, d, e) + bufferList[9] + roundsValue, 12), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f4(b, c, d) + bufferList[11] + roundsValue, 14), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f4(a, b, c) + bufferList[10] + roundsValue, 15), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f4(e, a, b) + bufferList[0] + roundsValue, 14), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f4(d, e, a) + bufferList[8] + roundsValue, 15), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f4(c, d, e) + bufferList[12] + roundsValue, 9), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f4(b, c, d) + bufferList[4] + roundsValue, 8), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f4(a, b, c) + bufferList[13] + roundsValue, 9), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f4(e, a, b) + bufferList[3] + roundsValue, 14), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f4(d, e, a) + bufferList[7] + roundsValue, 5), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f4(c, d, e) + bufferList[15] + roundsValue, 6), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f4(b, c, d) + bufferList[14] + roundsValue, 8), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f4(a, b, c) + bufferList[5] + roundsValue, 6), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f4(e, a, b) + bufferList[6] + roundsValue, 5), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f4(d, e, a) + bufferList[2] + roundsValue, 12), b);
    e = register64.rotateLeft32Bits(e, 10);
  }

  void _rounds63Right() {
    int roundValue = 0x7a6d76e9;
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f2(dd, ee, aa) + bufferList[8] + roundValue, 15), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f2(cc, dd, ee) + bufferList[6] + roundValue, 5), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f2(bb, cc, dd) + bufferList[4] + roundValue, 8), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f2(aa, bb, cc) + bufferList[1] + roundValue, 11), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f2(ee, aa, bb) + bufferList[3] + roundValue, 14), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f2(dd, ee, aa) + bufferList[11] + roundValue, 14), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f2(cc, dd, ee) + bufferList[15] + roundValue, 6), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f2(bb, cc, dd) + bufferList[0] + roundValue, 14), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f2(aa, bb, cc) + bufferList[5] + roundValue, 6), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f2(ee, aa, bb) + bufferList[12] + roundValue, 9), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f2(dd, ee, aa) + bufferList[2] + roundValue, 12), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f2(cc, dd, ee) + bufferList[13] + roundValue, 9), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f2(bb, cc, dd) + bufferList[9] + roundValue, 12), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f2(aa, bb, cc) + bufferList[7] + roundValue, 5), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f2(ee, aa, bb) + bufferList[10] + roundValue, 15), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f2(dd, ee, aa) + bufferList[14] + roundValue, 8), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
  }

  void _rounds79Left() {
    int roundValue = 0xa953fd4e;
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f5(c, d, e) + bufferList[4] + roundValue, 9), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f5(b, c, d) + bufferList[0] + roundValue, 15), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f5(a, b, c) + bufferList[5] + roundValue, 5), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f5(e, a, b) + bufferList[9] + roundValue, 11), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f5(d, e, a) + bufferList[7] + roundValue, 6), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f5(c, d, e) + bufferList[12] + roundValue, 8), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f5(b, c, d) + bufferList[2] + roundValue, 13), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f5(a, b, c) + bufferList[10] + roundValue, 12), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f5(e, a, b) + bufferList[14] + roundValue, 5), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f5(d, e, a) + bufferList[1] + roundValue, 12), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f5(c, d, e) + bufferList[3] + roundValue, 13), a);
    d = register64.rotateLeft32Bits(d, 10);
    a = _sum32Bits(_circularRotateLeft32Bits(a + _f5(b, c, d) + bufferList[8] + roundValue, 14), e);
    c = register64.rotateLeft32Bits(c, 10);
    e = _sum32Bits(_circularRotateLeft32Bits(e + _f5(a, b, c) + bufferList[11] + roundValue, 11), d);
    b = register64.rotateLeft32Bits(b, 10);
    d = _sum32Bits(_circularRotateLeft32Bits(d + _f5(e, a, b) + bufferList[6] + roundValue, 8), c);
    a = register64.rotateLeft32Bits(a, 10);
    c = _sum32Bits(_circularRotateLeft32Bits(c + _f5(d, e, a) + bufferList[15] + roundValue, 5), b);
    e = register64.rotateLeft32Bits(e, 10);
    b = _sum32Bits(_circularRotateLeft32Bits(b + _f5(c, d, e) + bufferList[13] + roundValue, 6), a);
    d = register64.rotateLeft32Bits(d, 10);
  }

  void _round79Right() {
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f1(cc, dd, ee) + bufferList[12], 8), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f1(bb, cc, dd) + bufferList[15], 5), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f1(aa, bb, cc) + bufferList[10], 12), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f1(ee, aa, bb) + bufferList[4], 9), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f1(dd, ee, aa) + bufferList[1], 12), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f1(cc, dd, ee) + bufferList[5], 5), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f1(bb, cc, dd) + bufferList[8], 14), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f1(aa, bb, cc) + bufferList[7], 6), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f1(ee, aa, bb) + bufferList[6], 8), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f1(dd, ee, aa) + bufferList[2], 13), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f1(cc, dd, ee) + bufferList[13], 6), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
    aa = _sum32Bits(_circularRotateLeft32Bits(aa + _f1(bb, cc, dd) + bufferList[14], 5), ee);
    cc = register64.rotateLeft32Bits(cc, 10);
    ee = _sum32Bits(_circularRotateLeft32Bits(ee + _f1(aa, bb, cc) + bufferList[0], 15), dd);
    bb = register64.rotateLeft32Bits(bb, 10);
    dd = _sum32Bits(_circularRotateLeft32Bits(dd + _f1(ee, aa, bb) + bufferList[3], 13), cc);
    aa = register64.rotateLeft32Bits(aa, 10);
    cc = _sum32Bits(_circularRotateLeft32Bits(cc + _f1(dd, ee, aa) + bufferList[9], 11), bb);
    ee = register64.rotateLeft32Bits(ee, 10);
    bb = _sum32Bits(_circularRotateLeft32Bits(bb + _f1(cc, dd, ee) + bufferList[11], 11), aa);
    dd = register64.rotateLeft32Bits(dd, 10);
  }

  int _f1(int input, int offset, int value) {
    return input ^ offset ^ value;
  }

  int _f2(int input, int offset, int value) {
    return (input & offset) | (~input & value);
  }

  int _f3(int input, int offset, int value) {
    return (input | ~offset) ^ value;
  }

  int _f4(int input, int offset, int value) {
    return (input & value) | (offset & ~value);
  }

  int _f5(int input, int offset, int value) {
    return input ^ (offset | ~value);
  }

  int _mask8Bits(int input) {
    return input & 0xFF;
  }

  int _mask32Bits(int input) {
    return input & 0xFFFFFFFF;
  }

  int _circularRotateLeft32Bits(int chunk32Bits, int offset) {
    return register64.rotateLeft32Bits(_mask32Bits(chunk32Bits), offset);
  }

  int _sum32Bits(int chunk32Bits, int output) {
    return (chunk32Bits + output) & 0xFFFFFFFF;
  }

  int _unpackInput32Bits(Uint8List inputUint8List, int offset, Endian endian) {
    ByteData byteData = ByteData.view(inputUint8List.buffer, inputUint8List.offsetInBytes, inputUint8List.length);
    return byteData.getUint32(offset, endian);
  }

  void _packInput32(int x, Uint8List outputUint8List, int offset, Endian endian) {
    ByteData.view(outputUint8List.buffer, outputUint8List.offsetInBytes, outputUint8List.length).setUint32(offset, x, endian);
  }
}
