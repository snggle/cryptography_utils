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

import 'package:cryptography_utils/src/encryption/aes/aes_constants.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/cipher/a_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/i_cipher_param.dart';
import 'package:cryptography_utils/src/encryption/cipher/param_with_iv.dart';
import 'package:cryptography_utils/src/utils/int32_utils.dart';

/// AES block cipher engine for encryption and decryption.
/// This class supports AES key expansion and encryption/decryption routines using a 128/192/256-bit key.
class AesEngine extends ABlockCipher {
  static const int _blockSize = 16;

  late List<List<int>> _workingKeyList;

  int _rounds = 0;
  List<int> _sList = List<int>.empty();

  AesEngine() : super(_blockSize);

  /// Initializes the AES cipher with the given parameters and direction.
  @override
  void init(ICipherParam? cipherParam) {
    final AesKey aesKey;

    if (cipherParam is ParamWithIV<AesKey>) {
      aesKey = cipherParam.param!;
    } else if (cipherParam is AesKey) {
      aesKey = cipherParam;
    } else {
      throw ArgumentError('Invalid parameters type for AesEngine');
    }

    _workingKeyList = _generateWorkingKey(aesKey);

    _sList = List<int>.from(AesConstants.sList);
  }

  /// Encrypts or decrypts a single block of input data.
  /// The operation depends on whether the cipher was initialized for encryption or decryption.
  /// Returns the block size (always 16).
  @override
  int processBlock(Uint8List inputUint8List, int inputOffset, Uint8List outputUint8List, int outputOffset) {
    _encryptBlock(inputUint8List, inputOffset, outputUint8List, outputOffset, _workingKeyList);
    return _blockSize;
  }

  /// Processes a full block directly and returns the resulting ciphertext/plaintext.
  /// This method wraps [processBlock] and returns a new list containing the output bytes.
  @override
  Uint8List process(Uint8List uint8list) {
    Uint8List outUint8List = Uint8List(blockSize);
    int length = processBlock(uint8list, 0, outUint8List, 0);
    return outUint8List.sublist(0, length);
  }

  /// Expands the AES key into a key schedule used during encryption or decryption.
  /// Depending on the key length (128, 192, or 256 bits), this method:
  /// - Calculates the number of rounds (10, 12, or 14),
  /// - Generates round keys using the Rijndael key schedule algorithm,
  /// - Organizes the keys into round-specific 4x4 matrices for easier block processing.
  /// The generated key schedule is used for SubBytes, ShiftRows, MixColumns, and AddRoundKey steps.
  List<List<int>> _generateWorkingKey(AesKey aesKey) {
    Uint8List aesKeyUint8List = aesKey.keyUint8List;
    _rounds = aesKey.columns + 6;

    List<List<int>> wList = List<List<int>>.generate(_rounds + 1, (int i) => List<int>.filled(4, 0, growable: false));

    switch (aesKey.columns) {
      case 4:
        int col0 = Int32Utils.unpack(aesKeyUint8List, 0, Endian.little);
        wList[0][0] = col0;
        int col1 = Int32Utils.unpack(aesKeyUint8List, 4, Endian.little);
        wList[0][1] = col1;
        int col2 = Int32Utils.unpack(aesKeyUint8List, 8, Endian.little);
        wList[0][2] = col2;
        int col3 = Int32Utils.unpack(aesKeyUint8List, 12, Endian.little);
        wList[0][3] = col3;

        for (int i = 1; i <= 10; ++i) {
          int colX = _subWord(Int32Utils.rotateRight(col3, 8)) ^ AesConstants.rConList[i - 1];
          col0 ^= colX;
          wList[i][0] = col0;
          col1 ^= col0;
          wList[i][1] = col1;
          col2 ^= col1;
          wList[i][2] = col2;
          col3 ^= col2;
          wList[i][3] = col3;
        }
        break;
      case 6:
        int col0 = Int32Utils.unpack(aesKeyUint8List, 0, Endian.little);
        wList[0][0] = col0;
        int col1 = Int32Utils.unpack(aesKeyUint8List, 4, Endian.little);
        wList[0][1] = col1;
        int col2 = Int32Utils.unpack(aesKeyUint8List, 8, Endian.little);
        wList[0][2] = col2;
        int col3 = Int32Utils.unpack(aesKeyUint8List, 12, Endian.little);
        wList[0][3] = col3;

        int col4 = Int32Utils.unpack(aesKeyUint8List, 16, Endian.little);
        int col5 = Int32Utils.unpack(aesKeyUint8List, 20, Endian.little);

        int i = 1, rcon = 1, colx;

        for (;;) {
          wList[i][0] = col4;
          wList[i][1] = col5;
          colx = _subWord(Int32Utils.rotateRight(col5, 8)) ^ rcon;
          rcon <<= 1;
          col0 ^= colx;
          wList[i][2] = col0;
          col1 ^= col0;
          wList[i][3] = col1;

          col2 ^= col1;
          wList[i + 1][0] = col2;
          col3 ^= col2;
          wList[i + 1][1] = col3;
          col4 ^= col3;
          wList[i + 1][2] = col4;
          col5 ^= col4;
          wList[i + 1][3] = col5;

          colx = _subWord(Int32Utils.rotateRight(col5, 8)) ^ rcon;
          rcon <<= 1;
          col0 ^= colx;
          wList[i + 2][0] = col0;
          col1 ^= col0;
          wList[i + 2][1] = col1;
          col2 ^= col1;
          wList[i + 2][2] = col2;
          col3 ^= col2;
          wList[i + 2][3] = col3;

          if ((i + 3) >= 13) {
            break;
          }
          col4 ^= col3;
          col5 ^= col4;
        }
        break;
      case 8:
        {
          int col0 = Int32Utils.unpack(aesKeyUint8List, 0, Endian.little);
          wList[0][0] = col0;
          int col1 = Int32Utils.unpack(aesKeyUint8List, 4, Endian.little);
          wList[0][1] = col1;
          int col2 = Int32Utils.unpack(aesKeyUint8List, 8, Endian.little);
          wList[0][2] = col2;
          int col3 = Int32Utils.unpack(aesKeyUint8List, 12, Endian.little);
          wList[0][3] = col3;

          int col4 = Int32Utils.unpack(aesKeyUint8List, 16, Endian.little);
          wList[1][0] = col4;
          int col5 = Int32Utils.unpack(aesKeyUint8List, 20, Endian.little);
          wList[1][1] = col5;
          int col6 = Int32Utils.unpack(aesKeyUint8List, 24, Endian.little);
          wList[1][2] = col6;
          int col7 = Int32Utils.unpack(aesKeyUint8List, 28, Endian.little);
          wList[1][3] = col7;

          int i = 2, rcon = 1, colx;

          for (;;) {
            colx = _subWord(Int32Utils.rotateRight(col7, 8)) ^ rcon;
            rcon <<= 1;
            col0 ^= colx;
            wList[i][0] = col0;
            col1 ^= col0;
            wList[i][1] = col1;
            col2 ^= col1;
            wList[i][2] = col2;
            col3 ^= col2;
            wList[i][3] = col3;
            ++i;

            if (i >= 15) {
              break;
            }

            colx = _subWord(col3);
            col4 ^= colx;
            wList[i][0] = col4;
            col5 ^= col4;
            wList[i][1] = col5;
            col6 ^= col5;
            wList[i][2] = col6;
            col7 ^= col6;
            wList[i][3] = col7;
            ++i;
          }
          break;
        }
      default:
        {}
    }

    return wList;
  }

  /// Applies S-box substitution to each byte of a 32-bit word during AES key expansion.
  /// The `SubWord` operation is used in the key schedule during round key generation.
  /// Each byte is independently substituted using the AES S-box
  /// Returns a 32-bit word after applying the S-box substitution to each byte.
  int _subWord(int value) {
    return AesConstants.sList[value & 255] & 255 |
        ((AesConstants.sList[(value >> 8) & 255] & 255) << 8) |
        ((AesConstants.sList[(value >> 16) & 255] & 255) << 16) |
        AesConstants.sList[(value >> 24) & 255] << 24;
  }

  /// Encrypts a single 16-byte block using AES and the previously generated key schedule.
  /// Implements the standard AES round transformations:
  /// - Initial AddRoundKey
  /// - [Nr - 1] rounds of: SubBytes → ShiftRows → MixColumns → AddRoundKey
  /// - Final round: SubBytes → ShiftRows → kwList (no MixColumns)
  /// Parameters:
  /// - [inputUint8List]: Input block of plaintext bytes.
  /// - [inputOffset]: Offset into the input buffer.
  /// - [outputUint8List]: Output buffer to write ciphertext into.
  /// - [outputOffset]: Offset into the output buffer.
  /// - [kwList]: Precomputed expanded key schedule.
  void _encryptBlock(Uint8List inputUint8List, int inputOffset, Uint8List outputUint8List, int outputOffset, List<List<int>> kwList) {
    int c0 = Int32Utils.unpack(inputUint8List, inputOffset + 0, Endian.little);
    int c1 = Int32Utils.unpack(inputUint8List, inputOffset + 4, Endian.little);
    int c2 = Int32Utils.unpack(inputUint8List, inputOffset + 8, Endian.little);
    int c3 = Int32Utils.unpack(inputUint8List, inputOffset + 12, Endian.little);

    int t0 = c0 ^ kwList[0][0];
    int t1 = c1 ^ kwList[0][1];
    int t2 = c2 ^ kwList[0][2];

    int r = 1, r0, r1, r2, r3 = c3 ^ kwList[0][3];

    while (r < _rounds - 1) {
      r0 = AesConstants.t0List[t0 & 255] ^
          Int32Utils.rotateRight(AesConstants.t0List[(t1 >> 8) & 255], 24) ^
          Int32Utils.rotateRight(AesConstants.t0List[(t2 >> 16) & 255], 16) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r3 >> 24) & 255], 8) ^
          kwList[r][0];

      r1 = AesConstants.t0List[t1 & 255] ^
          Int32Utils.rotateRight(AesConstants.t0List[(t2 >> 8) & 255], 24) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r3 >> 16) & 255], 16) ^
          Int32Utils.rotateRight(AesConstants.t0List[(t0 >> 24) & 255], 8) ^
          kwList[r][1];

      r2 = AesConstants.t0List[t2 & 255] ^
          Int32Utils.rotateRight(AesConstants.t0List[(r3 >> 8) & 255], 24) ^
          Int32Utils.rotateRight(AesConstants.t0List[(t0 >> 16) & 255], 16) ^
          Int32Utils.rotateRight(AesConstants.t0List[(t1 >> 24) & 255], 8) ^
          kwList[r][2];

      r3 = AesConstants.t0List[r3 & 255] ^
          Int32Utils.rotateRight(AesConstants.t0List[(t0 >> 8) & 255], 24) ^
          Int32Utils.rotateRight(AesConstants.t0List[(t1 >> 16) & 255], 16) ^
          Int32Utils.rotateRight(AesConstants.t0List[(t2 >> 24) & 255], 8) ^
          kwList[r++][3];
      t0 = AesConstants.t0List[r0 & 255] ^
          Int32Utils.rotateRight(AesConstants.t0List[(r1 >> 8) & 255], 24) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r2 >> 16) & 255], 16) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r3 >> 24) & 255], 8) ^
          kwList[r][0];
      t1 = AesConstants.t0List[r1 & 255] ^
          Int32Utils.rotateRight(AesConstants.t0List[(r2 >> 8) & 255], 24) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r3 >> 16) & 255], 16) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r0 >> 24) & 255], 8) ^
          kwList[r][1];
      t2 = AesConstants.t0List[r2 & 255] ^
          Int32Utils.rotateRight(AesConstants.t0List[(r3 >> 8) & 255], 24) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r0 >> 16) & 255], 16) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r1 >> 24) & 255], 8) ^
          kwList[r][2];
      r3 = AesConstants.t0List[r3 & 255] ^
          Int32Utils.rotateRight(AesConstants.t0List[(r0 >> 8) & 255], 24) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r1 >> 16) & 255], 16) ^
          Int32Utils.rotateRight(AesConstants.t0List[(r2 >> 24) & 255], 8) ^
          kwList[r++][3];
    }

    r0 = AesConstants.t0List[t0 & 255] ^
        Int32Utils.rotateRight(AesConstants.t0List[(t1 >> 8) & 255], 24) ^
        Int32Utils.rotateRight(AesConstants.t0List[(t2 >> 16) & 255], 16) ^
        Int32Utils.rotateRight(AesConstants.t0List[(r3 >> 24) & 255], 8) ^
        kwList[r][0];
    r1 = AesConstants.t0List[t1 & 255] ^
        Int32Utils.rotateRight(AesConstants.t0List[(t2 >> 8) & 255], 24) ^
        Int32Utils.rotateRight(AesConstants.t0List[(r3 >> 16) & 255], 16) ^
        Int32Utils.rotateRight(AesConstants.t0List[(t0 >> 24) & 255], 8) ^
        kwList[r][1];
    r2 = AesConstants.t0List[t2 & 255] ^
        Int32Utils.rotateRight(AesConstants.t0List[(r3 >> 8) & 255], 24) ^
        Int32Utils.rotateRight(AesConstants.t0List[(t0 >> 16) & 255], 16) ^
        Int32Utils.rotateRight(AesConstants.t0List[(t1 >> 24) & 255], 8) ^
        kwList[r][2];
    r3 = AesConstants.t0List[r3 & 255] ^
        Int32Utils.rotateRight(AesConstants.t0List[(t0 >> 8) & 255], 24) ^
        Int32Utils.rotateRight(AesConstants.t0List[(t1 >> 16) & 255], 16) ^
        Int32Utils.rotateRight(AesConstants.t0List[(t2 >> 24) & 255], 8) ^
        kwList[r++][3];

    c0 = (AesConstants.sList[r0 & 255] & 255) ^
        ((AesConstants.sList[(r1 >> 8) & 255] & 255) << 8) ^
        ((_sList[(r2 >> 16) & 255] & 255) << 16) ^
        (_sList[(r3 >> 24) & 255] << 24) ^
        kwList[r][0];
    c1 = (_sList[r1 & 255] & 255) ^
        ((AesConstants.sList[(r2 >> 8) & 255] & 255) << 8) ^
        ((AesConstants.sList[(r3 >> 16) & 255] & 255) << 16) ^
        (_sList[(r0 >> 24) & 255] << 24) ^
        kwList[r][1];
    c2 = (_sList[r2 & 255] & 255) ^
        ((AesConstants.sList[(r3 >> 8) & 255] & 255) << 8) ^
        ((AesConstants.sList[(r0 >> 16) & 255] & 255) << 16) ^
        (AesConstants.sList[(r1 >> 24) & 255] << 24) ^
        kwList[r][2];
    c3 = (_sList[r3 & 255] & 255) ^
        ((_sList[(r0 >> 8) & 255] & 255) << 8) ^
        ((_sList[(r1 >> 16) & 255] & 255) << 16) ^
        (AesConstants.sList[(r2 >> 24) & 255] << 24) ^
        kwList[r][3];

    Int32Utils()
      ..pack(c0, outputUint8List, outputOffset, Endian.little)
      ..pack(c1, outputUint8List, outputOffset + 4, Endian.little)
      ..pack(c2, outputUint8List, outputOffset + 8, Endian.little)
      ..pack(c3, outputUint8List, outputOffset + 12, Endian.little);
  }
}
