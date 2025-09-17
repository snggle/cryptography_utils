import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ED25519PrivateKey.bytes getter', () {
    test('Should [return private key as bytes] from ED25519PrivateKey', () {
      // Arrange
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('bJz0NEJLEZUTTobbklJ8hYb9gCS+4J7UGPMtDyO+IDY='),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M=')),
      );

      // Act
      Uint8List actualPrivateKeyBytes = actualED25519PrivateKey.bytes;

      // Assert
      Uint8List expectedPrivateKeyBytes = base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M=');

      expect(actualPrivateKeyBytes, expectedPrivateKeyBytes);
    });
  });

  group('Tests of ED25519PrivateKey.metadata getter', () {
    test('Should [return Bip32KeyMetadata] from ED25519PrivateKey', () {
      // Arrange
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('bJz0NEJLEZUTTobbklJ8hYb9gCS+4J7UGPMtDyO+IDY='),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M=')),
      );

      // Act
      Bip32KeyMetadata actualBip32KeyMetadata = actualED25519PrivateKey.metadata;

      // Assert
      Bip32KeyMetadata expectedBip32KeyMetadata = Bip32KeyMetadata(
        depth: 5,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('2837893204'),
        parentFingerprint: BigInt.parse('162080603'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('bJz0NEJLEZUTTobbklJ8hYb9gCS+4J7UGPMtDyO+IDY='),
      );

      expect(actualBip32KeyMetadata, expectedBip32KeyMetadata);
    });
  });

  group('Tests of ED25519PrivateKey.length getter', () {
    test('Should [return length of private key] from ED25519PrivateKey', () {
      // Arrange
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('bJz0NEJLEZUTTobbklJ8hYb9gCS+4J7UGPMtDyO+IDY='),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M=')),
      );

      // Act
      int actualPrivateKeyLength = actualED25519PrivateKey.length;

      // Assert
      int expectedPrivateKeyLength = 32;

      expect(actualPrivateKeyLength, expectedPrivateKeyLength);
    });
  });

  group('Tests of ED25519PrivateKey.publicKey getter', () {
    test('Should [return ED25519PublicKey] constructed from ED25519PrivateKey', () {
      // Arrange
      ED25519PrivateKey actualED25519PrivateKey = ED25519PrivateKey(
        metadata: Bip32KeyMetadata(
          depth: 5,
          shiftedIndex: 0,
          fingerprint: BigInt.parse('2837893204'),
          parentFingerprint: BigInt.parse('162080603'),
          masterFingerprint: BigInt.parse('83580899'),
          chainCode: base64Decode('bJz0NEJLEZUTTobbklJ8hYb9gCS+4J7UGPMtDyO+IDY='),
        ),
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('iGjr84MoC1+WAY4cnAFqETc5KjMEtZ7CfAYvxkd877M=')),
      );

      // Act
      ED25519PublicKey actualED25519PublicKey = actualED25519PrivateKey.publicKey;

      // Assert
      ED25519PublicKey expectedED25519PublicKey = ED25519PublicKey(
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
            x: BigInt.parse('54065565874754690464541746979170565753169877194888053393545030920551520745988'),
            y: BigInt.parse('3341297077934518673457142734077350879420471371059900657313532910747302736079'),
            z: BigInt.parse('1'),
            t: BigInt.parse('17889545404307743854678190178496636156195764849150499252736625982701909100111'),
          ),
        ),
      );

      expect(actualED25519PublicKey, expectedED25519PublicKey);
    });
  });
}
