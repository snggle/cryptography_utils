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

import 'package:cryptography_utils/src/utils/int32_utils.dart';
import 'package:cryptography_utils/src/utils/register64/register64.dart';

/// [AMD4Digest] provides message digestion, including byte processing, block management, and state updates.
/// This class can serve as a base for RIPEMD-128, RIPEMD-160, RIPEMD-256, RIPEMD-320, SM3Digest, and SHA-1, SHA-224, and SHA-256 algorithms.

/// Algorithms already implemented using AMD4Digest: RIPEMD-160. Algorithms not yet implemented but potentially possible with this algorithm: RIPEMD-128, RIPEMD-256, RIPEMD-320, SM3Digest, SHA-1, SHA-224 and SHA-256.
abstract class AMD4Digest {
  final Register64 _byteCountRegister64 = Register64(0);
  final Uint8List _wordBufferUint8List = Uint8List(4);
  final List<int> _bufferList;
  final List<int> _stateList;
  final Endian _endian;
  final int _packedStateSize;

  final int _digestSize;
  late int _wordBufferOffset;
  late int _bufferOffset;

  AMD4Digest({
    required Endian endian,
    required int digestSize,
    required int stateSize,
    required int bufferSize,
    required int packedStateSize,
  })  : _endian = endian,
        _digestSize = digestSize,
        _stateList = List<int>.filled(stateSize, 0, growable: false),
        _bufferList = List<int>.filled(bufferSize, 0, growable: false),
        _packedStateSize = packedStateSize {
    _reset();
  }

  List<int> get stateList => _stateList;

  List<int> get bufferList => _bufferList;

  Uint8List process(Uint8List inputUint8List) {
    _update(inputUint8List, 0, inputUint8List.length);

    Uint8List outputUint8List = Uint8List(_digestSize);
    int length = _doFinal(outputUint8List, 0);

    return outputUint8List.sublist(0, length);
  }

  void resetState();

  void processBlock();

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

    _processByte(inputUint8List, inputOffsetValue, lengthValue);
  }

  int _doFinal(Uint8List outputUint8List, int outputOffset) {
    Register64 bitLengthRegister64 = Register64()
      ..setRegister64(_byteCountRegister64)
      ..shiftLeft(3);

    _processPadding();
    _processLength(bitLengthRegister64);
    _finalizeBlockProcessing();

    _packState(outputUint8List, outputOffset);

    _reset();

    return _digestSize;
  }

  void _reset() {
    _byteCountRegister64.setInt(0);

    _wordBufferOffset = 0;
    _wordBufferUint8List.fillRange(0, _wordBufferUint8List.length, 0);

    _bufferOffset = 0;
    _bufferList.fillRange(0, _bufferList.length, 0);

    resetState();
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

  void _processByte(Uint8List inputUint8List, int inputOffset, int length) {
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
    _flushWordBuffer();
    _byteCountRegister64.sumInt(1);
  }

  void _processLength(Register64 bitLengthRegister64) {
    if (_bufferOffset > 14) {
      _finalizeBlockProcessing();
    }

    _bufferList[14] = bitLengthRegister64.lowerHalf;
    _bufferList[15] = bitLengthRegister64.upperHalf;
  }

  void _packState(Uint8List outputUint8List, int outputOffset) {
    for (int i = 0; i < _packedStateSize; i++) {
      Int32Utils.pack(_stateList[i], outputUint8List, outputOffset + i * 4, _endian);
    }
  }

  void _flushWordBuffer() {
    if (_wordBufferOffset == _wordBufferUint8List.length) {
      _processWord(_wordBufferUint8List, 0);
      _wordBufferOffset = 0;
    }
  }

  void _processWord(Uint8List inputUint8List, int inputOffset) {
    _bufferList[_bufferOffset++] = Int32Utils.unpack(inputUint8List, inputOffset, _endian);

    if (_bufferOffset == 16) {
      _finalizeBlockProcessing();
    }
  }

  void _finalizeBlockProcessing() {
    processBlock();

    _bufferOffset = 0;
    _bufferList.fillRange(0, 16, 0);
  }

  int _mask8Bits(int input) {
    return input & 0xFF;
  }
}
