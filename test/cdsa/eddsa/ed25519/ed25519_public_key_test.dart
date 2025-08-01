import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ED25519PublicKey.bytes getter', () {
    test('Should [return bytes] representing ED25519PublicKey', () {
      // Arrange
      ED25519PublicKey actualED25519PublicKey = ED25519PublicKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('bJz0NEJLEZUTTobbklJ8hYb9gCS+4J7UGPMtDyO+IDY='),
        ),
        edPublicKey: EDPublicKey(
          EDPoint(
            curve: Curves.ed25519,
            n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
            x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
            y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
            z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
            t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
          ),
        ),
      );

      // Act
      Uint8List actualCompressedPublicKey = actualED25519PublicKey.bytes;

      // Assert
      Uint8List expectedCompressedPublicKey = base64Decode('z7Dbiwy9pzyyNc8VrMNqmdssCM0tlKxB9Yk8umwbYwc=');

      expect(actualCompressedPublicKey, expectedCompressedPublicKey);
    });
  });

  group('Tests of ED25519PublicKey.length getter', () {
    test('Should [return integer] representing base length of ED25519PublicKey', () {
      // Arrange
      ED25519PublicKey actualED25519PublicKey = ED25519PublicKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('bJz0NEJLEZUTTobbklJ8hYb9gCS+4J7UGPMtDyO+IDY='),
        ),
        edPublicKey: EDPublicKey(
          EDPoint(
            curve: Curves.ed25519,
            n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
            x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
            y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
            z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
            t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
          ),
        ),
      );

      // Act
      int actualPublicKeyLength = actualED25519PublicKey.length;

      // Assert
      int expectedPublicKeyLength = 32;

      expect(actualPublicKeyLength, expectedPublicKeyLength);
    });
  });
}
