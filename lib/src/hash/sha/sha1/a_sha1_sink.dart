//This class was primarily influenced by:
// Copyright 2015, the Dart project authors.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
// * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following
// disclaimer in the documentation and/or other materials provided
// with the distribution.
// * Neither the name of Google LLC nor the names of its
// contributors may be used to endorse or promote products derived
// from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/hash/a_hash_sink.dart';
import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';

/// [ASha1Sink] provides the core SHA-1 compression logic for 512-bit input blocks.
abstract class ASha1Sink extends AHashSink {
  final Uint32List _extendedUint32List = Uint32List(80);
  final Uint32List _digestUint32List;

  ASha1Sink(Sink<Digest> sink, this._digestUint32List) : super(sink, 16);

  @override
  Uint32List get digestUint32List => _digestUint32List;

  @override
  void updateHash(Uint32List inputUint32List) {
    for (int i = 0; i < 16; i++) {
      _extendedUint32List[i] = inputUint32List[i];
    }
    for (int i = 16; i < 80; i++) {
      _extendedUint32List[i] =
          _rotationLeft32(1, _extendedUint32List[i - 3] ^ _extendedUint32List[i - 8] ^ _extendedUint32List[i - 14] ^ _extendedUint32List[i - 16]);
    }

    int aHash = _digestUint32List[0];
    int bHash = _digestUint32List[1];
    int cHash = _digestUint32List[2];
    int dHash = _digestUint32List[3];
    int eHash = _digestUint32List[4];

    for (int i = 0; i < 80; i++) {
      int temp = (_rotationLeft32(5, aHash) + _applyRoundFunction(i, bHash, cHash, dHash) + eHash + _applyRoundConstant(i) + _extendedUint32List[i]) &
          AHashSink.mask32;
      eHash = dHash;
      dHash = cHash;
      cHash = _rotationLeft32(30, bHash);
      bHash = aHash;
      aHash = temp;
    }

    _digestUint32List[0] = (_digestUint32List[0] + aHash) & AHashSink.mask32;
    _digestUint32List[1] = (_digestUint32List[1] + bHash) & AHashSink.mask32;
    _digestUint32List[2] = (_digestUint32List[2] + cHash) & AHashSink.mask32;
    _digestUint32List[3] = (_digestUint32List[3] + dHash) & AHashSink.mask32;
    _digestUint32List[4] = (_digestUint32List[4] + eHash) & AHashSink.mask32;
  }

  int _applyRoundFunction(int round, int bHash, int cHash, int dHash) {
    if (round < 20) {
      return (bHash & cHash) | ((~bHash & AHashSink.mask32) & dHash);
    }
    if (round < 40) {
      return bHash ^ cHash ^ dHash;
    }
    if (round < 60) {
      return (bHash & cHash) | (bHash & dHash) | (cHash & dHash);
    }
    return bHash ^ cHash ^ dHash;
  }

  int _applyRoundConstant(int round) {
    if (round < 20) {
      return 0x5A827999;
    }
    if (round < 40) {
      return 0x6ED9EBA1;
    }
    if (round < 60) {
      return 0x8F1BBCDC;
    }
    return 0xCA62C1D6;
  }

  int _rotationLeft32(int bits, int value) {
    int modShift = bits & 31;
    return ((value << modShift) & AHashSink.mask32) | ((value & AHashSink.mask32) >> (32 - modShift));
  }
}
