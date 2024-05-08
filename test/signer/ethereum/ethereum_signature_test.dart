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
      );

      expect(actualEthereumSignature, expectedEthereumSignature);
    });
  });

  group('Tests of EthereumSignature.toBytes()', () {
    test('Should [return bytes] representing Ethereum signature (EIP155 = FALSE)', () {
      // Arrange
      EthereumSignature actualEthereumSignature = EthereumSignature(
        s: BigInt.parse('41325114421089270084607549817718071559637014516154979292181930199612617974047'),
        r: BigInt.parse('30514973747782274981305901633014540627078654233732090597450528845397372093654'),
        v: 28,
      );

      // Act
      List<int> actualBytes = actualEthereumSignature.toBytes(eip155Bool: false);

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
      );

      // Act
      List<int> actualBytes = actualEthereumSignature.toBytes(eip155Bool: true);

      // Assert
      List<int> expectedBytes = base64Decode('3PO/qqCWu2l5P8nZcnDuPP6++pWJaqywd63c9o8X4RcJSHkbmYLdNpQrSdgLp1RUohnUcuIEFaqkAS/efo3Rehs=');

      expect(actualBytes, expectedBytes);
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
