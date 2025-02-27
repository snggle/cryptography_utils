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
import 'dart:convert';

import 'package:cryptography_utils/src/hash/sha/hash/a_hash.dart';
import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/sha512/sha_512_sink.dart';

///[Sha512] configure the hash computation, defining a block size of 32 words (128 bytes), and provides a method for starting the chunked conversion process with a custom Sha512Sink.
class Sha512 extends AHash {
  static const int _bytesPerWord = 4;
  static final Sha512 _sha512 = Sha512._();

  factory Sha512() => _sha512;

  Sha512._();

  @override
  int get blockSize => 32 * _bytesPerWord;

  @override
  ByteConversionSink startChunkedConversion(Sink<Digest> sink) => ByteConversionSink.from(Sha512Sink(sink));
}
