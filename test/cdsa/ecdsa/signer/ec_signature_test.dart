import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ECSignature.fromBase64() constructor', () {
    test('Should [return ECSignature] constructed from base64 String', () {
      // Arrange
      String actualSignature = 'pdDhYhioe7vKtGcmyLDP0m8qbeHwOy7R8WprnKWDpztSVKTWrNfxeJk8Zo9qd7Ef2IFeIej8RJN+YO+a+lDoRw==';

      // Act
      ECSignature actualECSignature = ECSignature.fromBase64(actualSignature);

      // Assert
      ECSignature expectedECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      expect(actualECSignature, expectedECSignature);
    });
  });

  group('Tests of ECSignature.fromBytes() constructor', () {
    test('Should [return ECSignature] constructed from bytes', () {
      // Arrange
      String actualSignature = 'pdDhYhioe7vKtGcmyLDP0m8qbeHwOy7R8WprnKWDpztSVKTWrNfxeJk8Zo9qd7Ef2IFeIej8RJN+YO+a+lDoRw==';
      Uint8List actualSignatureBytes = base64Decode(actualSignature);

      // Act
      ECSignature actualECSignature = ECSignature.fromBytes(actualSignatureBytes);

      // Assert
      ECSignature expectedECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      expect(actualECSignature, expectedECSignature);
    });
  });

  group('Tests of ECSignature.base64 getter', () {
    test('Should [return String] representing signature in base64 format', () {
      // Arrange
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      // Act
      String actualSignature = actualECSignature.base64;

      // Assert
      String expectedSignature = 'pdDhYhioe7vKtGcmyLDP0m8qbeHwOy7R8WprnKWDpztSVKTWrNfxeJk8Zo9qd7Ef2IFeIej8RJN+YO+a+lDoRw==';

      expect(actualSignature, expectedSignature);
    });
  });

  group('Tests of ECSignature.bytes getter', () {
    test('Should [return List<int>] representing signature as bytes', () {
      // Arrange
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      // Act
      List<int> actualSignatureBytes = actualECSignature.bytes;

      // Assert
      String expectedSignature = 'pdDhYhioe7vKtGcmyLDP0m8qbeHwOy7R8WprnKWDpztSVKTWrNfxeJk8Zo9qd7Ef2IFeIej8RJN+YO+a+lDoRw==';
      Uint8List expectedSignatureBytes = base64Decode(expectedSignature);

      expect(actualSignatureBytes, expectedSignatureBytes);
    });
  });

  group('Tests of ECSignature.length getter', () {
    test('Should [return integer] representing signature length', () {
      // Arrange
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('75000679743312464303387321273076902476064249087509773163224163340661081483067'),
        s: BigInt.parse('37239206411301236619021693398877473693701268858384632524554556980614942222407'),
      );

      // Act
      int actualSignatureLength = actualECSignature.length;

      // Assert
      int expectedSignatureLength = 64;

      expect(actualSignatureLength, expectedSignatureLength);
    });
  });

  group('Tests of ECSignature.recoverPublicKeys()', () {
    test('Should [return list] of possible ECPublicKey used to create signature', () {
      // Arrange
      Uint8List actualMessage = base64Decode('SGVsbG8gd29ybGQ=');
      ECSignature actualECSignature = ECSignature(
        r: BigInt.parse('21165175836978812381665558937913198224702266563755240335786634922159270665737'),
        s: BigInt.parse('67243574932862348866046687334828474181280536427312945072404625477687067369325'),
      );

      // Act
      List<ECPublicKey> actualPublicKeys = actualECSignature.recoverPublicKeys(
        actualMessage,
        CurvePoints.generatorSecp256k1,
      );

      // Assert
      List<ECPublicKey> expectedPublicKeys = <ECPublicKey>[
        ECPublicKey(
          CurvePoints.generatorSecp256k1,
          ECPoint(
            curve: CurvePoints.generatorSecp256k1.curve,
            n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
            x: BigInt.parse('84909152903782478444068056264317721768637075090919012560300974171460890829977'),
            y: BigInt.parse('90181300343337577348648907775400046273612228741215532517116328898464416889953'),
            z: BigInt.parse('51068888985030301479088319251699507758995393603705301431012005984206317887185'),
          ),
        ),
        ECPublicKey(
          CurvePoints.generatorSecp256k1,
          ECPoint(
            curve: CurvePoints.generatorSecp256k1.curve,
            n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
            x: BigInt.parse('107662207778954971559162971772006115399367379623796655333411366875667753522295'),
            y: BigInt.parse('8268371367935261007808370078779833629569024048122742705478563339847270328710'),
            z: BigInt.parse('41735628811158659316231664092511749103879693592779553295667408338280369208296'),
          ),
        ),
      ];

      expect(actualPublicKeys, expectedPublicKeys);
    });
  });
}
