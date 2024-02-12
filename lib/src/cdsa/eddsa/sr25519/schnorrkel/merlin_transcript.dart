// Class was shaped by the influence of several key sources including:
// "merlin" Copyright (C) 2023 - Kawaljeet Singh
// https://github.com/justkawal/merlin
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
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

import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Manages the operations on transcripts for cryptographic protocols using Merlin.
///
/// [MerlinTranscript] utilizes the STROBE-based Merlin protocol for creating transcripts
/// in zero-knowledge proofs, streamlining the Fiat-Shamir transform to facilitate the
/// development of non-interactive protocols with the simplicity of interactive ones.
class MerlinTranscript {
  /// Specifies the version of the Merlin protocol being used
  static const String merlinVersion = 'Merlin v1.0';

  /// A proof-specific domain separation label that should uniquely identify the proof statement.
  static const String domainSeparatorLabel = 'dom-sep';

  late Strobe strobe;

  MerlinTranscript(String appLabel) {
    strobe = Strobe.initStrobe(merlinVersion, StrobeSecurityLevel.sec128);
    appendMessage(domainSeparatorLabel, utf8.encode(appLabel));
  }

  /// Appends the message to the transcript with the provided label.
  void appendMessage(String label, List<int> message) {
    Uint8List labelBytes = utf8.encode(label);
    Uint8List sizeBuffer = Uint8List(4);
    ByteData.view(sizeBuffer.buffer).setUint32(0, message.length, Endian.little);

    Uint8List labelSize = Uint8List.fromList(<int>[...labelBytes, ...sizeBuffer]);
    strobe
      ..authenticateAdditionalData(labelSize, metaBool: true)
      ..authenticateAdditionalData(message, metaBool: false);
  }

  /// Returns a buffer filled with the verifier's challenge bytes.
  /// The label parameter is metadata about the challenge, and is also appended to the transcript.
  Uint8List extractBytes(String label, int outLen) {
    Uint8List labelBytes = utf8.encode(label);
    Uint8List sizeBuffer = Uint8List(4);
    ByteData.view(sizeBuffer.buffer).setUint32(0, outLen, Endian.little);

    Uint8List labelSize = Uint8List.fromList(<int>[...labelBytes, ...sizeBuffer]);
    strobe.authenticateAdditionalData(labelSize, metaBool: true);

    return strobe.prf(outLen);
  }
}
