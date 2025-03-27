import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/cipher/i_cipher_key.dart';
import 'package:equatable/equatable.dart';

/// A container class that combines a cipher key and its associated IV (initialization vector).
class CipherKeyWithIV<T extends ICipherKey> extends Equatable {
  final Uint8List ivUint8List;
  final T cipherKey;

  const CipherKeyWithIV(this.cipherKey, this.ivUint8List);

  @override
  List<Object> get props => <Object>[ivUint8List, cipherKey];
}
