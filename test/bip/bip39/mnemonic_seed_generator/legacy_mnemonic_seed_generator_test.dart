import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of LegacyMnemonicSeedGenerator.generateSeed()', () {
    test('Should [return 32-bytes seed] constructed from [12-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator(seedLength: 32);
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('media seminar seminar gentle stumble smooth salon zebra visual gasp usual rough');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('PR2YNJm2i+sQ37pVigrZ/DjPLHDI/7/ZvSybQ3A3xLU=');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 32-bytes seed] constructed from [15-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator(seedLength: 32);
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('doctor arrange before lift parade husband gadget orchard omit milk guilt biology act beauty dice');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('SJpxaXeoxjUEmulwcKnGHV0TkvTe/3wFzncpqPTwlBM=');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 32-bytes seed] constructed from [18-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator(seedLength: 32);
      Mnemonic actualMnemonic =
          Mnemonic.fromMnemonicPhrase('sense wet coach stage sheriff bargain wrap advance slide timber leave ski famous label pyramid debate sort fatal');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('FAY0bWKF3Te5qtxAqZL4FEZLkg/2qEd/qgiaDltgnW4=');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 32-bytes seed] constructed from [21-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator(seedLength: 32);
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'fatal flame spike bless razor prevent rally human stamp kiwi cause raise always discover chef wide program bless fold celery immense');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('Msio2buc9rH5UmfgV58iETBMd3BFqF2EJDxul+kGpxo=');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 32-bytes seed] constructed from [24-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator(seedLength: 32);
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'track resist blood salute popular pride salon receive weather tornado wink tackle few trend embrace burst zebra mind siege tower shift joy flash awkward');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('eC7elPvLPqAwBYRITd5Ixthc+YlF0QfgIb9lgtO81Uw=');
      expect(actualSeed, expectedSeed);
    });

    // ************************************************************************************************

    test('Should [return 64-bytes seed] constructed from [12-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator();
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('media seminar seminar gentle stumble smooth salon zebra visual gasp usual rough');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('PR2YNJm2i+sQ37pVigrZ/DjPLHDI/7/ZvSybQ3A3xLUcpCNtGeISOJUU1mDv3AIbDjtWvCKWzJWgm5QpB0WD9g==');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 64-bytes seed] constructed from [15-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator();
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('doctor arrange before lift parade husband gadget orchard omit milk guilt biology act beauty dice');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('SJpxaXeoxjUEmulwcKnGHV0TkvTe/3wFzncpqPTwlBPfY9zS6wCYbpGG2MPSGxyj7zM52McUzc2+VnpAXEm94Q==');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 64-bytes seed] constructed from [18-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator();
      Mnemonic actualMnemonic =
          Mnemonic.fromMnemonicPhrase('sense wet coach stage sheriff bargain wrap advance slide timber leave ski famous label pyramid debate sort fatal');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('FAY0bWKF3Te5qtxAqZL4FEZLkg/2qEd/qgiaDltgnW6G8VQBtHn7dioUD58zLiETkQX+zl2GOXMISWWLGRt6Yg==');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 64-bytes seed] constructed from [21-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator();
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'fatal flame spike bless razor prevent rally human stamp kiwi cause raise always discover chef wide program bless fold celery immense');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('Msio2buc9rH5UmfgV58iETBMd3BFqF2EJDxul+kGpxrz2vOkCpOG2vPBKQUci79vqf9nyhD3nvszagqIE2PyJg==');
      expect(actualSeed, expectedSeed);
    });

    test('Should [return 64-bytes seed] constructed from [24-word Mnemonic]', () async {
      // Arrange
      LegacyMnemonicSeedGenerator actualLegacyMnemonicSeedGenerator = LegacyMnemonicSeedGenerator();
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'track resist blood salute popular pride salon receive weather tornado wink tackle few trend embrace burst zebra mind siege tower shift joy flash awkward');

      // Act
      Uint8List actualSeed = await actualLegacyMnemonicSeedGenerator.generateSeed(actualMnemonic);

      // Assert
      Uint8List expectedSeed = base64Decode('eC7elPvLPqAwBYRITd5Ixthc+YlF0QfgIb9lgtO81UzO22hXaKbOw1Vy8QIBxfZh8w17Itc/R+Q42zMZLyGYLQ==');
      expect(actualSeed, expectedSeed);
    });
  });
}
