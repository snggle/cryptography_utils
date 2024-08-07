import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Bip32KeyMetadata.fromCompressedPublicKey() constructor', () {
    test('Should [return Bip32KeyMetadata] with fingerprint if only public key provided', () {
      // Arrange
      Uint8List actualCompressedPublicKey = base64Decode('Ar+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2Yj');

      // Act
      Bip32KeyMetadata actualBip32KeyMetadata = Bip32KeyMetadata.fromCompressedPublicKey(compressedPublicKey: actualCompressedPublicKey);

      // Assert
      Bip32KeyMetadata expectedBip32KeyMetadata = Bip32KeyMetadata(fingerprint: BigInt.parse('83580899'));

      expect(actualBip32KeyMetadata, expectedBip32KeyMetadata);
    });

    test('Should [return FILLED Bip32KeyMetadata] if all values provided', () {
      // Arrange
      Uint8List actualCompressedPublicKey = base64Decode('Ar+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2Yj');

      // Act
      Bip32KeyMetadata actualBip32KeyMetadata = Bip32KeyMetadata.fromCompressedPublicKey(
        compressedPublicKey: actualCompressedPublicKey,
        depth: 0,
        parentFingerprint: BigInt.parse('0'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
      );

      // Assert
      Bip32KeyMetadata expectedBip32KeyMetadata = Bip32KeyMetadata(
        fingerprint: BigInt.parse('83580899'),
        depth: 0,
        parentFingerprint: BigInt.parse('0'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('UNH2aBl1uMkP+S/i5vZVK8tC2uODdICFW0hrpY8Zrbk='),
      );

      expect(actualBip32KeyMetadata, expectedBip32KeyMetadata);
    });
  });

  group('Tests of Bip32KeyMetadata.deriveNext()', () {
    test('Should [return Bip32KeyMetadata] for the next derived public key', () {
      // Arrange
      Bip32KeyMetadata actualBip32KeyMetadata = Bip32KeyMetadata(
        depth: 3,
        shiftedIndex: 2147483648,
        chainCode: base64Decode('5gvokyLRAipECLgT5AnkPLX6thREo+E27t5wUBpna9w='),
        fingerprint: BigInt.parse('2583323534'),
        parentFingerprint: BigInt.parse('2923058245'),
        masterFingerprint: BigInt.parse('83580899'),
      );

      // Act
      Bip32KeyMetadata actualNextBip32KeyMetadata = actualBip32KeyMetadata.deriveNext(
        newChainCode: base64Decode('FK0bd1Z1KEZpXlZ45+GufE0HsweNVoh7EkZndgnxmVA='),
        newCompressedPublicKey: base64Decode('A4O/mtYg93+ocKaEonuS/GMTWAWEy2jkBPAFtAmu1h8X'),
        newShiftedIndex: 0,
      );

      // Assert
      Bip32KeyMetadata expectedNextBip32KeyMetadata = Bip32KeyMetadata(
        depth: 4,
        shiftedIndex: 0,
        chainCode: base64Decode('FK0bd1Z1KEZpXlZ45+GufE0HsweNVoh7EkZndgnxmVA='),
        fingerprint: BigInt.parse('162080603'),
        parentFingerprint: BigInt.parse('2583323534'),
        masterFingerprint: BigInt.parse('83580899'),
      );

      expect(actualNextBip32KeyMetadata, expectedNextBip32KeyMetadata);
    });
  });

  group('Tests of Bip32KeyMetadata.canBuildExtendedKey getter', () {
    test('Should [return TRUE] if Bip32KeyMetadata [contains all parameters] required to build extended key', () {
      // Arrange
      Bip32KeyMetadata actualBip32KeyMetadata = Bip32KeyMetadata(
        depth: 4,
        shiftedIndex: 0,
        chainCode: base64Decode('FK0bd1Z1KEZpXlZ45+GufE0HsweNVoh7EkZndgnxmVA='),
        fingerprint: BigInt.parse('162080603'),
        parentFingerprint: BigInt.parse('2583323534'),
        masterFingerprint: BigInt.parse('83580899'),
      );

      // Assert
      expect(actualBip32KeyMetadata.canBuildExtendedKey, true);
    });

    test('Should [return FALSE] if Bip32KeyMetadata has [depth missing]', () {
      // Arrange
      Bip32KeyMetadata actualBip32KeyMetadata = Bip32KeyMetadata(
        shiftedIndex: 0,
        chainCode: base64Decode('FK0bd1Z1KEZpXlZ45+GufE0HsweNVoh7EkZndgnxmVA='),
        fingerprint: BigInt.parse('162080603'),
        parentFingerprint: BigInt.parse('2583323534'),
        masterFingerprint: BigInt.parse('83580899'),
      );

      // Assert
      expect(actualBip32KeyMetadata.canBuildExtendedKey, false);
    });

    test('Should [return FALSE] if Bip32KeyMetadata has [parentFingerprint missing]', () {
      // Arrange
      Bip32KeyMetadata actualBip32KeyMetadata = Bip32KeyMetadata(
        depth: 4,
        shiftedIndex: 0,
        chainCode: base64Decode('FK0bd1Z1KEZpXlZ45+GufE0HsweNVoh7EkZndgnxmVA='),
        fingerprint: BigInt.parse('162080603'),
        masterFingerprint: BigInt.parse('83580899'),
      );

      // Assert
      expect(actualBip32KeyMetadata.canBuildExtendedKey, false);
    });

    test('Should [return FALSE] if Bip32KeyMetadata has [chainCode missing]', () {
      // Arrange
      Bip32KeyMetadata actualBip32KeyMetadata = Bip32KeyMetadata(
        depth: 4,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('162080603'),
        parentFingerprint: BigInt.parse('2583323534'),
        masterFingerprint: BigInt.parse('83580899'),
      );

      // Assert
      expect(actualBip32KeyMetadata.canBuildExtendedKey, false);
    });

    test('Should [return FALSE] if Bip32KeyMetadata has [shiftedIndex missing]', () {
      // Arrange
      Bip32KeyMetadata actualBip32KeyMetadata = Bip32KeyMetadata(
        depth: 4,
        chainCode: base64Decode('FK0bd1Z1KEZpXlZ45+GufE0HsweNVoh7EkZndgnxmVA='),
        fingerprint: BigInt.parse('162080603'),
        parentFingerprint: BigInt.parse('2583323534'),
        masterFingerprint: BigInt.parse('83580899'),
      );

      // Assert
      expect(actualBip32KeyMetadata.canBuildExtendedKey, false);
    });
  });
}
