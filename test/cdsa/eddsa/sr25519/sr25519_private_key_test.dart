import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SR25519PrivateKey.fromEDPrivateKey() constructor', () {
    test('Should [return SR25519PrivateKey] from given EDPrivateKey', () {
      // Arrange
      EDPrivateKey actualEDPrivateKey = EDPrivateKey.fromBytes(base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M='));

      // Act
      SR25519PrivateKey actualSR255PrivateKey = SR25519PrivateKey.fromEDPrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
        ),
        edPrivateKey: actualEDPrivateKey,
      );

      // Assert
      SR25519PrivateKey expectedSR255PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
        ),
        key: base64Decode('AC+0Q4DPAfJVtbtNxX84es5jHSOlm11JFYKIr2Lccw4='),
        nonce: base64Decode('/kqSVuDYna+X/taZvBbltOgqYuJ5vMkb0LVEZwBu+pQ='),
      );

      expect(actualSR255PrivateKey, expectedSR255PrivateKey);
    });
  });

  group('Tests of SR25519PrivateKey.bytes getter', () {
    test('Should [return private key as bytes] from SR25519PrivateKey', () {
      // Arrange
      SR25519PrivateKey actualSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
        ),
        key: base64Decode('EPLvbSTOy3rzR5tbOqqTXGsqUHjlWB9fApOL8SKQCQg='),
        nonce: base64Decode('yV/iXXPhFCrXCFHBDGSI2JHMOxZ90M9pCu2FmQZJ8U4='),
      );

      // Act
      Uint8List actualBytes = actualSR25519PrivateKey.bytes;

      // Assert
      Uint8List expectedBytes = base64Decode('EPLvbSTOy3rzR5tbOqqTXGsqUHjlWB9fApOL8SKQCQg=');

      expect(actualBytes, expectedBytes);
    });
  });

  group('Tests of SR25519PrivateKey.metadata getter', () {
    test('Should [return chain code bytes] from SR25519PrivateKey', () {
      // Arrange
      SR25519PrivateKey actualSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
        ),
        key: base64Decode('EPLvbSTOy3rzR5tbOqqTXGsqUHjlWB9fApOL8SKQCQg='),
        nonce: base64Decode('yV/iXXPhFCrXCFHBDGSI2JHMOxZ90M9pCu2FmQZJ8U4='),
      );

      // Act
      Bip32KeyMetadata actualBip32KeyMetadata = actualSR25519PrivateKey.metadata;

      // Assert
      Bip32KeyMetadata expectedBip32KeyMetadata = Bip32KeyMetadata(
        depth: 5,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('2837893204'),
        parentFingerprint: BigInt.parse('162080603'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
      );

      expect(actualBip32KeyMetadata, expectedBip32KeyMetadata);
    });
  });

  group('Tests of SR25519PrivateKey.length getter', () {
    test('Should [return length of private key] from SR25519PrivateKey', () {
      // Arrange
      SR25519PrivateKey actualSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
        ),
        key: base64Decode('EPLvbSTOy3rzR5tbOqqTXGsqUHjlWB9fApOL8SKQCQg='),
        nonce: base64Decode('yV/iXXPhFCrXCFHBDGSI2JHMOxZ90M9pCu2FmQZJ8U4='),
      );

      // Act
      int actualLength = actualSR25519PrivateKey.length;

      // Assert
      int expectedLength = 32;

      expect(actualLength, expectedLength);
    });
  });

  group('Tests of SR25519PrivateKey.publicKey getter', () {
    test('Should [return ED25519PublicKey] constructed from SR25519PrivateKey', () {
      // Arrange
      SR25519PrivateKey actualSR25519PrivateKey = SR25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
        ),
        key: base64Decode('EPLvbSTOy3rzR5tbOqqTXGsqUHjlWB9fApOL8SKQCQg='),
        nonce: base64Decode('yV/iXXPhFCrXCFHBDGSI2JHMOxZ90M9pCu2FmQZJ8U4='),
      );

      // Act
      SR25519PublicKey actualPublicKey = actualSR25519PrivateKey.publicKey;

      // Assert
      SR25519PublicKey expectedPublicKey = SR25519PublicKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
        ),
        P: Ristretto255Point(
          curve: Curves.ed25519,
          n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
          x: BigInt.parse('57647807138731086854719147428534364527408973440674997323586474929486297215498'),
          y: BigInt.parse('56928488956129998624248973747159938508280141385422357433380193442735588740711'),
          z: BigInt.parse('39660975461929599524771975860800330231663739857778634655603332803029162849118'),
          t: BigInt.parse('29393175147761522875492033973189436752932002509214848438040941757352914404314'),
        ),
      );

      expect(actualPublicKey, expectedPublicKey);
    });
  });
}
