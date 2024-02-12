import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  SR25519PrivateKey masterPrivateKey = SR25519PrivateKey(
    key: base64Decode('T638LP9QwSABfXnIrVRkHXSCek2xdRS6f1du8wh9Yg4='),
    nonce: base64Decode('AjJ9pd0Ezkd5gi97vKZ/fvnxkclieRO/jBDHjnao77g='),
    metadata: Bip32KeyMetadata(
      depth: 5,
      fingerprint: BigInt.parse('2837893204'),
      parentFingerprint: BigInt.parse('162080603'),
      masterFingerprint: BigInt.parse('83580899'),
    ),
  );

  SR25519PrivateKey derivedPrivateKey = SR25519PrivateKey(
    key: base64Decode('EPLvbSTOy3rzR5tbOqqTXGsqUHjlWB9fApOL8SKQCQg='),
    nonce: base64Decode('yV/iXXPhFCrXCFHBDGSI2JHMOxZ90M9pCu2FmQZJ8U4='),
    metadata: Bip32KeyMetadata(
      depth: 5,
      shiftedIndex: 0,
      fingerprint: BigInt.parse('2837893204'),
      parentFingerprint: BigInt.parse('162080603'),
      masterFingerprint: BigInt.parse('83580899'),
      chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
    ),
  );

  group('Tests of SR25519Signer.sign()', () {
    test('Should [return SRSignature] generated for given message (master private key)', () {
      // Assert
      SR25519Signer actualSR25519Signer = SR25519Signer(privateKey: masterPrivateKey);
      Uint8List actualMessage = utf8.encode('Hello, World!');

      // Act
      SRSignature actualSignature = actualSR25519Signer.sign(actualMessage, nonce: Uint8List(64));

      // Assert
      SRSignature expectedSignature = SRSignature(
        r: base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='),
        s: base64Decode('vbz+ZJFmFpkDZaRHBJsj3ztGKq3hDrD4JURTsQQfVQA='),
      );

      expect(actualSignature, expectedSignature);
    });

    test('Should [return SRSignature] generated for given message (derived private key)', () {
      // Assert
      SR25519Signer actualSR25519Signer = SR25519Signer(privateKey: derivedPrivateKey);
      Uint8List actualMessage = utf8.encode('Hello, World!');

      // Act
      SRSignature actualSignature = actualSR25519Signer.sign(actualMessage, nonce: Uint8List(64));

      // Assert
      SRSignature expectedSignature = SRSignature(
        r: base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='),
        s: base64Decode('ou2ogEq3En+fZ57AWIMqzH1CUc3OHhTAFhGe0eGOxws='),
      );

      expect(actualSignature, expectedSignature);
    });
  });

  group('Tests of SR25519Signer.verifySignature()', () {
    test('Should [return TRUE] if [signature VALID] for given private key (master private key)', () {
      // Arrange
      SR25519Signer actualSR25519Signer = SR25519Signer(privateKey: masterPrivateKey);

      Uint8List actualMessage = utf8.encode('Hello, World!');
      SRSignature actualSignature = SRSignature(
        r: base64Decode('lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQno='),
        s: base64Decode('74tBmKoL1acVI7HBsXac/nYMnRzQTEmzEBYCQFiFRAQ='),
      );

      // Act
      bool actualSignatureValidBool = actualSR25519Signer.verifySignature(actualMessage, actualSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return TRUE] if [signature VALID] for given private key (derived private key)', () {
      // Arrange
      SR25519Signer actualSR25519Signer = SR25519Signer(privateKey: derivedPrivateKey);

      Uint8List actualMessage = utf8.encode('Hello, World!');
      SRSignature actualSignature = SRSignature(
        r: base64Decode('eBWqM4eYJSNTbeaAK4IEysxJt7DJeMlopNHcICapwxQ='),
        s: base64Decode('hqOxdg51mKyM60/z/sf6Li64JluWbGx1c7MTzeRaygc='),
      );

      // Act
      bool actualSignatureValidBool = actualSR25519Signer.verifySignature(actualMessage, actualSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return FALSE] if [signature INVALID] for given private key (master private key)', () {
      // Arrange
      SR25519Signer actualSR25519Signer = SR25519Signer(privateKey: masterPrivateKey);

      Uint8List actualMessage = utf8.encode('Hello, World!');
      SRSignature actualSignature = SRSignature(
        r: base64Decode('pQCXZYSu7MdCWso7jgZn9PG1Kx6eWfCP47Flf2GKYBg='),
        s: base64Decode('FdUwxjlNiVx6Kg1cTbH4w3cJlLGDKzTttd5bTzvXSgs='),
      );

      // Act
      bool actualSignatureValidBool = actualSR25519Signer.verifySignature(actualMessage, actualSignature);

      // Assert
      expect(actualSignatureValidBool, false);
    });

    test('Should [return FALSE] if [signature INVALID] for given private key (derived private key)', () {
      // Arrange
      SR25519Signer actualSR25519Signer = SR25519Signer(privateKey: masterPrivateKey);

      Uint8List actualMessage = utf8.encode('Hello, World!');
      SRSignature actualSignature = SRSignature(
        r: base64Decode('pQCXZYSu7MdCWso7jgZn9PG1Kx6eWfCP47Flf2GKYBg='),
        s: base64Decode('FdUwxjlNiVx6Kg1cTbH4w3cJlLGDKzTttd5bTzvXSgs='),
      );

      // Act
      bool actualSignatureValidBool = actualSR25519Signer.verifySignature(actualMessage, actualSignature);

      // Assert
      expect(actualSignatureValidBool, false);
    });
  });
}
