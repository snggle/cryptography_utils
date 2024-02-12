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

  group('Tests of SRSignature.hex getter', () {
    test('Should [return HEX] representing signature in HEX forma', () {
      // Arrange
      SRSignature actualSRSignature = SRSignature(
        r: base64Decode('lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQno='),
        s: base64Decode('74tBmKoL1acVI7HBsXac/nYMnRzQTEmzEBYCQFiFRAQ='),
      );

      // Act
      String actualSignature = actualSRSignature.hex;

      // Assert
      String expectedSignature = '0x94098aac6761834d960319a728fa49385effc6e9d0d9f62820cabb96eaeb427aef8b4198aa0bd5a71523b1c1b1769cfe760c9d1cd04c49b31016024058854484';

      expect(actualSignature, expectedSignature);
    });
  });

  group('Tests of SRSignature.length getter', () {
    test('Should [return integer] representing signature length', () {
      // Arrange
      SRSignature actualSRSignature = SRSignature(
        r: base64Decode('lAmKrGdhg02WAxmnKPpJOF7/xunQ2fYoIMq7lurrQno='),
        s: base64Decode('74tBmKoL1acVI7HBsXac/nYMnRzQTEmzEBYCQFiFRAQ='),
      );

      // Act
      int actualSignatureLength = actualSRSignature.length;

      // Assert
      int expectedSignatureLength = 64;

      expect(actualSignatureLength, expectedSignatureLength);
    });
  });
}
