import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed25519_signer.dart';
import 'package:cryptography_utils/src/cdsa/eddsa/ed25519/signer/ed_signature.dart';
import 'package:test/test.dart';

void main() {
  ED25519Signer actualED25519Signer = ED25519Signer(
    hashFunction: sha512,
    privateKey: ED25519PrivateKey(
      metadata: Bip32KeyMetadata(
        depth: 5,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('2837893204'),
        parentFingerprint: BigInt.parse('162080603'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('bJz0NEJLEZUTTobbklJ8hYb9gCS+4J7UGPMtDyO+IDY='),
      ),
      edPrivateKey: EDPrivateKey.fromBytes(base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M=')),
    ),
  );

  group('Tests of Ed25519Signer.sign()', () {
    test('Should [return EDSignature] generated for given message', () {
      // Assert
      Uint8List actualMessage = utf8.encode('Hello, World!');

      // Act
      EDSignature actualSignature = actualED25519Signer.sign(actualMessage);

      // Assert
      EDSignature expectedSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('PzP+qMlZFKIuxxdoUKRtuHN22GtKwVuSdSHDZmjiowQ='),
      );

      expect(actualSignature, expectedSignature);
    });
  });

  group('Tests of Ed25519Signer.verifySignature()', () {
    test('Should [return TRUE] if [signature VALID] for given private key', () {
      // Arrange
      Uint8List actualMessage = utf8.encode('Hello, World!');
      EDSignature actualSignature = EDSignature(
        r: base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA='),
        s: base64Decode('PzP+qMlZFKIuxxdoUKRtuHN22GtKwVuSdSHDZmjiowQ='),
      );

      // Act
      bool actualSignatureValidBool = actualED25519Signer.verifySignature(actualMessage, actualSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return FALSE] if [signature INVALID] for given private key', () {
      // Arrange
      Uint8List actualMessage = utf8.encode('Hello, World!');
      EDSignature actualSignature = EDSignature(
        r: base64Decode('pQCXZYSu7MdCWso7jgZn9PG1Kx6eWfCP47Flf2GKYBg='),
        s: base64Decode('FdUwxjlNiVx6Kg1cTbH4w3cJlLGDKzTttd5bTzvXSgs='),
      );

      // Act
      bool actualSignatureValidBool = actualED25519Signer.verifySignature(actualMessage, actualSignature);

      // Assert
      expect(actualSignatureValidBool, false);
    });
  });
}
