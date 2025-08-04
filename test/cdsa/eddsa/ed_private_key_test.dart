import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EDPrivateKey.bytes getter', () {
    test('Should [return private key bytes] from EDPrivateKey', () {
      // Arrange
      EDPrivateKey actualEDPrivateKey = EDPrivateKey.fromBytes(base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M='));

      // Act
      Uint8List actualPrivateKeyBytes = actualEDPrivateKey.bytes;

      // Assert
      Uint8List expectedPrivateKeyBytes = base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M=');

      expect(actualPrivateKeyBytes, expectedPrivateKeyBytes);
    });
  });

  group('Tests of EDPrivateKey.edPublicKey getter', () {
    test('Should [return EDPublicKey] from ECPrivateKey', () {
      // Arrange
      EDPrivateKey actualEDPrivateKey = EDPrivateKey.fromBytes(base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M='));

      // Act
      EDPublicKey actualEDPublicKey = actualEDPrivateKey.edPublicKey;

      // Assert
      EDPublicKey expectedEDPublicKey = EDPublicKey(
        EDPoint(
          curve: Curves.ed25519,
          n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
          x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
          y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
          z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
          t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
        ),
      );

      expect(actualEDPublicKey, expectedEDPublicKey);
    });
  });

  group('Tests of EDPrivateKey.a getter', () {
    test('Should [return a (pruned private key)] from EDPrivateKey', () {
      // Arrange
      EDPrivateKey actualEDPrivateKey = EDPrivateKey.fromBytes(base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M='));

      // Act
      BigInt actualA = actualEDPrivateKey.a;

      // Assert
      BigInt expectedA = BigInt.parse('52296706698976945379478339393009008515096998632529786687805880390877129570304');

      expect(actualA, expectedA);
    });

    test('Should [throw Exception] if cofactor h is not 4 or 8', () {
      // Arrange
      EDPrivateKey actualEDPrivateKey = EDPrivateKey.fromBytes(
        base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M='),
        G: CurvePoints.generatorED25519.copyWith(
          curve: EDCurve(
            a: BigInt.from(-1),
            d: BigInt.parse('37095705934669439343138083508754565189542113879843219016388785533085940283555'),
            h: BigInt.zero,
            p: BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819949'),
          ),
        ),
      );

      // Act & Assert
      expect(() => actualEDPrivateKey.a, throwsException);
    });
  });
}
