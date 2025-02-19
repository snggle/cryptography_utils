// Class was shaped by the influence of several key sources including:
// "blockchain_utils" - Copyright (c) 2010 Mohsen
// https://github.com/mrtnetwork/blockchain_utils/.
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

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/hash/sha/hash/a_hash.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:cryptography_utils/src/utils/bytes_utils.dart';

/// The `RFC6979` class implements the deterministic generation of the ephemeral key 'k' for ECDSA signatures as outlined in RFC 6979.
/// https://www.rfc-editor.org/rfc/rfc6979.html#section-3.2
class RFC6979 {
  late final AHash _hashFunction;
  late final int _hLen;

  late final List<int> _m;
  late final BigInt _n;
  late final BigInt _d;

  late List<int> _hmacK;
  late List<int> _hmacV;

  RFC6979({
    /// RFC6979 message parameter
    required List<int> m,

    /// RFC6979 point order parameter
    required BigInt n,

    /// RFC6979 secretExponent (privateKey) parameter
    required BigInt d,

    /// RFC6979 H parameter
    required AHash hashFunction,
  }) {
    _m = m;
    _n = n;
    _d = d;

    _hashFunction = hashFunction;
    _hLen = _hashFunction.blockSize ~/ 2;

    _hmacK = List<int>.filled(_hLen, 0);
    _hmacV = List<int>.filled(_hLen, 0);

    _init();
  }

  /// Generates a deterministic ephemeral key `k` using the RFC 6979 algorithm.
  BigInt generateNextK() {
    int tLength = (_n.bitLength + 7) ~/ 8;
    Uint8List t = Uint8List.fromList(List<int>.empty());

    while (true) {
      while (t.length < tLength) {
        _hmacV = HMAC(hash: _hashFunction, key: _hmacK).process(_hmacV);
        t = Uint8List.fromList(<int>[...t, ..._hmacV]);
      }

      BigInt secret = BigIntUtils.decode(t, bitLength: _n.bitLength);
      if (secret >= BigInt.one && secret < _n) {
        return secret;
      } else {
        _hmacK = HMAC(hash: _hashFunction, key: _hmacK).process(List<int>.from(<int>[..._hmacV, 0x00]));
        _hmacV = HMAC(hash: _hashFunction, key: _hmacK).process(List<int>.from(<int>[..._hmacV, 0x00]));
      }
    }
  }

  void _init() {
    _hmacK.fillRange(0, _hLen, 0x00);
    _hmacV.fillRange(0, _hLen, 0x01);

    Uint8List entropy = BigIntUtils.changeToBytes(_d, length: BigIntUtils.calculateByteLength(_n));
    Uint8List nonce = BytesUtils.changeToOctetsWithOrderPadding(_m, _n);

    List<List<int>> bx = <List<int>>[entropy, nonce, <int>[]];

    _hmacK = HMAC(hash: _hashFunction, key: _hmacK).processChunks(<List<int>>[
      <int>[..._hmacV, 0x00],
      ...bx
    ]);
    _hmacV = HMAC(hash: _hashFunction, key: _hmacK).process(_hmacV);

    _hmacK = HMAC(hash: _hashFunction, key: _hmacK).processChunks(<List<int>>[
      <int>[..._hmacV, 0x01],
      ...bx
    ]);
    _hmacV = HMAC(hash: _hashFunction, key: _hmacK).process(_hmacV);
  }
}
