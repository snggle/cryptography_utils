import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaVerifier.isSignatureValid()', () {
    test('Should [return TRUE] for a valid signature', () {
      // Arrange

      Uint8List actualPublicKeyBytes = base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=');

      EDPublicKey actualEdPublicKey = EDPublicKey(EDPoint.fromBytes(
        CurvePoints.generatorED25519,
        actualPublicKeyBytes,
      ));

      ED25519PublicKey actualEd25519PublicKey = ED25519PublicKey(
        edPublicKey: actualEdPublicKey,
        metadata: Bip32KeyMetadata.fromCompressedPublicKey(
          compressedPublicKey: actualEdPublicKey.bytes,
        ),
      );

      SolanaVerifier actualSolanaVerifier = SolanaVerifier(actualEd25519PublicKey);

      Uint8List actualMessage = base64Decode(
          'AQACBB0D1AEIXs5Rz43yeayo7W0tSpSEF7kNTRVAVF4UGFj0UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAAPwED+D6bid8Qm8XNAPnvCc2lPDE9RQPiygKW4Pk3jYMDAwAJAwAtMQEAAAAAAwAFAu8BAAACAgABDAIAAAAAypo7AAAAAA==');

      Uint8List actualSignatureBytes = Uint8List.fromList(base64Decode('IjBdnh1Hp+g41m5oY/q6am1JLQGGip9zShFTG1QlHbsPGsDNEb4jJ3j30TWVH2F6VS3FZPbe2emJyiaNh7YuDA=='));

      SolanaSignature actualSignature = SolanaSignature(r: actualSignatureBytes.sublist(0, 32), s: actualSignatureBytes.sublist(32, 64));

      // Act
      bool actualSignatureValidBool = actualSolanaVerifier.isSignatureValid(actualMessage, actualSignature);

      // Assert
      expect(actualSignatureValidBool, true);
    });

    test('Should [return FALSE] for an invalid signature', () {
      // Arrange
      Uint8List actualPublicKeyBytes = base64Decode('HQPUAQhezlHPjfJ5rKjtbS1KlIQXuQ1NFUBUXhQYWPQ=');

      EDPublicKey actualEdPublicKey = EDPublicKey(EDPoint.fromBytes(
        CurvePoints.generatorED25519,
        actualPublicKeyBytes,
      ));

      ED25519PublicKey actualEd25519PublicKey = ED25519PublicKey(
        edPublicKey: actualEdPublicKey,
        metadata: Bip32KeyMetadata.fromCompressedPublicKey(
          compressedPublicKey: actualEdPublicKey.bytes,
        ),
      );

      SolanaVerifier actualSolanaVerifier = SolanaVerifier(actualEd25519PublicKey);

      Uint8List actualMessage = base64Decode(
          'AQACBB0D1AEIXs5Rz43yeayo7W0tSpSEF7kNTRVAVF4UGFj0UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAAPwED+D6bid8Qm8XNAPnvCc2lPDE9RQPiygKW4Pk3jYMDAwAJAwAtMQEAAAAAAwAFAu8BAAACAgABDAIAAAAAypo7AAAAAA==');

      Uint8List actualSignatureBytes = Uint8List.fromList(base64Decode('AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQ=='));

      SolanaSignature actualSolanaSignature = SolanaSignature(r: actualSignatureBytes.sublist(32), s: actualSignatureBytes.sublist(32, 64));

      // Act
      bool actualSignatureValidBool = actualSolanaVerifier.isSignatureValid(actualMessage, actualSolanaSignature);

      // Assert
      expect(actualSignatureValidBool, false);
    });
  });
}
