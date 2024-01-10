import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

abstract interface class IBip32PrivateKey {
  Uint8List get bytes;

  Uint8List get chainCode;

  int get length;

  IBip32PublicKey get publicKey;
}
