// Portions of this file are based on dart-otp:
// https://github.com/daegalus/dart-otp
//
// dart-otp is licensed under the MIT License.
// Copyright (c) 2012 Yulian Kuncheff
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/src/hash/hmac.dart';
import 'package:cryptography_utils/src/hash/sha/sha1/sha1.dart';

/// Time-based One-Time Password generator with default parameters.
class TOTP {
  static const int _timePeriodSeconds = 30;
  static const int _totpDigits = 6;
  static const int _totpModulo = 1000000;

  /// Generates a 6-digit TOTP using SHA-1 from a Base32-encoded secret with the default 30-second period.
  static String generate(String secret, {DateTime? timestamp}) {
    Uint8List secretBytes = Base32Decoder.decode(secret);
    DateTime currentTimestamp = timestamp ?? DateTime.now();
    int secondsSinceEpoch = currentTimestamp.millisecondsSinceEpoch ~/ 1000;
    int totpCodeTimeWindow = secondsSinceEpoch ~/ _timePeriodSeconds;

    Uint8List hmacDigestBytes = HMAC(key: secretBytes, hash: Sha1()).process(_convertTimeToBytes(totpCodeTimeWindow));
    int totpCode = _truncate(hmacDigestBytes) % _totpModulo;

    return totpCode.toString().padLeft(_totpDigits, '0');
  }

  /// Converts the moving time counter value into an 8-byte array.
  static Uint8List _convertTimeToBytes(int timeWindow) {
    ByteData byteData = ByteData(8)
    ..setUint64(0, timeWindow, Endian.big);

    return byteData.buffer.asUint8List();
  }

  /// Applies dynamic truncation to an HMAC digest and returns the code.
  static int _truncate(Uint8List hmacDigest) {
    int offset = hmacDigest[hmacDigest.length - 1] & 0x0f;

    return ((hmacDigest[offset] & 0x7f) << 24) |
        ((hmacDigest[offset + 1] & 0xff) << 16) |
        ((hmacDigest[offset + 2] & 0xff) << 8) |
        (hmacDigest[offset + 3] & 0xff);
  }
}
