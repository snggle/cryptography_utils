import 'dart:typed_data';

import 'package:crypto/crypto.dart';
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
        hashFunction: sha256,
        ecPrivateKey: actualECPrivateKey,
      ).sign(actualMessage);

      // Assert
      ECSignature expectedECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      expect(actualECSignature, expectedECSignature);
    });
  });

  group('Tests of ECDSASigner.verifySignature()', () {
    test('Should [return TRUE] if [signature VALID] for given private key (Secp256k1)', () {
      // Arrange
      Uint8List actualMessage = Uint8List.fromList('Hello world'.codeUnits);
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );
      ECPrivateKey actualECPrivateKey = ECPrivateKey(
        CurvePoints.generatorSecp256k1,
        BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
      );

      // Act
      bool actualSignatureValidBool = ECDSASigner(
        hashFunction: sha256,
        ecPrivateKey: actualECPrivateKey,
      ).verifySignature(actualMessage, actualECSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return FALSE] if [signature INVALID] for given private key (Secp256k1)', () {
      // Arrange
      Uint8List actualMessage = Uint8List.fromList('Hello world'.codeUnits);
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('102978385277191726159329221235853931845740505117174969823872713913281673197520'),
        s: BigInt.parse('473230762751246026821318165514853945171650154379161213745716102690305699328'),
      );
      ECPrivateKey actualECPrivateKey = ECPrivateKey(
        CurvePoints.generatorSecp256k1,
        BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
      );

      // Act
      bool actualSignatureValidBool = ECDSASigner(
        hashFunction: sha256,
        ecPrivateKey: actualECPrivateKey,
      ).verifySignature(actualMessage, actualECSignature);

      // Assert
      expect(actualSignatureValidBool, false);
    });
  });
}
