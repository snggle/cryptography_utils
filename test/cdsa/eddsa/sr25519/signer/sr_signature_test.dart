import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/cdsa/eddsa/sr25519/signer/sr_signature.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SRSignature.fromBase64() constructor', () {
    test('Should [return SRSignature] constructed from base64 String', () {
      // Arrange
      String actualSignature = 'lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQnrvi0GYqgvVpxUjscGxdpz+dgydHNBMSbMQFgJAWIVEhA==';

      // Act
      SRSignature actualSRSignature = SRSignature.fromBase64(actualSignature);

      // Assert
      SRSignature expectedSRSignature = SRSignature(
        r: base64Decode('lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQno='),
        s: base64Decode('74tBmKoL1acVI7HBsXac/nYMnRzQTEmzEBYCQFiFRAQ='),
      );

      expect(actualSRSignature, expectedSRSignature);
    });
  });

  group('Tests of SRSignature.fromBytes() constructor', () {
    test('Should [return SRSignature] constructed from bytes', () {
      // Arrange
      String actualSignature = 'lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQnrvi0GYqgvVpxUjscGxdpz+dgydHNBMSbMQFgJAWIVEhA==';
      Uint8List actualSignatureBytes = base64Decode(actualSignature);

      // Act
      SRSignature actualSRSignature = SRSignature.fromBytes(actualSignatureBytes);

      // Assert
      SRSignature expectedSRSignature = SRSignature(
        r: base64Decode('lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQno='),
        s: base64Decode('74tBmKoL1acVI7HBsXac/nYMnRzQTEmzEBYCQFiFRAQ='),
      );

      expect(actualSRSignature, expectedSRSignature);
    });
  });

  group('Tests of SRSignature.base64 getter', () {
    test('Should [return String] representing signature in base64 format', () {
      // Arrange
      SRSignature actualSRSignature = SRSignature(
        r: base64Decode('lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQno='),
        s: base64Decode('74tBmKoL1acVI7HBsXac/nYMnRzQTEmzEBYCQFiFRAQ='),
      );

      // Act
      String actualSignature = actualSRSignature.base64;

      // Assert
      String expectedSignature = 'lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQnrvi0GYqgvVpxUjscGxdpz+dgydHNBMSbMQFgJAWIVEhA==';

      expect(actualSignature, expectedSignature);
    });
  });

  group('Tests of SRSignature.bytes getter', () {
    test('Should [return List<int>] representing signature as bytes', () {
      // Arrange
      SRSignature actualSRSignature = SRSignature(
        r: base64Decode('lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQno='),
        s: base64Decode('74tBmKoL1acVI7HBsXac/nYMnRzQTEmzEBYCQFiFRAQ='),
      );

      // Act
      List<int> actualSignatureBytes = actualSRSignature.bytes;

      // Assert
      String expectedSignature = 'lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQnrvi0GYqgvVpxUjscGxdpz+dgydHNBMSbMQFgJAWIVEhA==';
      Uint8List expectedSignatureBytes = base64Decode(expectedSignature);

      expect(actualSignatureBytes, expectedSignatureBytes);
    });
  });
}
