import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSigner.sign()', () {
    test('Should [return SolanaSignature] representing proof of signing message with given private key', () {
      // Arrange
      Uint8List actualMessage = Uint8List.fromList(base64Decode(
          'AQACBB0D1AEIXs5Rz43yeayo7W0tSpSEF7kNTRVAVF4UGFj0UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAAPwED+D6bid8Qm8XNAPnvCc2lPDE9RQPiygKW4Pk3jYMDAwAJAwAtMQEAAAAAAwAFAu8BAAACAgABDAIAAAAAypo7AAAAAA=='));

      EDPrivateKey actualEdPrivateKey = EDPrivateKey.fromBytes(Uint8List.fromList(base64Decode('NgMOPT1ktg0VhawjCrTJkXT+27o7jzci+aN8Z80KsaY=')));

      ED25519PrivateKey actualEd25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: actualEdPrivateKey,
        metadata: Bip32KeyMetadata.fromCompressedPublicKey(compressedPublicKey: actualEdPrivateKey.edPublicKey.bytes),
      );

      SolanaSigner actualSolanaSigner = SolanaSigner(actualEd25519PrivateKey);

      // Act
      SolanaSignature actualSolanaSignature = actualSolanaSigner.sign(actualMessage);

      // Assert
      SolanaSignature expectedSolanaSignature = SolanaSignature(
          Uint8List.fromList(base64Decode('IjBdnh1Hp+g41m5oY/q6am1JLQGGip9zShFTG1QlHbsPGsDNEb4jJ3j30TWVH2F6VS3FZPbe2emJyiaNh7YuDA==')));

      expect(actualSolanaSignature, expectedSolanaSignature);
    });
  });
}
