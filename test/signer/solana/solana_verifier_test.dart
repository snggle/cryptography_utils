import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaVerifier.isSignatureValid()', () {
    test('Should [return TRUE] for a valid signature', () {
      // Arrange
      ED25519PublicKey actualEd25519PublicKey = ED25519PublicKey(
        edPublicKey: EDPublicKey(EDPoint.fromBytes(CurvePoints.generatorED25519, base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ='))),
        metadata: Bip32KeyMetadata.fromCompressedPublicKey(
          compressedPublicKey:
              EDPublicKey(EDPoint.fromBytes(CurvePoints.generatorED25519, base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ='))).bytes,
        ),
      );

      // Act
      bool actualSignatureValidBool = SolanaVerifier(actualEd25519PublicKey).isSignatureValid(
          base64Decode(
              'AQACBB0D1AEIXs5Rz43yeayo7W0tSpSEF7kNTRVAVF4UGFj0UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAAPwED+D6bid8Qm8XNAPnvCc2lPDE9RQPiygKW4Pk3jYMDAwAJAwAtMQEAAAAAAwAFAu8BAAACAgABDAIAAAAAypo7AAAAAA=='),
          SolanaSignature(
              r: base64Decode('IjBdnh1Hp+g41m5oY/q6am1JLQGGip9zShFTG1QlHbsPGsDNEb4jJ3j30TWVH2F6VS3FZPbe2emJyiaNh7YuDA==').sublist(0, 32),
              s: base64Decode('IjBdnh1Hp+g41m5oY/q6am1JLQGGip9zShFTG1QlHbsPGsDNEb4jJ3j30TWVH2F6VS3FZPbe2emJyiaNh7YuDA==').sublist(32, 64)));

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return FALSE] for an invalid signature', () {
      // Arrange
      ED25519PublicKey actualEd25519PublicKey = ED25519PublicKey(
        edPublicKey: EDPublicKey(EDPoint.fromBytes(CurvePoints.generatorED25519, base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ='))),
        metadata: Bip32KeyMetadata.fromCompressedPublicKey(
          compressedPublicKey:
              EDPublicKey(EDPoint.fromBytes(CurvePoints.generatorED25519, base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ='))).bytes,
        ),
      );

      // Act
      bool actualSignatureValidBool = SolanaVerifier(actualEd25519PublicKey).isSignatureValid(
          base64Decode(
              'AQACBB0D1AEIXs5Rz43yeayo7W0tSpSEF7kNTRVAVF4UGFj0UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAAPwED+D6bid8Qm8XNAPnvCc2lPDE9RQPiygKW4Pk3jYMDAwAJAwAtMQEAAAAAAwAFAu8BAAACAgABDAIAAAAAypo7AAAAAA=='),
          SolanaSignature(
              r: base64Decode('AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQ==').sublist(32),
              s: base64Decode('AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQ==').sublist(32, 64)));

      // Assert
      expect(actualSignatureValidBool, false);
    });
  });
}
