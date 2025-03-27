import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/cipher/i_cipher_key.dart';
import 'package:cryptography_utils/src/utils/int32_utils.dart';
import 'package:equatable/equatable.dart';

/// Represents AES key.
/// Provides utility methods to access key length and column size for AES operations.
class AESKey extends Equatable implements ICipherKey {
  final Uint8List uint8List;

  const AESKey(this.uint8List);

  int get length => uint8List.length;

  int get columns => Int32Utils.shiftRight(length, 2);

  @override
  List<Object> get props => <Object>[uint8List];
}
