import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of EntropyMnemonicSeedGenerator.generateSeed()', () {
    test('Should [return 32-bytes seed] constructed from [12-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator();
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('media seminar seminar gentle stumble smooth salon zebra visual gasp usual rough');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('kx56fg3qtwoDvVbYWw4aX50FzzWIwLFOCC5gYOLkGWI=');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 32-bytes seed] constructed from [15-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator();
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('doctor arrange before lift parade husband gadget orchard omit milk guilt biology act beauty dice');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('pb2snI+iMcgicjMnaJQGZc7OvVbJMCuEeuFlAJbAQRI=');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 32-bytes seed] constructed from [18-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator();
      Mnemonic actualMnemonic =
          Mnemonic.fromMnemonicPhrase('sense wet coach stage sheriff bargain wrap advance slide timber leave ski famous label pyramid debate sort fatal');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('8QTfPEERqLFy6JJ2zYps+oxzzGOPXYWX0zAVheTesus=');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 32-bytes seed] constructed from [21-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator();
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'fatal flame spike bless razor prevent rally human stamp kiwi cause raise always discover chef wide program bless fold celery immense');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('ZzqQFnGGhcRSQANnyc6+P9BtiPJCZgKnwiTyUe3kFNU=');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 32-bytes seed] constructed from [24-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator();
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'track resist blood salute popular pride salon receive weather tornado wink tackle few trend embrace burst zebra mind siege tower shift joy flash awkward');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('y5ddW/azZ+Zx8kfzgvEjQ2qV/hD72HKL1FYzxDwUB9w=');
      expect(actualSeed, expectedSeed);
    });

    // ************************************************************************************************

    test('Should [return 64-bytes seed] constructed from [12-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator(seedLength: 64);
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('media seminar seminar gentle stumble smooth salon zebra visual gasp usual rough');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('kx56fg3qtwoDvVbYWw4aX50FzzWIwLFOCC5gYOLkGWLJUYUFUH6PnABMew3V+TM3IhkKyfG5oMMXGlg6fWJUog==');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 64-bytes seed] constructed from [15-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator(seedLength: 64);
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('doctor arrange before lift parade husband gadget orchard omit milk guilt biology act beauty dice');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('pb2snI+iMcgicjMnaJQGZc7OvVbJMCuEeuFlAJbAQRKO41mompYE1Y2PMRTpMUfUbHpezvHz7+te3r0fr8bkWQ==');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 64-bytes seed] constructed from [18-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator(seedLength: 64);
      Mnemonic actualMnemonic =
          Mnemonic.fromMnemonicPhrase('sense wet coach stage sheriff bargain wrap advance slide timber leave ski famous label pyramid debate sort fatal');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('8QTfPEERqLFy6JJ2zYps+oxzzGOPXYWX0zAVheTesuvrQY5OuNR4T6K6AwTy2mZ5p+uCmv6hSAsGwGwhEKOAMg==');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 64-bytes seed] constructed from [21-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator(seedLength: 64);
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'fatal flame spike bless razor prevent rally human stamp kiwi cause raise always discover chef wide program bless fold celery immense');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('ZzqQFnGGhcRSQANnyc6+P9BtiPJCZgKnwiTyUe3kFNUbRkE7U1YQi2x14uDadhJhy93JSrI4omrcOxsbgfJKmA==');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 64-bytes seed] constructed from [24-word Mnemonic]', () async {
      // Arrange
      EntropyMnemonicSeedGenerator actualEntropyMnemonicSeedGenerator = EntropyMnemonicSeedGenerator(seedLength: 64);
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'track resist blood salute popular pride salon receive weather tornado wink tackle few trend embrace burst zebra mind siege tower shift joy flash awkward');

      // Act
      Uint8List actualSeed = await actualEntropyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('y5ddW/azZ+Zx8kfzgvEjQ2qV/hD72HKL1FYzxDwUB9x90VeED2Kg6Xx42tNrdLPRR1ClBPrwQ+Mpe7TmYeBm4g==');
      expect(actualSeed, expectedSeed);
    });
  });
}
