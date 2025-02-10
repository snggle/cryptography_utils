//This class was primarily influenced by:
// crypto - Copyright 2015, the Dart project authors.
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

import 'package:cryptography_utils/src/hash/sha/hash/digest.dart';
import 'package:cryptography_utils/src/hash/sha/sha512/a_sha_64bit_sink.dart';

///[Sha512Sink] initializes the digest state with predefined constants and specifies that the digest length is 16 bytes.
class Sha512Sink extends ASha64BitSink {
  Sha512Sink(Sink<Digest> sink)
      : super(
          sink,
          Uint32List.fromList(<int>[
            0x6a09e667,
            0xf3bcc908,
            0xbb67ae85,
            0x84caa73b,
            0x3c6ef372,
            0xfe94f82b,
            0xa54ff53a,
            0x5f1d36f1,
            0x510e527f,
            0xade682d1,
            0x9b05688c,
            0x2b3e6c1f,
            0x1f83d9ab,
            0xfb41bd6b,
            0x5be0cd19,
            0x137e2179,
          ]),
        );
}
