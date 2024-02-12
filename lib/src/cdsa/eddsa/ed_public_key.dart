import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

class EDPublicKey extends Equatable {
  /// Represents the public key derived from the private key through the edwards curve point multiplication
  /// operation Q = dG, where `d`is the secret exponent (private key) and `G` is the generator point of the curve.
  final EDPoint A;

  const EDPublicKey(this.A);

  Uint8List get bytes {
    return A.toBytes();
  }

  int get length => (A.curve.p.bitLength + 8) ~/ 8;

  @override
  List<Object?> get props => <Object?>[A];
}
