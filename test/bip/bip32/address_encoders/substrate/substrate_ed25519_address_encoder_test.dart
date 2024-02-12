import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  EDPoint actualPointA = EDPoint(
    curve: Curves.ed25519,
    n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
    x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
    y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
    z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
    t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
  );

  ED25519PublicKey actualPublicKey = ED25519PublicKey(
    metadata: Bip32KeyMetadata(
      depth: 0,
      fingerprint: BigInt.parse('1344436917'),
      parentFingerprint: BigInt.parse('0'),
      masterFingerprint: BigInt.parse('1344436917'),
    ),
    edPublicKey: EDPublicKey(actualPointA),
  );

  group('Tests of SubstrateED25519AddressEncoder.encodePublicKey()', () {
    test('Should [return Substrate address] for given public key', () {
      // Arrange
      SubstrateED25519AddressEncoder actualSubstrateED25519AddressEncoder = SubstrateED25519AddressEncoder(ss58Format: 0);

      // Act
      String actualAddress = actualSubstrateED25519AddressEncoder.encodePublicKey(actualPublicKey);

      // Assert
      String expectedAddress = '15hKT6AkcwKey5JZoxXg7yjkpxcZfSMbxjfisc1xEBh9WmiB';

      expect(actualAddress, expectedAddress);
    });
  });
}
