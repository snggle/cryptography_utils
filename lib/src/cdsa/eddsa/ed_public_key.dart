import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

class EDPublicKey extends Equatable {
  /// Public key point
  final EDPoint A;

  const EDPublicKey(this.A);

  Uint8List get bytes {
    return A.toBytes();
  }

  int get length => (A.curve.p.bitLength + 8) ~/ 8;

  @override
  List<Object?> get props => <Object?>[A];
}
