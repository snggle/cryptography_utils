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
}
