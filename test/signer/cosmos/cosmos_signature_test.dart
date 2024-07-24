import 'dart:convert';

import 'package:cryptography_utils/src/signer/cosmos/cosmos_signature.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of CosmosSignature.bytes getter', () {
    test('Should [return bytes] representing Cosmos signature', () {
      // Arrange
      CosmosSignature actualCosmosSignature = CosmosSignature(
        s: BigInt.parse('25762741804310061202983426251141315765040090201449012852222856059029735330091'),
        r: BigInt.parse('38405229888052653976493395571873434429328497679884784055390575135932131163697'),
      );

      // Act
      List<int> actualBytes = actualCosmosSignature.bytes;

      // Assert
      List<int> expectedBytes = base64Decode('VOiW/TF7pRINaMatMux1KZP3GRiXkAbvXdoQEQr1vjE49THzl1gerUme+MsMjIBoWw9LUiMc6T/NfnLhr1vRKw==');

      expect(actualBytes, expectedBytes);
    });
  });

  group('Tests of CosmosSignature.base64 getter', () {
    test('Should [return base64 string] representing Cosmos signature', () {
      // Arrange
      CosmosSignature actualCosmosSignature = CosmosSignature(
        s: BigInt.parse('25762741804310061202983426251141315765040090201449012852222856059029735330091'),
        r: BigInt.parse('38405229888052653976493395571873434429328497679884784055390575135932131163697'),
      );

      // Act
      String actualBase64 = actualCosmosSignature.base64;

      // Assert
      String expectedBase64 = 'VOiW/TF7pRINaMatMux1KZP3GRiXkAbvXdoQEQr1vjE49THzl1gerUme+MsMjIBoWw9LUiMc6T/NfnLhr1vRKw==';

      expect(actualBase64, expectedBase64);
    });
  });

  group('Tests of CosmosSignature.hex getter', () {
    test('Should [return HEX string] representing Cosmos signature', () {
      // Arrange
      CosmosSignature actualCosmosSignature = CosmosSignature(
        s: BigInt.parse('25762741804310061202983426251141315765040090201449012852222856059029735330091'),
        r: BigInt.parse('38405229888052653976493395571873434429328497679884784055390575135932131163697'),
      );

      // Act
      String actualHex = actualCosmosSignature.hex;

      // Assert
      String expectedHex = '0x54e896fd317ba5120d68c6ad32ec752993f71918979006ef5dda10110af5be3138f531f397581ead499ef8cb0c8c80685b0f4b52231ce93fcd7e72e1af5bd12b';

      expect(actualHex, expectedHex);
    });
  });

  group('Tests of CosmosSignature.length getter', () {
    test('Should [return length] of  Cosmos signature', () {
      // Arrange
      CosmosSignature actualCosmosSignature = CosmosSignature(
        s: BigInt.parse('25762741804310061202983426251141315765040090201449012852222856059029735330091'),
        r: BigInt.parse('38405229888052653976493395571873434429328497679884784055390575135932131163697'),
      );

      // Act
      int actualLength = actualCosmosSignature.length;

      // Assert
      int expectedLength = 64;

      expect(actualLength, expectedLength);
    });
  });
}
