import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  SubstrateSeedGenerator actualSubstrateSeedGenerator = SubstrateSeedGenerator();

  group('Tests of SubstrateSeedGenerator.calculateSeed()', () {
    test('Should [return seed] constructed from given HEX', () async {
      // Arrange
      String actualMnemonic = '931e7a7e0deab70a03bd56d85b0e1a5f9d05cf3588c0b14e082e6060e2e41962';
      SubstrateDerivationPath actualSubstrateDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      Uint8List actualSeed = await actualSubstrateSeedGenerator.calculateSeed(actualSubstrateDerivationPath);

      // Assert
      Uint8List expectedSeed = base64Decode('kx56fg3qtwoDvVbYWw4aX50FzzWIwLFOCC5gYOLkGWI=');

      expect(actualSeed, expectedSeed);
    });

    test('Should [return seed] constructed from given mnemonic (12 words)', () async {
      // Arrange
      String actualMnemonic = 'media seminar seminar gentle stumble smooth salon zebra visual gasp usual rough';
      SubstrateDerivationPath actualSubstrateDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      Uint8List actualSeed = await actualSubstrateSeedGenerator.calculateSeed(actualSubstrateDerivationPath);

      // Assert
      Uint8List expectedSeed = base64Decode('kx56fg3qtwoDvVbYWw4aX50FzzWIwLFOCC5gYOLkGWI=');

      expect(actualSeed, expectedSeed);
    });

    test('Should [return seed] constructed from given mnemonic (15 words)', () async {
      // Arrange
      String actualMnemonic = 'doctor arrange before lift parade husband gadget orchard omit milk guilt biology act beauty dice';
      SubstrateDerivationPath actualSubstrateDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      Uint8List actualSeed = await actualSubstrateSeedGenerator.calculateSeed(actualSubstrateDerivationPath);

      // Assert
      Uint8List expectedSeed = base64Decode('pb2snI+iMcgicjMnaJQGZc7OvVbJMCuEeuFlAJbAQRI=');

      expect(actualSeed, expectedSeed);
    });

    test('Should [return seed] constructed from given mnemonic (18 words)', () async {
      // Arrange
      String actualMnemonic = 'sense wet coach stage sheriff bargain wrap advance slide timber leave ski famous label pyramid debate sort fatal';
      SubstrateDerivationPath actualSubstrateDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      Uint8List actualSeed = await actualSubstrateSeedGenerator.calculateSeed(actualSubstrateDerivationPath);

      // Assert
      Uint8List expectedSeed = base64Decode('8QTfPEERqLFy6JJ2zYps+oxzzGOPXYWX0zAVheTesus=');

      expect(actualSeed, expectedSeed);
    });

    test('Should [return seed] constructed from given mnemonic (21 words)', () async {
      // Arrange
      String actualMnemonic =
          'fatal flame spike bless razor prevent rally human stamp kiwi cause raise always discover chef wide program bless fold celery immense';
      SubstrateDerivationPath actualSubstrateDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      Uint8List actualSeed = await actualSubstrateSeedGenerator.calculateSeed(actualSubstrateDerivationPath);

      // Assert
      Uint8List expectedSeed = base64Decode('ZzqQFnGGhcRSQANnyc6+P9BtiPJCZgKnwiTyUe3kFNU=');

      expect(actualSeed, expectedSeed);
    });

    test('Should [return seed] constructed from given mnemonic (24 words)', () async {
      // Arrange
      String actualMnemonic =
          'track resist blood salute popular pride salon receive weather tornado wink tackle few trend embrace burst zebra mind siege tower shift joy flash awkward';
      SubstrateDerivationPath actualSubstrateDerivationPath = SubstrateDerivationPath.fromUri(actualMnemonic);

      // Act
      Uint8List actualSeed = await actualSubstrateSeedGenerator.calculateSeed(actualSubstrateDerivationPath);

      // Assert
      Uint8List expectedSeed = base64Decode('y5ddW/azZ+Zx8kfzgvEjQ2qV/hD72HKL1FYzxDwUB9w=');

      expect(actualSeed, expectedSeed);
    });
  });
}
