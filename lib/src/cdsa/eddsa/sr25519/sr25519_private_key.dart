import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// [SR25519PrivateKey] represents [EDPrivateKey] constructed with specific Curve (SR25519) and chain code.
class SR25519PrivateKey extends Equatable implements IBip32PrivateKey {
  final Uint8List key;
  final Uint8List nonce;
  final Uint8List _chainCode;

  SR25519PrivateKey({
    required this.key,
    Uint8List? nonce,
    Uint8List? chainCode,
  })  : nonce = nonce ?? Uint8List(0),
        _chainCode = chainCode ?? Uint8List(0);

  factory SR25519PrivateKey.fromEDPrivateKey(EDPrivateKey edPrivateKey, {Uint8List? chainCode}) {
    List<int> h = sha512.convert(edPrivateKey.bytes).bytes;
    List<int> a = h.sublist(0, 32);
    a[0] &= 248;
    a[31] &= 63;
    a[31] |= 64;
    a.setAll(0, Ristretto255Utils.divideScalarByCofactor(a));

    return SR25519PrivateKey(
      key: Uint8List.fromList(a),
      nonce: Uint8List.fromList(h.sublist(32, 64)),
      chainCode: chainCode,
    );
  }

  @override
  Uint8List get bytes {
    return Uint8List.fromList(key);
  }

  @override
  Uint8List get chainCode => _chainCode;

  @override
  int get length => key.length;

  @override
  SR25519PublicKey get publicKey {
    BigInt s = BigIntUtils.decode(key, order: Endian.little);
    EDPoint gn = CurvePoints.generatorED25519 * s;
    Ristretto255Point e = Ristretto255Point.fromEDPoint(gn);
    return SR25519PublicKey(e);
  }

  @override
  List<Object?> get props => <Object>[key, chainCode];
}
