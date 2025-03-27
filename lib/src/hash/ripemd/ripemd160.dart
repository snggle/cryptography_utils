// This class was primarily influenced by:
// "pointycastle" - Copyright (c) 2000 - 2019 The Legion of the Bouncy Castle Inc. (https://www.bouncycastle.org)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/ripemd/a_md4_digest.dart';
import 'package:cryptography_utils/src/utils/int32_utils.dart';

/// [Ripemd160] is an implementation of RIPEMD-160  algorithm which is a secure hash function
/// producing a 160-bit output, used for address encoding of Bitcoin and Cosmos.
class Ripemd160 extends AMD4Digest {
  static const int _digestLength = 20;

  late int _aHash;
  late int _bHash;
  late int _cHash;
  late int _dHash;
  late int _eHash;
  late int _aaHash;
  late int _bbHash;
  late int _ccHash;
  late int _ddHash;
  late int _eeHash;

  Ripemd160()
      : super(
          endian: Endian.little,
          digestSize: _digestLength,
          stateSize: 5,
          bufferSize: 16,
          packedStateSize: 5,
        );

  @override
  void resetState() {
    stateList[0] = 0x67452301;
    stateList[1] = 0xefcdab89;
    stateList[2] = 0x98badcfe;
    stateList[3] = 0x10325476;
    stateList[4] = 0xc3d2e1f0;
  }

  @override
  void processBlock() {
    _aHash = _aaHash = stateList[0];
    _bHash = _bbHash = stateList[1];
    _cHash = _ccHash = stateList[2];
    _dHash = _ddHash = stateList[3];
    _eHash = _eeHash = stateList[4];

    _doRounds16Left();
    _doRounds16Right();

    _doRounds31Left();
    _doRounds31Right();

    _doRounds47Left();
    _doRounds47Right();

    _doRounds63Left();
    _doRounds63Right();

    _doRounds79Left();
    _doRounds79Right();

    _ddHash = _mask32Bits(_ddHash + _cHash + stateList[1]);
    stateList[1] = _mask32Bits(stateList[2] + _dHash + _eeHash);
    stateList[2] = _mask32Bits(stateList[3] + _eHash + _aaHash);
    stateList[3] = _mask32Bits(stateList[4] + _aHash + _bbHash);
    stateList[4] = _mask32Bits(stateList[0] + _bHash + _ccHash);
    stateList[0] = _ddHash;
  }

  void _doRounds16Left() {
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleXorCombination(_bHash, _cHash, _dHash) + bufferList[0], 11), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _handleXorCombination(_aHash, _bHash, _cHash) + bufferList[1], 14), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleXorCombination(_eHash, _aHash, _bHash) + bufferList[2], 15), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _handleXorCombination(_dHash, _eHash, _aHash) + bufferList[3], 12), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleXorCombination(_cHash, _dHash, _eHash) + bufferList[4], 5), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleXorCombination(_bHash, _cHash, _dHash) + bufferList[5], 8), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _handleXorCombination(_aHash, _bHash, _cHash) + bufferList[6], 7), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleXorCombination(_eHash, _aHash, _bHash) + bufferList[7], 9), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _handleXorCombination(_dHash, _eHash, _aHash) + bufferList[8], 11), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleXorCombination(_cHash, _dHash, _eHash) + bufferList[9], 13), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleXorCombination(_bHash, _cHash, _dHash) + bufferList[10], 14), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _handleXorCombination(_aHash, _bHash, _cHash) + bufferList[11], 15), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleXorCombination(_eHash, _aHash, _bHash) + bufferList[12], 6), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _handleXorCombination(_dHash, _eHash, _aHash) + bufferList[13], 7), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleXorCombination(_cHash, _dHash, _eHash) + bufferList[14], 9), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleXorCombination(_bHash, _cHash, _dHash) + bufferList[15], 8), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
  }

  void _doRounds16Right() {
    int roundsValue = 0x50a28be6;
    _aaHash =
        _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleXorWithNegation(_bbHash, _ccHash, _ddHash) + bufferList[5] + roundsValue, 8), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash =
        _doSum32Bits(_doCircularRotateLeft(_eeHash + _handleXorWithNegation(_aaHash, _bbHash, _ccHash) + bufferList[14] + roundsValue, 9), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash =
        _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleXorWithNegation(_eeHash, _aaHash, _bbHash) + bufferList[7] + roundsValue, 9), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash =
        _doSum32Bits(_doCircularRotateLeft(_ccHash + _handleXorWithNegation(_ddHash, _eeHash, _aaHash) + bufferList[0] + roundsValue, 11), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash =
        _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleXorWithNegation(_ccHash, _ddHash, _eeHash) + bufferList[9] + roundsValue, 13), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash =
        _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleXorWithNegation(_bbHash, _ccHash, _ddHash) + bufferList[2] + roundsValue, 15), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash =
        _doSum32Bits(_doCircularRotateLeft(_eeHash + _handleXorWithNegation(_aaHash, _bbHash, _ccHash) + bufferList[11] + roundsValue, 15), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash =
        _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleXorWithNegation(_eeHash, _aaHash, _bbHash) + bufferList[4] + roundsValue, 5), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash =
        _doSum32Bits(_doCircularRotateLeft(_ccHash + _handleXorWithNegation(_ddHash, _eeHash, _aaHash) + bufferList[13] + roundsValue, 7), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash =
        _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleXorWithNegation(_ccHash, _ddHash, _eeHash) + bufferList[6] + roundsValue, 7), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash =
        _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleXorWithNegation(_bbHash, _ccHash, _ddHash) + bufferList[15] + roundsValue, 8), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash =
        _doSum32Bits(_doCircularRotateLeft(_eeHash + _handleXorWithNegation(_aaHash, _bbHash, _ccHash) + bufferList[8] + roundsValue, 11), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash =
        _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleXorWithNegation(_eeHash, _aaHash, _bbHash) + bufferList[1] + roundsValue, 14), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash =
        _doSum32Bits(_doCircularRotateLeft(_ccHash + _handleXorWithNegation(_ddHash, _eeHash, _aaHash) + bufferList[10] + roundsValue, 14), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash =
        _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleXorWithNegation(_ccHash, _ddHash, _eeHash) + bufferList[3] + roundsValue, 12), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash =
        _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleXorWithNegation(_bbHash, _ccHash, _ddHash) + bufferList[12] + roundsValue, 6), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
  }

  void _doRounds31Left() {
    int roundsValue = 0x5a827999;
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _selectBitsByInput(_aHash, _bHash, _cHash) + bufferList[7] + roundsValue, 7), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _selectBitsByInput(_eHash, _aHash, _bHash) + bufferList[4] + roundsValue, 6), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _selectBitsByInput(_dHash, _eHash, _aHash) + bufferList[13] + roundsValue, 8), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _selectBitsByInput(_cHash, _dHash, _eHash) + bufferList[1] + roundsValue, 13), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _selectBitsByInput(_bHash, _cHash, _dHash) + bufferList[10] + roundsValue, 11), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _selectBitsByInput(_aHash, _bHash, _cHash) + bufferList[6] + roundsValue, 9), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _selectBitsByInput(_eHash, _aHash, _bHash) + bufferList[15] + roundsValue, 7), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _selectBitsByInput(_dHash, _eHash, _aHash) + bufferList[3] + roundsValue, 15), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _selectBitsByInput(_cHash, _dHash, _eHash) + bufferList[12] + roundsValue, 7), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _selectBitsByInput(_bHash, _cHash, _dHash) + bufferList[0] + roundsValue, 12), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _selectBitsByInput(_aHash, _bHash, _cHash) + bufferList[9] + roundsValue, 15), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _selectBitsByInput(_eHash, _aHash, _bHash) + bufferList[5] + roundsValue, 9), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _selectBitsByInput(_dHash, _eHash, _aHash) + bufferList[2] + roundsValue, 11), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _selectBitsByInput(_cHash, _dHash, _eHash) + bufferList[14] + roundsValue, 7), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _selectBitsByInput(_bHash, _cHash, _dHash) + bufferList[11] + roundsValue, 13), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _selectBitsByInput(_aHash, _bHash, _cHash) + bufferList[8] + roundsValue, 12), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
  }

  void _doRounds31Right() {
    int roundsValue = 0x5c4dd124;
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _selectBitsByValue(_aaHash, _bbHash, _ccHash) + bufferList[6] + roundsValue, 9), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash =
        _doSum32Bits(_doCircularRotateLeft(_ddHash + _selectBitsByValue(_eeHash, _aaHash, _bbHash) + bufferList[11] + roundsValue, 13), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _selectBitsByValue(_ddHash, _eeHash, _aaHash) + bufferList[3] + roundsValue, 15), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _selectBitsByValue(_ccHash, _ddHash, _eeHash) + bufferList[7] + roundsValue, 7), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _selectBitsByValue(_bbHash, _ccHash, _ddHash) + bufferList[0] + roundsValue, 12), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _selectBitsByValue(_aaHash, _bbHash, _ccHash) + bufferList[13] + roundsValue, 8), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _selectBitsByValue(_eeHash, _aaHash, _bbHash) + bufferList[5] + roundsValue, 9), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash =
        _doSum32Bits(_doCircularRotateLeft(_ccHash + _selectBitsByValue(_ddHash, _eeHash, _aaHash) + bufferList[10] + roundsValue, 11), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _selectBitsByValue(_ccHash, _ddHash, _eeHash) + bufferList[14] + roundsValue, 7), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _selectBitsByValue(_bbHash, _ccHash, _ddHash) + bufferList[15] + roundsValue, 7), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _selectBitsByValue(_aaHash, _bbHash, _ccHash) + bufferList[8] + roundsValue, 12), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _selectBitsByValue(_eeHash, _aaHash, _bbHash) + bufferList[12] + roundsValue, 7), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _selectBitsByValue(_ddHash, _eeHash, _aaHash) + bufferList[4] + roundsValue, 6), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _selectBitsByValue(_ccHash, _ddHash, _eeHash) + bufferList[9] + roundsValue, 15), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _selectBitsByValue(_bbHash, _ccHash, _ddHash) + bufferList[1] + roundsValue, 13), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _selectBitsByValue(_aaHash, _bbHash, _ccHash) + bufferList[2] + roundsValue, 11), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
  }

  void _doRounds47Left() {
    int roundsValue = 0x6ed9eba1;
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleOrAndXor(_eHash, _aHash, _bHash) + bufferList[3] + roundsValue, 11), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _handleOrAndXor(_dHash, _eHash, _aHash) + bufferList[10] + roundsValue, 13), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleOrAndXor(_cHash, _dHash, _eHash) + bufferList[14] + roundsValue, 6), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleOrAndXor(_bHash, _cHash, _dHash) + bufferList[4] + roundsValue, 7), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _handleOrAndXor(_aHash, _bHash, _cHash) + bufferList[9] + roundsValue, 14), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleOrAndXor(_eHash, _aHash, _bHash) + bufferList[15] + roundsValue, 9), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _handleOrAndXor(_dHash, _eHash, _aHash) + bufferList[8] + roundsValue, 13), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleOrAndXor(_cHash, _dHash, _eHash) + bufferList[1] + roundsValue, 15), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleOrAndXor(_bHash, _cHash, _dHash) + bufferList[2] + roundsValue, 14), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _handleOrAndXor(_aHash, _bHash, _cHash) + bufferList[7] + roundsValue, 8), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleOrAndXor(_eHash, _aHash, _bHash) + bufferList[0] + roundsValue, 13), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _handleOrAndXor(_dHash, _eHash, _aHash) + bufferList[6] + roundsValue, 6), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleOrAndXor(_cHash, _dHash, _eHash) + bufferList[13] + roundsValue, 5), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleOrAndXor(_bHash, _cHash, _dHash) + bufferList[11] + roundsValue, 12), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _handleOrAndXor(_aHash, _bHash, _cHash) + bufferList[5] + roundsValue, 7), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleOrAndXor(_eHash, _aHash, _bHash) + bufferList[12] + roundsValue, 5), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
  }

  void _doRounds47Right() {
    int roundsValue = 0x6d703ef3;
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleOrAndXor(_eeHash, _aaHash, _bbHash) + bufferList[15] + roundsValue, 9), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _handleOrAndXor(_ddHash, _eeHash, _aaHash) + bufferList[5] + roundsValue, 7), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleOrAndXor(_ccHash, _ddHash, _eeHash) + bufferList[1] + roundsValue, 15), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleOrAndXor(_bbHash, _ccHash, _ddHash) + bufferList[3] + roundsValue, 11), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _handleOrAndXor(_aaHash, _bbHash, _ccHash) + bufferList[7] + roundsValue, 8), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleOrAndXor(_eeHash, _aaHash, _bbHash) + bufferList[14] + roundsValue, 6), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _handleOrAndXor(_ddHash, _eeHash, _aaHash) + bufferList[6] + roundsValue, 6), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleOrAndXor(_ccHash, _ddHash, _eeHash) + bufferList[9] + roundsValue, 14), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleOrAndXor(_bbHash, _ccHash, _ddHash) + bufferList[11] + roundsValue, 12), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _handleOrAndXor(_aaHash, _bbHash, _ccHash) + bufferList[8] + roundsValue, 13), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleOrAndXor(_eeHash, _aaHash, _bbHash) + bufferList[12] + roundsValue, 5), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _handleOrAndXor(_ddHash, _eeHash, _aaHash) + bufferList[2] + roundsValue, 14), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleOrAndXor(_ccHash, _ddHash, _eeHash) + bufferList[10] + roundsValue, 13), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleOrAndXor(_bbHash, _ccHash, _ddHash) + bufferList[0] + roundsValue, 13), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _handleOrAndXor(_aaHash, _bbHash, _ccHash) + bufferList[4] + roundsValue, 7), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleOrAndXor(_eeHash, _aaHash, _bbHash) + bufferList[13] + roundsValue, 5), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
  }

  void _doRounds63Left() {
    int roundsValue = 0x8f1bbcdc;
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _selectBitsByValue(_dHash, _eHash, _aHash) + bufferList[1] + roundsValue, 11), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _selectBitsByValue(_cHash, _dHash, _eHash) + bufferList[9] + roundsValue, 12), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _selectBitsByValue(_bHash, _cHash, _dHash) + bufferList[11] + roundsValue, 14), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _selectBitsByValue(_aHash, _bHash, _cHash) + bufferList[10] + roundsValue, 15), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _selectBitsByValue(_eHash, _aHash, _bHash) + bufferList[0] + roundsValue, 14), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _selectBitsByValue(_dHash, _eHash, _aHash) + bufferList[8] + roundsValue, 15), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _selectBitsByValue(_cHash, _dHash, _eHash) + bufferList[12] + roundsValue, 9), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _selectBitsByValue(_bHash, _cHash, _dHash) + bufferList[4] + roundsValue, 8), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _selectBitsByValue(_aHash, _bHash, _cHash) + bufferList[13] + roundsValue, 9), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _selectBitsByValue(_eHash, _aHash, _bHash) + bufferList[3] + roundsValue, 14), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _selectBitsByValue(_dHash, _eHash, _aHash) + bufferList[7] + roundsValue, 5), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _selectBitsByValue(_cHash, _dHash, _eHash) + bufferList[15] + roundsValue, 6), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _selectBitsByValue(_bHash, _cHash, _dHash) + bufferList[14] + roundsValue, 8), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _selectBitsByValue(_aHash, _bHash, _cHash) + bufferList[5] + roundsValue, 6), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _selectBitsByValue(_eHash, _aHash, _bHash) + bufferList[6] + roundsValue, 5), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _selectBitsByValue(_dHash, _eHash, _aHash) + bufferList[2] + roundsValue, 12), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
  }

  void _doRounds63Right() {
    int roundsValue = 0x7a6d76e9;
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _selectBitsByInput(_ddHash, _eeHash, _aaHash) + bufferList[8] + roundsValue, 15), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _selectBitsByInput(_ccHash, _ddHash, _eeHash) + bufferList[6] + roundsValue, 5), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _selectBitsByInput(_bbHash, _ccHash, _ddHash) + bufferList[4] + roundsValue, 8), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _selectBitsByInput(_aaHash, _bbHash, _ccHash) + bufferList[1] + roundsValue, 11), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _selectBitsByInput(_eeHash, _aaHash, _bbHash) + bufferList[3] + roundsValue, 14), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash =
        _doSum32Bits(_doCircularRotateLeft(_ccHash + _selectBitsByInput(_ddHash, _eeHash, _aaHash) + bufferList[11] + roundsValue, 14), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _selectBitsByInput(_ccHash, _ddHash, _eeHash) + bufferList[15] + roundsValue, 6), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _selectBitsByInput(_bbHash, _ccHash, _ddHash) + bufferList[0] + roundsValue, 14), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _selectBitsByInput(_aaHash, _bbHash, _ccHash) + bufferList[5] + roundsValue, 6), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _selectBitsByInput(_eeHash, _aaHash, _bbHash) + bufferList[12] + roundsValue, 9), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _selectBitsByInput(_ddHash, _eeHash, _aaHash) + bufferList[2] + roundsValue, 12), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _selectBitsByInput(_ccHash, _ddHash, _eeHash) + bufferList[13] + roundsValue, 9), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _selectBitsByInput(_bbHash, _ccHash, _ddHash) + bufferList[9] + roundsValue, 12), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _selectBitsByInput(_aaHash, _bbHash, _ccHash) + bufferList[7] + roundsValue, 5), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash =
        _doSum32Bits(_doCircularRotateLeft(_ddHash + _selectBitsByInput(_eeHash, _aaHash, _bbHash) + bufferList[10] + roundsValue, 15), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _selectBitsByInput(_ddHash, _eeHash, _aaHash) + bufferList[14] + roundsValue, 8), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
  }

  void _doRounds79Left() {
    int roundsValue = 0xa953fd4e;
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleXorWithNegation(_cHash, _dHash, _eHash) + bufferList[4] + roundsValue, 9), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleXorWithNegation(_bHash, _cHash, _dHash) + bufferList[0] + roundsValue, 15), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _handleXorWithNegation(_aHash, _bHash, _cHash) + bufferList[5] + roundsValue, 5), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleXorWithNegation(_eHash, _aHash, _bHash) + bufferList[9] + roundsValue, 11), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _handleXorWithNegation(_dHash, _eHash, _aHash) + bufferList[7] + roundsValue, 6), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleXorWithNegation(_cHash, _dHash, _eHash) + bufferList[12] + roundsValue, 8), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleXorWithNegation(_bHash, _cHash, _dHash) + bufferList[2] + roundsValue, 13), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _handleXorWithNegation(_aHash, _bHash, _cHash) + bufferList[10] + roundsValue, 12), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleXorWithNegation(_eHash, _aHash, _bHash) + bufferList[14] + roundsValue, 5), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _handleXorWithNegation(_dHash, _eHash, _aHash) + bufferList[1] + roundsValue, 12), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleXorWithNegation(_cHash, _dHash, _eHash) + bufferList[3] + roundsValue, 13), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
    _aHash = _doSum32Bits(_doCircularRotateLeft(_aHash + _handleXorWithNegation(_bHash, _cHash, _dHash) + bufferList[8] + roundsValue, 14), _eHash);
    _cHash = Int32Utils.rotateLeft(_cHash, 10);
    _eHash = _doSum32Bits(_doCircularRotateLeft(_eHash + _handleXorWithNegation(_aHash, _bHash, _cHash) + bufferList[11] + roundsValue, 11), _dHash);
    _bHash = Int32Utils.rotateLeft(_bHash, 10);
    _dHash = _doSum32Bits(_doCircularRotateLeft(_dHash + _handleXorWithNegation(_eHash, _aHash, _bHash) + bufferList[6] + roundsValue, 8), _cHash);
    _aHash = Int32Utils.rotateLeft(_aHash, 10);
    _cHash = _doSum32Bits(_doCircularRotateLeft(_cHash + _handleXorWithNegation(_dHash, _eHash, _aHash) + bufferList[15] + roundsValue, 5), _bHash);
    _eHash = Int32Utils.rotateLeft(_eHash, 10);
    _bHash = _doSum32Bits(_doCircularRotateLeft(_bHash + _handleXorWithNegation(_cHash, _dHash, _eHash) + bufferList[13] + roundsValue, 6), _aHash);
    _dHash = Int32Utils.rotateLeft(_dHash, 10);
  }

  void _doRounds79Right() {
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleXorCombination(_ccHash, _ddHash, _eeHash) + bufferList[12], 8), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleXorCombination(_bbHash, _ccHash, _ddHash) + bufferList[15], 5), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _handleXorCombination(_aaHash, _bbHash, _ccHash) + bufferList[10], 12), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleXorCombination(_eeHash, _aaHash, _bbHash) + bufferList[4], 9), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _handleXorCombination(_ddHash, _eeHash, _aaHash) + bufferList[1], 12), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleXorCombination(_ccHash, _ddHash, _eeHash) + bufferList[5], 5), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleXorCombination(_bbHash, _ccHash, _ddHash) + bufferList[8], 14), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _handleXorCombination(_aaHash, _bbHash, _ccHash) + bufferList[7], 6), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleXorCombination(_eeHash, _aaHash, _bbHash) + bufferList[6], 8), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _handleXorCombination(_ddHash, _eeHash, _aaHash) + bufferList[2], 13), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleXorCombination(_ccHash, _ddHash, _eeHash) + bufferList[13], 6), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
    _aaHash = _doSum32Bits(_doCircularRotateLeft(_aaHash + _handleXorCombination(_bbHash, _ccHash, _ddHash) + bufferList[14], 5), _eeHash);
    _ccHash = Int32Utils.rotateLeft(_ccHash, 10);
    _eeHash = _doSum32Bits(_doCircularRotateLeft(_eeHash + _handleXorCombination(_aaHash, _bbHash, _ccHash) + bufferList[0], 15), _ddHash);
    _bbHash = Int32Utils.rotateLeft(_bbHash, 10);
    _ddHash = _doSum32Bits(_doCircularRotateLeft(_ddHash + _handleXorCombination(_eeHash, _aaHash, _bbHash) + bufferList[3], 13), _ccHash);
    _aaHash = Int32Utils.rotateLeft(_aaHash, 10);
    _ccHash = _doSum32Bits(_doCircularRotateLeft(_ccHash + _handleXorCombination(_ddHash, _eeHash, _aaHash) + bufferList[9], 11), _bbHash);
    _eeHash = Int32Utils.rotateLeft(_eeHash, 10);
    _bbHash = _doSum32Bits(_doCircularRotateLeft(_bbHash + _handleXorCombination(_ccHash, _ddHash, _eeHash) + bufferList[11], 11), _aaHash);
    _ddHash = Int32Utils.rotateLeft(_ddHash, 10);
  }

  int _handleXorCombination(int input, int offset, int value) {
    return input ^ offset ^ value;
  }

  int _selectBitsByInput(int input, int offset, int value) {
    return (input & offset) | (~input & value);
  }

  int _handleOrAndXor(int input, int offset, int value) {
    return (input | ~offset) ^ value;
  }

  int _selectBitsByValue(int input, int offset, int value) {
    return (input & value) | (offset & ~value);
  }

  int _handleXorWithNegation(int input, int offset, int value) {
    return input ^ (offset | ~value);
  }

  int _mask32Bits(int input) {
    return input & 0xFFFFFFFF;
  }

  int _doCircularRotateLeft(int chunk32Bits, int offset) {
    return Int32Utils.rotateLeft(_mask32Bits(chunk32Bits), offset);
  }

  int _doSum32Bits(int chunk32Bits, int output) {
    return (chunk32Bits + output) & 0xFFFFFFFF;
  }
}
