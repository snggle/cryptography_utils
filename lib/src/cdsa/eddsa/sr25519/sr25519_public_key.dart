import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// [SR25519PublicKey] represents [EDPublicKey] constructed with specific Curve (SR25519) and chain code.
class SR25519PublicKey extends Equatable implements IBip32PublicKey {
  final Ristretto255Point P;

  const SR25519PublicKey(this.P);

  Uint8List get bytes {
    return P.toBytes();
  }

  @override
  List<Object?> get props => <Object?>[P];
}
