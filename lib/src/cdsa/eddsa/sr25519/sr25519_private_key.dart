import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:cryptography_utils/src/utils/ristretto255_utils.dart';

/// [SR25519PrivateKey] represents [EDPrivateKey] constructed with specific Curve (SR25519) and chain code.
class SR25519PrivateKey extends ABip32PrivateKey {
  final Uint8List key;
  final Uint8List nonce;

  SR25519PrivateKey({
    required super.metadata,
    required this.key,
    Uint8List? nonce,
  }) : nonce = nonce ?? Uint8List(0);

  factory SR25519PrivateKey.fromEDPrivateKey({required EDPrivateKey edPrivateKey, required Bip32KeyMetadata metadata}) {
    List<int> h = sha512
        .convert(edPrivateKey.bytes)
        .bytes;
    List<int> a = h.sublist(0, 32);
    a[0] &= 248;
    a[31] &= 63;
    a[31] |= 64;
    a.setAll(0, Ristretto255Utils.divideScalarByCofactor(a));

    return SR25519PrivateKey(
      key: Uint8List.fromList(a),
      nonce: Uint8List.fromList(h.sublist(32, 64)),
      metadata: metadata,
    );
  }

  SR25519PrivateKey copyWith({
    Bip32KeyMetadata? metadata,
    Uint8List? key,
    Uint8List? nonce,
  }) {
    return SR25519PrivateKey(
      metadata: metadata ?? this.metadata,
      key: key ?? this.key,
      nonce: nonce ?? this.nonce,
    );
  }

  @override
  Uint8List get bytes {
    return Uint8List.fromList(key);
  }

  @override
  int get length => key.length;

  @override
  SR25519PublicKey get publicKey {
    BigInt s = BigIntUtils.decode(key, order: Endian.little);
    EDPoint gn = CurvePoints.generatorED25519 * s;
    Ristretto255Point e = Ristretto255Point.fromEDPoint(gn);
    return SR25519PublicKey(P: e, metadata: metadata);
  }

  @override
  List<Object?> get props => <Object>[key, metadata];
}
