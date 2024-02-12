import 'package:cryptography_utils/cryptography_utils.dart';

class Curves {
  static ECCurve get secp256k1 {
    return ECCurve(
      a: BigInt.zero,
      b: BigInt.from(7),
      h: BigInt.one,
      p: BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007908834671663'),
    );
  }

  static EDCurve get ed25519 {
    return EDCurve(
      a: BigInt.from(-1),
      d: BigInt.parse('37095705934669439343138083508754565189542113879843219016388785533085940283555'),
      h: BigInt.from(8),
      p: BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819949'),
    );
  }
}
