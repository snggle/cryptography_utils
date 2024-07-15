import 'dart:convert';

import 'package:cryptography_utils/src/signer/ethereum/ethereum_signature.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EthereumSignature.fromBytes() constructor', () {
    test('Should [return EthereumSignature] from given bytes (without EIP155)', () {
      // Arrange
      List<int> actualBytes = base64Decode('Q3bc8yIl+93TnoodS8NnjdrIHC08E7iZ7DAWJOZexNZbXS+V4rp31GxppDeDsrpiRR/OlTDhGSt1FCK9E4DhHwE=');

      // Act
      EthereumSignature actualEthereumSignature = EthereumSignature.fromBytes(actualBytes);

      // Assert
      EthereumSignature expectedEthereumSignature = EthereumSignature(
        s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
        r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
        v: 28,
        eip155Bool: false,
      );

      expect(actualEthereumSignature, expectedEthereumSignature);
    });

    test('Should [return EthereumSignature] from given bytes (with EIP155)', () {
      // Arrange
      List<int> actualBytes = base64Decode('3PO/qqCWu2l5P8nZcnDuPP6++pWJaqywd63c9o8X4RcJSHkbmYLdNpQrSdgLp1RUohnUcuIEFaqkAS/efo3Rehs=');

      // Act
      EthereumSignature actualEthereumSignature = EthereumSignature.fromBytes(actualBytes);

      // Assert
      EthereumSignature expectedEthereumSignature = EthereumSignature(
        s: BigInt.parse('4198864481306577837682028282947052483452195327864676417585939058124066247034'),
        r: BigInt.parse('99939493358714897494863896500450631491074732002796204467407631647543628652823'),
        v: 27,
        eip155Bool: true,
      );

      expect(actualEthereumSignature, expectedEthereumSignature);
    });
  });

  group('Tests of EthereumSignature.bytes getter', () {
    test('Should [return bytes] representing Ethereum signature (EIP155 = FALSE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
          s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
          r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
          v: 28,
          eip155Bool: false);

      // Act
      List<int> actualBytes = actualEthereumSignature.bytes;

      // Assert
      List<int> expectedBytes = base64Decode('Q3bc8yIl+93TnoodS8NnjdrIHC08E7iZ7DAWJOZexNZbXS+V4rp31GxppDeDsrpiRR/OlTDhGSt1FCK9E4DhHwE=');

      expect(actualBytes, expectedBytes);
    });

    test('Should [return bytes] representing Ethereum signature (EIP155 = TRUE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('4198864481306577837682028282947052483452195327864676417585939058124066247034'),
        r: BigInt.parse('99939493358714897494863896500450631491074732002796204467407631647543628652823'),
        v: 27,
        eip155Bool: true,
      );

      // Act
      List<int> actualBytes = actualEthereumSignature.bytes;

      // Assert
      List<int> expectedBytes = base64Decode('3PO/qqCWu2l5P8nZcnDuPP6++pWJaqywd63c9o8X4RcJSHkbmYLdNpQrSdgLp1RUohnUcuIEFaqkAS/efo3Rehs=');

      expect(actualBytes, expectedBytes);
    });
  });

  group('Tests of EthereumSignature.base64 getter', () {
    test('Should [return base64 string] representing Ethereum signature (EIP155 = FALSE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
        r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
        v: 28,
        eip155Bool: false,
      );

      // Act
      String actualBase64 = actualEthereumSignature.base64;

      // Assert
      String expectedBase64 = 'Q3bc8yIl+93TnoodS8NnjdrIHC08E7iZ7DAWJOZexNZbXS+V4rp31GxppDeDsrpiRR/OlTDhGSt1FCK9E4DhHwE=';

      expect(actualBase64, expectedBase64);
    });

    test('Should [return base64 string] representing Ethereum signature (EIP155 = TRUE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('4198864481306577837682028282947052483452195327864676417585939058124066247034'),
        r: BigInt.parse('99939493358714897494863896500450631491074732002796204467407631647543628652823'),
        v: 27,
        eip155Bool: true,
      );

      // Act
      String actualBase64 = actualEthereumSignature.base64;

      // Assert
      String expectedBase64 = '3PO/qqCWu2l5P8nZcnDuPP6++pWJaqywd63c9o8X4RcJSHkbmYLdNpQrSdgLp1RUohnUcuIEFaqkAS/efo3Rehs=';

      expect(actualBase64, expectedBase64);
    });
  });

  group('Tests of EthereumSignature.hex getter', () {
    test('Should [return HEX string] representing Ethereum signature (EIP155 = FALSE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
        r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
        v: 28,
        eip155Bool: false,
      );

      // Act
      String actualHex = actualEthereumSignature.hex;

      // Assert
      String expectedHex =
          '0x4376dcf32225fbddd39e8a1d4bc3678ddac81c2d3c13b899ec301624e65ec4d65b5d2f95e2ba77d46c69a43783b2ba62451fce9530e1192b751422bd1380e11f01';

      expect(actualHex, expectedHex);
    });

    test('Should [return HEX string] representing Ethereum signature (EIP155 = TRUE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('4198864481306577837682028282947052483452195327864676417585939058124066247034'),
        r: BigInt.parse('99939493358714897494863896500450631491074732002796204467407631647543628652823'),
        v: 27,
        eip155Bool: true,
      );

      // Act
      String actualHex = actualEthereumSignature.hex;

      // Assert
      String expectedHex =
          '0xdcf3bfaaa096bb69793fc9d97270ee3cfebefa95896aacb077addcf68f17e1170948791b9982dd36942b49d80ba75454a219d472e20415aaa4012fde7e8dd17a1b';

      expect(actualHex, expectedHex);
    });
  });

  group('Tests of EthereumSignature.length getter', () {
    test('Should [return length] of Ethereum signature (EIP155 = FALSE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
        r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
        v: 28,
        eip155Bool: false,
      );

      // Act
      int actualLength = actualEthereumSignature.length;

      // Assert
      int expectedLength = 65;

      expect(actualLength, expectedLength);
    });

    test('Should [return length] of Ethereum signature (EIP155 = TRUE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('4198864481306577837682028282947052483452195327864676417585939058124066247034'),
        r: BigInt.parse('99939493358714897494863896500450631491074732002796204467407631647543628652823'),
        v: 27,
        eip155Bool: true,
      );

      // Act
      int actualLength = actualEthereumSignature.length;

      // Assert
      int expectedLength = 65;

      expect(actualLength, expectedLength);
    });
  });

  group('Tests of EthereumSignature.v getter', () {
    test('Should [return integer] representing V signature value (EIP155 = FALSE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('4198864481306577837682028282947052483452195327864676417585939058124066247034'),
        r: BigInt.parse('99939493358714897494863896500450631491074732002796204467407631647543628652823'),
        v: 27,
        eip155Bool: false,
      );

      // Act
      int actualV = actualEthereumSignature.v;

      // Assert
      int expectedV = 0;

      expect(actualV, expectedV);
    });

    test('Should [return integer] representing V signature value (EIP155 = TRUE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('4198864481306577837682028282947052483452195327864676417585939058124066247034'),
        r: BigInt.parse('99939493358714897494863896500450631491074732002796204467407631647543628652823'),
        v: 27,
        eip155Bool: true,
      );

      // Act
      int actualV = actualEthereumSignature.v;

      // Assert
      int expectedV = 27;

      expect(actualV, expectedV);
    });
  });

  group('Tests of EthereumSignature.rBytes getter', () {
    test('Should [return bytes] representing R signature value', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
        r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
        v: 28,
      );

      // Act
      List<int> actualRBytes = actualEthereumSignature.rBytes;

      // Assert
      List<int> expectedRBytes = base64Decode('Q3bc8yIl+93TnoodS8NnjdrIHC08E7iZ7DAWJOZexNY=');

      expect(actualRBytes, expectedRBytes);
    });
  });

  group('Tests of EthereumSignature.sBytes getter', () {
    test('Should [return bytes] representing S signature value', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
        r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
        v: 28,
      );

      // Act
      List<int> actualSBytes = actualEthereumSignature.sBytes;

      // Assert
      List<int> expectedSBytes = base64Decode('W10vleK6d9RsaaQ3g7K6YkUfzpUw4RkrdRQivROA4R8=');

      expect(actualSBytes, expectedSBytes);
    });
  });
}
