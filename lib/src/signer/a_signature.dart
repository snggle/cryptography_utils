import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ASignature extends Equatable {
  const ASignature();

  /// Returns signature as bytes
  Uint8List get bytes;

  /// Returns signature as base64 string
  String get base64 => base64Encode(bytes);

  /// Returns signature as hex string
  String get hex => HexCodec.encode(bytes, includePrefixBool: true);

  /// Returns signature length
  int get length => bytes.length;
}
