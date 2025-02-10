import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ECDSASigner.sign()', () {
    test('Should [return ECSignature] generated for given message (Secp256k1)', () {
      // Arrange
      Uint8List actualMessage = Uint8List.fromList('Hello world'.codeUnits);
      ECPrivateKey actualECPrivateKey = ECPrivateKey(
        CurvePoints.generatorSecp256k1,
        BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
      );

      // Act
      ECSignature actualECSignature = ECDSASigner(
        hashFunction: Sha256(),
        ecPrivateKey: actualECPrivateKey,
      ).sign(actualMessage);

      // Assert
      ECSignature expectedECSignature = ECSignature(
        r: BigInt.parse('21165175836978812381665558937913198224702266563755240335786634922159270665737'),
        s: BigInt.parse('67243574932862348866046687334828474181280536427312945072404625477687067369325'),
        ecCurve: Curves.secp256k1,
      );

      expect(actualECSignature, expectedECSignature);
    });
  });
}
