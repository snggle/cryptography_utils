import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaSigner.sign()', () {
    test('Should [return SolanaSignature] representing proof of signing message with a given private key', () {
      // Arrange
      ED25519PrivateKey actualEd25519PrivateKey = ED25519PrivateKey(
        edPrivateKey: EDPrivateKey.fromBytes(base64Decode('NgMOPT1ktg0VhawjCrTJkXT+27o7jzci+aN8Z80KsaY=')),
        metadata: Bip32KeyMetadata.fromCompressedPublicKey(
          compressedPublicKey: EDPrivateKey.fromBytes(base64Decode('NgMOPT1ktg0VhawjCrTJkXT+27o7jzci+aN8Z80KsaY=')).edPublicKey.bytes,
        ),
      );

      // Act
      SolanaSignature actualSolanaSignature = SolanaSigner(actualEd25519PrivateKey).sign(base64Decode(
          'AQACBB0D1AEIXs5Rz43yeayo7W0tSpSEF7kNTRVAVF4UGFj0UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAAPwED+D6bid8Qm8XNAPnvCc2lPDE9RQPiygKW4Pk3jYMDAwAJAwAtMQEAAAAAAwAFAu8BAAACAgABDAIAAAAAypo7AAAAAA=='));

      // Assert
      SolanaSignature expectedSolanaSignature = SolanaSignature(
        r: base64Decode('IjBdnh1Hp+g41m5oY/q6am1JLQGGip9zShFTG1QlHbs='),
        s: base64Decode('DxrAzRG+Iyd499E1lR9helUtxWT23tnpicomjYe2Lgw='),
      );

      expect(actualSolanaSignature, expectedSolanaSignature);
    });
  });
}
