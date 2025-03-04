import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/keccak/register64/register64.dart';

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

  late int _wordBufferOffset;
  late int bufferOffset;

  Ripemd160()
      : stateList = List<int>.filled(5, 0, growable: false),
        bufferList = List<int>.filled(16, 0, growable: false) {
    _reset();
  }

  Uint8List process(Uint8List inputUint8List) {
    _update(inputUint8List, 0, inputUint8List.length);

    Uint8List outputUint8List = Uint8List(_digestSize);
    int length = doFinal(outputUint8List, 0);

    return outputUint8List.sublist(0, length);
  }

  void _update(Uint8List inputUint8List, int inputOffset, int length) {
    int nbytes;
    int inputOffsetValue = inputOffset;
    int lengthValue = length;

    nbytes = _processUntillNextWord(inputUint8List, inputOffsetValue, lengthValue);
    inputOffsetValue += nbytes;
    lengthValue -= nbytes;

    nbytes = _processWholeWords(inputUint8List, inputOffsetValue, lengthValue);
    inputOffsetValue += nbytes;
    lengthValue -= nbytes;

    _processBytes(inputUint8List, inputOffsetValue, lengthValue);
  }


  void _reset() {
    _byteCountRegister64.setInt(0);

    _wordBufferOffset = 0;
    _wordBufferUint8List.fillRange(0, _wordBufferUint8List.length, 0);

    bufferOffset = 0;
    bufferList.fillRange(0, bufferList.length, 0);

    resetState();
  }

  void resetState() {
    stateList[0] = 0x67452301;
    stateList[1] = 0xefcdab89;
    stateList[2] = 0x98badcfe;
    stateList[3] = 0x10325476;
    stateList[4] = 0xc3d2e1f0;
  }

  void _processBlock() {
    Register64 r64 = Register64();
    int rounds16Right = 0x50a28be6;
    int rounds31Left = 0x5a827999;
    int rounds31Right = 0x5c4dd124;
    int rounds47Left = 0x6ed9eba1;
    int rounds47Right = 0x6d703ef3;
    int rounds63Left = 0x8f1bbcdc;
    int rounds63Right = 0x7a6d76e9;
    int rounds79Left = 0xa953fd4e;

    int? a, aa;
    int? b, bb;
    int? c, cc;
    int? d, dd;
    int? e, ee;

    a = aa = stateList[0];
    b = bb = stateList[1];
    c = cc = stateList[2];
    d = dd = stateList[3];
    e = ee = stateList[4];

    a = r64.sum32(r64.cRotationLeft32(a + _f1(b, c, d) + bufferList[0], 11), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f1(a, b, c) + bufferList[1], 14), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f1(e, a, b) + bufferList[2], 15), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f1(d, e, a) + bufferList[3], 12), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f1(c, d, e) + bufferList[4], 5), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f1(b, c, d) + bufferList[5], 8), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f1(a, b, c) + bufferList[6], 7), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f1(e, a, b) + bufferList[7], 9), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f1(d, e, a) + bufferList[8], 11), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f1(c, d, e) + bufferList[9], 13), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f1(b, c, d) + bufferList[10], 14), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f1(a, b, c) + bufferList[11], 15), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f1(e, a, b) + bufferList[12], 6), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f1(d, e, a) + bufferList[13], 7), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f1(c, d, e) + bufferList[14], 9), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f1(b, c, d) + bufferList[15], 8), e);
    c = r64.rotationLeft32Bits(c, 10);

    aa = r64.sum32(r64.cRotationLeft32(aa + _f5(bb, cc, dd) + bufferList[5] + rounds16Right, 8), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f5(aa, bb, cc) + bufferList[14] + rounds16Right, 9), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f5(ee, aa, bb) + bufferList[7] + rounds16Right, 9), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f5(dd, ee, aa) + bufferList[0] + rounds16Right, 11), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f5(cc, dd, ee) + bufferList[9] + rounds16Right, 13), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f5(bb, cc, dd) + bufferList[2] + rounds16Right, 15), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f5(aa, bb, cc) + bufferList[11] + rounds16Right, 15), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f5(ee, aa, bb) + bufferList[4] + rounds16Right, 5), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f5(dd, ee, aa) + bufferList[13] + rounds16Right, 7), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f5(cc, dd, ee) + bufferList[6] + rounds16Right, 7), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f5(bb, cc, dd) + bufferList[15] + rounds16Right, 8), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f5(aa, bb, cc) + bufferList[8] + rounds16Right, 11), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f5(ee, aa, bb) + bufferList[1] + rounds16Right, 14), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f5(dd, ee, aa) + bufferList[10] + rounds16Right, 14), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f5(cc, dd, ee) + bufferList[3] + rounds16Right, 12), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f5(bb, cc, dd) + bufferList[12] + rounds16Right, 6), ee);
    cc = r64.rotationLeft32Bits(cc, 10);

    e = r64.sum32(r64.cRotationLeft32(e + _f2(a, b, c) + bufferList[7] + rounds31Left, 7), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f2(e, a, b) + bufferList[4] + rounds31Left, 6), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f2(d, e, a) + bufferList[13] + rounds31Left, 8), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f2(c, d, e) + bufferList[1] + rounds31Left, 13), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f2(b, c, d) + bufferList[10] + rounds31Left, 11), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f2(a, b, c) + bufferList[6] + rounds31Left, 9), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f2(e, a, b) + bufferList[15] + rounds31Left, 7), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f2(d, e, a) + bufferList[3] + rounds31Left, 15), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f2(c, d, e) + bufferList[12] + rounds31Left, 7), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f2(b, c, d) + bufferList[0] + rounds31Left, 12), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f2(a, b, c) + bufferList[9] + rounds31Left, 15), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f2(e, a, b) + bufferList[5] + rounds31Left, 9), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f2(d, e, a) + bufferList[2] + rounds31Left, 11), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f2(c, d, e) + bufferList[14] + rounds31Left, 7), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f2(b, c, d) + bufferList[11] + rounds31Left, 13), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f2(a, b, c) + bufferList[8] + rounds31Left, 12), d);
    b = r64.rotationLeft32Bits(b, 10);

    ee = r64.sum32(r64.cRotationLeft32(ee + _f4(aa, bb, cc) + bufferList[6] + rounds31Right, 9), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f4(ee, aa, bb) + bufferList[11] + rounds31Right, 13), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f4(dd, ee, aa) + bufferList[3] + rounds31Right, 15), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f4(cc, dd, ee) + bufferList[7] + rounds31Right, 7), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f4(bb, cc, dd) + bufferList[0] + rounds31Right, 12), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f4(aa, bb, cc) + bufferList[13] + rounds31Right, 8), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f4(ee, aa, bb) + bufferList[5] + rounds31Right, 9), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f4(dd, ee, aa) + bufferList[10] + rounds31Right, 11), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f4(cc, dd, ee) + bufferList[14] + rounds31Right, 7), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f4(bb, cc, dd) + bufferList[15] + rounds31Right, 7), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f4(aa, bb, cc) + bufferList[8] + rounds31Right, 12), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f4(ee, aa, bb) + bufferList[12] + rounds31Right, 7), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f4(dd, ee, aa) + bufferList[4] + rounds31Right, 6), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f4(cc, dd, ee) + bufferList[9] + rounds31Right, 15), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f4(bb, cc, dd) + bufferList[1] + rounds31Right, 13), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f4(aa, bb, cc) + bufferList[2] + rounds31Right, 11), dd);
    bb = r64.rotationLeft32Bits(bb, 10);

    d = r64.sum32(r64.cRotationLeft32(d + _f3(e, a, b) + bufferList[3] + rounds47Left, 11), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f3(d, e, a) + bufferList[10] + rounds47Left, 13), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f3(c, d, e) + bufferList[14] + rounds47Left, 6), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f3(b, c, d) + bufferList[4] + rounds47Left, 7), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f3(a, b, c) + bufferList[9] + rounds47Left, 14), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f3(e, a, b) + bufferList[15] + rounds47Left, 9), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f3(d, e, a) + bufferList[8] + rounds47Left, 13), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f3(c, d, e) + bufferList[1] + rounds47Left, 15), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f3(b, c, d) + bufferList[2] + rounds47Left, 14), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f3(a, b, c) + bufferList[7] + rounds47Left, 8), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f3(e, a, b) + bufferList[0] + rounds47Left, 13), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f3(d, e, a) + bufferList[6] + rounds47Left, 6), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f3(c, d, e) + bufferList[13] + rounds47Left, 5), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f3(b, c, d) + bufferList[11] + rounds47Left, 12), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f3(a, b, c) + bufferList[5] + rounds47Left, 7), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f3(e, a, b) + bufferList[12] + rounds47Left, 5), c);
    a = r64.rotationLeft32Bits(a, 10);

    dd = r64.sum32(r64.cRotationLeft32(dd + _f3(ee, aa, bb) + bufferList[15] + rounds47Right, 9), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f3(dd, ee, aa) + bufferList[5] + rounds47Right, 7), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f3(cc, dd, ee) + bufferList[1] + rounds47Right, 15), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f3(bb, cc, dd) + bufferList[3] + rounds47Right, 11), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f3(aa, bb, cc) + bufferList[7] + rounds47Right, 8), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f3(ee, aa, bb) + bufferList[14] + rounds47Right, 6), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f3(dd, ee, aa) + bufferList[6] + rounds47Right, 6), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f3(cc, dd, ee) + bufferList[9] + rounds47Right, 14), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f3(bb, cc, dd) + bufferList[11] + rounds47Right, 12), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f3(aa, bb, cc) + bufferList[8] + rounds47Right, 13), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f3(ee, aa, bb) + bufferList[12] + rounds47Right, 5), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f3(dd, ee, aa) + bufferList[2] + rounds47Right, 14), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f3(cc, dd, ee) + bufferList[10] + rounds47Right, 13), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f3(bb, cc, dd) + bufferList[0] + rounds47Right, 13), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f3(aa, bb, cc) + bufferList[4] + rounds47Right, 7), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f3(ee, aa, bb) + bufferList[13] + rounds47Right, 5), cc);
    aa = r64.rotationLeft32Bits(aa, 10);

    c = r64.sum32(r64.cRotationLeft32(c + _f4(d, e, a) + bufferList[1] + rounds63Left, 11), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f4(c, d, e) + bufferList[9] + rounds63Left, 12), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f4(b, c, d) + bufferList[11] + rounds63Left, 14), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f4(a, b, c) + bufferList[10] + rounds63Left, 15), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f4(e, a, b) + bufferList[0] + rounds63Left, 14), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f4(d, e, a) + bufferList[8] + rounds63Left, 15), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f4(c, d, e) + bufferList[12] + rounds63Left, 9), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f4(b, c, d) + bufferList[4] + rounds63Left, 8), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f4(a, b, c) + bufferList[13] + rounds63Left, 9), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f4(e, a, b) + bufferList[3] + rounds63Left, 14), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f4(d, e, a) + bufferList[7] + rounds63Left, 5), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f4(c, d, e) + bufferList[15] + rounds63Left, 6), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f4(b, c, d) + bufferList[14] + rounds63Left, 8), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f4(a, b, c) + bufferList[5] + rounds63Left, 6), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f4(e, a, b) + bufferList[6] + rounds63Left, 5), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f4(d, e, a) + bufferList[2] + rounds63Left, 12), b);
    e = r64.rotationLeft32Bits(e, 10);

    cc = r64.sum32(r64.cRotationLeft32(cc + _f2(dd, ee, aa) + bufferList[8] + rounds63Right, 15), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f2(cc, dd, ee) + bufferList[6] + rounds63Right, 5), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f2(bb, cc, dd) + bufferList[4] + rounds63Right, 8), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f2(aa, bb, cc) + bufferList[1] + rounds63Right, 11), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f2(ee, aa, bb) + bufferList[3] + rounds63Right, 14), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f2(dd, ee, aa) + bufferList[11] + rounds63Right, 14), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f2(cc, dd, ee) + bufferList[15] + rounds63Right, 6), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f2(bb, cc, dd) + bufferList[0] + rounds63Right, 14), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f2(aa, bb, cc) + bufferList[5] + rounds63Right, 6), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f2(ee, aa, bb) + bufferList[12] + rounds63Right, 9), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f2(dd, ee, aa) + bufferList[2] + rounds63Right, 12), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f2(cc, dd, ee) + bufferList[13] + rounds63Right, 9), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f2(bb, cc, dd) + bufferList[9] + rounds63Right, 12), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f2(aa, bb, cc) + bufferList[7] + rounds63Right, 5), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f2(ee, aa, bb) + bufferList[10] + rounds63Right, 15), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f2(dd, ee, aa) + bufferList[14] + rounds63Right, 8), bb);
    ee = r64.rotationLeft32Bits(ee, 10);

    b = r64.sum32(r64.cRotationLeft32(b + _f5(c, d, e) + bufferList[4] + rounds79Left, 9), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f5(b, c, d) + bufferList[0] + rounds79Left, 15), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f5(a, b, c) + bufferList[5] + rounds79Left, 5), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f5(e, a, b) + bufferList[9] + rounds79Left, 11), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f5(d, e, a) + bufferList[7] + rounds79Left, 6), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f5(c, d, e) + bufferList[12] + rounds79Left, 8), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f5(b, c, d) + bufferList[2] + rounds79Left, 13), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f5(a, b, c) + bufferList[10] + rounds79Left, 12), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f5(e, a, b) + bufferList[14] + rounds79Left, 5), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f5(d, e, a) + bufferList[1] + rounds79Left, 12), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f5(c, d, e) + bufferList[3] + rounds79Left, 13), a);
    d = r64.rotationLeft32Bits(d, 10);
    a = r64.sum32(r64.cRotationLeft32(a + _f5(b, c, d) + bufferList[8] + rounds79Left, 14), e);
    c = r64.rotationLeft32Bits(c, 10);
    e = r64.sum32(r64.cRotationLeft32(e + _f5(a, b, c) + bufferList[11] + rounds79Left, 11), d);
    b = r64.rotationLeft32Bits(b, 10);
    d = r64.sum32(r64.cRotationLeft32(d + _f5(e, a, b) + bufferList[6] + rounds79Left, 8), c);
    a = r64.rotationLeft32Bits(a, 10);
    c = r64.sum32(r64.cRotationLeft32(c + _f5(d, e, a) + bufferList[15] + rounds79Left, 5), b);
    e = r64.rotationLeft32Bits(e, 10);
    b = r64.sum32(r64.cRotationLeft32(b + _f5(c, d, e) + bufferList[13] + rounds79Left, 6), a);
    d = r64.rotationLeft32Bits(d, 10);

    bb = r64.sum32(r64.cRotationLeft32(bb + _f1(cc, dd, ee) + bufferList[12], 8), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f1(bb, cc, dd) + bufferList[15], 5), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f1(aa, bb, cc) + bufferList[10], 12), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f1(ee, aa, bb) + bufferList[4], 9), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f1(dd, ee, aa) + bufferList[1], 12), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f1(cc, dd, ee) + bufferList[5], 5), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f1(bb, cc, dd) + bufferList[8], 14), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f1(aa, bb, cc) + bufferList[7], 6), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f1(ee, aa, bb) + bufferList[6], 8), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f1(dd, ee, aa) + bufferList[2], 13), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f1(cc, dd, ee) + bufferList[13], 6), aa);
    dd = r64.rotationLeft32Bits(dd, 10);
    aa = r64.sum32(r64.cRotationLeft32(aa + _f1(bb, cc, dd) + bufferList[14], 5), ee);
    cc = r64.rotationLeft32Bits(cc, 10);
    ee = r64.sum32(r64.cRotationLeft32(ee + _f1(aa, bb, cc) + bufferList[0], 15), dd);
    bb = r64.rotationLeft32Bits(bb, 10);
    dd = r64.sum32(r64.cRotationLeft32(dd + _f1(ee, aa, bb) + bufferList[3], 13), cc);
    aa = r64.rotationLeft32Bits(aa, 10);
    cc = r64.sum32(r64.cRotationLeft32(cc + _f1(dd, ee, aa) + bufferList[9], 11), bb);
    ee = r64.rotationLeft32Bits(ee, 10);
    bb = r64.sum32(r64.cRotationLeft32(bb + _f1(cc, dd, ee) + bufferList[11], 11), aa);
    dd = r64.rotationLeft32Bits(dd, 10);

    dd = r64.clip32(dd + c + stateList[1]);
    stateList[1] = r64.clip32(stateList[2] + d + ee);
    stateList[2] = r64.clip32(stateList[3] + e + aa);
    stateList[3] = r64.clip32(stateList[4] + a + bb);
    stateList[4] = r64.clip32(stateList[0] + b + cc);
    stateList[0] = dd;
  }


  int doFinal(Uint8List outputUint8List, int outputOffset) {
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

  int _processUntillNextWord(Uint8List inputUint8List, int inputOffset, int length) {
    int processed = 0;
    int inputOffsetValue = inputOffset;
    int lengthValue = length;

    while ((_wordBufferOffset != 0) && lengthValue > 0) {
      updateByte(inputUint8List[inputOffsetValue]);

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
      updateByte(inputUint8List[inputOffsetValue]);

      inputOffsetValue++;
      lengthValue--;
    }
  }

  void updateByte(int input) {
    _wordBufferUint8List[_wordBufferOffset++] = Register64().clip8(input);
    _processWordIfBufferFull();
    _byteCountRegister64.sumInt(1);
  }

  void _processPadding() {
    updateByte(128);
    while (_wordBufferOffset != 0) {
      updateByte(0);
    }
  }

  void _processLength(Register64 bitLengthRegister64) {
    if (bufferOffset > 14) {
      _doProcessBlock();
    }

    bufferList[14] = bitLengthRegister64.lowerHalf;
    bufferList[15] = bitLengthRegister64.upperHalf;
  }

  void _doProcessBlock() {
    _processBlock();

    bufferOffset = 0;
    bufferList.fillRange(0, 16, 0);
  }

  void _packState(Uint8List outputUint8List, int outputOffset) {
    for (int i = 0; i < _packedStateSize; i++) {
      Register64().packInput32(stateList[i], outputUint8List, outputOffset + i * 4, _endian);
    }
  }

  void _processWordIfBufferFull() {
    if (_wordBufferOffset == _wordBufferUint8List.length) {
      _processWord(_wordBufferUint8List, 0);
      _wordBufferOffset = 0;
    }
  }

  void _processWord(Uint8List inputUint8List, int inputOffset) {
    bufferList[bufferOffset++] = Register64().unpackInput32(inputUint8List, inputOffset, _endian);

    if (bufferOffset == 16) {
      _doProcessBlock();
    }
  }

  // int _sum32(int input, int output) {
  //   return (input - output) & 0xFFFFFFFF;
  // }

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
}
