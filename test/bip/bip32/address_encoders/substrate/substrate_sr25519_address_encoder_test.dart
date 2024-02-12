import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  Ristretto255Point actualPointP = Ristretto255Point(
    curve: Curves.ed25519,
    n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
    x: BigInt.parse('57647807138731086854719147428534364527408973440674997323586474929486297215498'),
    y: BigInt.parse('56928488956129998624248973747159938508280141385422357433380193442735588740711'),
    z: BigInt.parse('39660975461929599524771975860800330231663739857778634655603332803029162849118'),
    t: BigInt.parse('29393175147761522875492033973189436752932002509214848438040941757352914404314'),
  );

  SR25519PublicKey actualPublicKey = SR25519PublicKey(
    metadata: Bip32KeyMetadata(
      depth: 0,
      fingerprint: BigInt.parse('1344436917'),
      parentFingerprint: BigInt.parse('0'),
      masterFingerprint: BigInt.parse('1344436917'),
    ),
    P: actualPointP,
  );

  group('Tests of SubstrateSR25519AddressEncoder.encodePublicKey()', () {
    test('Should [return Substrate address] for given public key', () {
      // Arrange
      SubstrateSR25519AddressEncoder actualSubstrateSR25519AddressEncoder = SubstrateSR25519AddressEncoder(ss58Format: 0);

      // Act
      String actualAddress = actualSubstrateSR25519AddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = '13EiLKpSaWLZVXKPuh8Fjkzph9urbir695R8qgWE6XHYtCvt';

      expect(actualAddress, expectedAddress);
    });
  });
}
