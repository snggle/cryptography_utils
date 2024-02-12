import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SR25519PublicKey.bytes getter', () {
    test('Should [return bytes] representing SR25519PublicKey', () {
      // Arrange
      SR25519PublicKey actualSR25519PublicKey = SR25519PublicKey(
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

      // Act
      Uint8List actualCompressedPublicKey = actualSR25519PublicKey.bytes;

      // Assert
      Uint8List expectedCompressedPublicKey = base64Decode('Yu3MC3iNPw65pivW5BFGGMl1YDkQ0nVhB8lzrsC+Z3Y=');

      expect(actualCompressedPublicKey, expectedCompressedPublicKey);
    });
  });
}
