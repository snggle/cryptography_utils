import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed25519_verifier.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';
import 'package:test/test.dart';

void main() {
  ED25519Verifier actualED25519Verifier = ED25519Verifier(
    hashFunction: Sha512(),
    publicKey: ED25519PublicKey(
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
    ),
  );

  group('Tests of ED25519Verifier.isSignatureValid()', () {
    test('Should [return TRUE] if [signature VALID] for given public key', () {
      // Arrange
      Uint8List actualMessage = utf8.encode('Hello, World!');
      EDSignature actualSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('PzP+qMlZFKIuxxdoUKRtuHN22GtKwVuSdSHDZmjiowQ='),
      );

      // Act
      bool actualSignatureValidBool = actualED25519Verifier.isSignatureValid(actualMessage, actualSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return FALSE] if [signature INVALID] for given public key', () {
      // Arrange
      Uint8List actualMessage = utf8.encode('Hello, World!');
      EDSignature actualSignature = EDSignature(
        r: base64Decode('pQCXZYSu7MdCWso7jgZn9PG1Kx6eWfCP47Flf2GKYBg='),
        s: base64Decode('FdUwxjlNiVx6Kg1cTbH4w3cJlLGDKzTttd5bTzvXSgs='),
      );

      // Act
      bool actualSignatureValidBool = actualED25519Verifier.isSignatureValid(actualMessage, actualSignature);

      // Assert
      expect(actualSignatureValidBool, false);
    });

    test('Should [throw Exception] if [signature INCORRECT] [signature S > G.n]', () {
      // Arrange
      Uint8List actualMessage = utf8.encode('Hello, World!');
      EDSignature actualSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('7237005577332262213973186563042994240857116359379907606001950938285454250989'), // S >= G.n
      );

      // Act & Assert
      expect(
        () => actualED25519Verifier.isSignatureValid(actualMessage, actualSignature),
        throwsException,
      );
    });

    test('Should [throw Exception] if [signature INCORRECT] [signature S == G.n]', () {
      // Arrange
      Uint8List actualMessage = utf8.encode('Hello, World!');
      EDSignature actualSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('EAAAAAAAAAAAAAAAAAAAABTe+d6i95zWWBJjGlz10+0='),
      );

      // Act & Assert
      expect(
        () => actualED25519Verifier.isSignatureValid(actualMessage, actualSignature),
        throwsException,
      );
    });
  });
}
