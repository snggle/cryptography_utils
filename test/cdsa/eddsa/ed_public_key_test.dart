import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EDPublicKey.bytes getter', () {
    test('Should [return bytes] representing ECPublicKey', () {
      // Arrange
      EDPublicKey actualEDPublicKey = EDPublicKey(
        EDPoint(
          curve: Curves.ed25519,
          n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
          x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
          y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
          z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
          t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
        ),
      );

      // Act
      Uint8List actualBytes = actualEDPublicKey.bytes;

      // Assert
      Uint8List expectedBytes = base64Decode('z7Dbiwy9pzyyNc8VrMNqmdssCM0tlKxB9Yk8umwbYwc=');

      expect(actualBytes, expectedBytes);
    });
  });

  group('Tests of EDPublicKey.length getter', () {
    test('Should [return integer] representing length of EDPublicKey', () {
      // Arrange
      EDPublicKey actualEDPublicKey = EDPublicKey(
        EDPoint(
          curve: Curves.ed25519,
          n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
          x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
          y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
          z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
          t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
        ),
      );

      // Act
      int actualBaselen = actualEDPublicKey.length;

      // Assert
      int expectedBaselen = 32;

      expect(actualBaselen, expectedBaselen);
    });
  });
}
