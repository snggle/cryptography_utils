import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests of Mnemonic.generate() constructor', () {
    test('Should [return 12-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words12);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 12 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 12);
      expect(actualMnemonic.isValid, true);
    });

    test('Should [return 15-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words15);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 15 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 15);
      expect(actualMnemonic.isValid, true);
    });

    test('Should [return 18-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words18);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 18 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 18);
      expect(actualMnemonic.isValid, true);
    });

    test('Should [return 21-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words21);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 21 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 21);
      expect(actualMnemonic.isValid, true);
    });

    test('Should [return 24-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words24);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 24 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 24);
      expect(actualMnemonic.isValid, true);
    });
  });

  group('Tests of Mnemonic.fromEntropy() constructor', () {
    test('Should [return 12-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('A6cYbR86DLmCvzBIBZOZ/g==');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromString('admit decide brave dinosaur patch fresh april toward elite clutch toy witness');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return 15-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('fLr2ipXAM4Bt4HRuuguEX0a/i5A=');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromString('lake stumble pencil clog add scan resource attend huge space three salon hip shift drama');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return 18-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('8umWs3pLWU/Pg0zlYZkqJUsCBlt47V8P');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic =
          Mnemonic.fromString('very erosion proud virus remain pony dignity hat tornado art enhance enhance rabbit add hospital buffalo gallery journey');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return 21-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('LrxUbhAxqj4KGuIyiuQs9u9Za1iKqmvYaz86jA==');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromString(
          'concert tired breeze call boy business chronic fox crater fire arctic universe void remember giraffe fetch hint select sound insect sister');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return 24-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('e3WRJOi7N1NGcN4DzM29l30xVc4iWMPxdIAhxOZSig4=');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromString(
          'kiwi prosper empty sphere recall predict border bridge adult grid hunt confirm spread priority decade enrich sentence merry cactus drum example citizen choice tent');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });
  });

  group('Tests of Mnemonic.fromString() constructor', () {
    test('Should [return Mnemonic] from given String', () {
      // Arrange
      String actualMnemonicString = 'catalog letter frown ramp chest van pole unfold sound unable cool endorse';

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromString(actualMnemonicString);

      // Assert
      Mnemonic expectedMnemonic =
          const Mnemonic(<String>['catalog', 'letter', 'frown', 'ramp', 'chest', 'van', 'pole', 'unfold', 'sound', 'unable', 'cool', 'endorse']);

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return Mnemonic] from given String (custom delimiter)', () {
      // Arrange
      String actualMnemonicString = 'catalogdeliletterdelifrowndelirampdelichestdelivandelipoledeliunfolddelisounddeliunabledelicooldeliendorse';

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromString(actualMnemonicString, delimiter: 'deli');

      // Assert
      Mnemonic expectedMnemonic =
          const Mnemonic(<String>['catalog', 'letter', 'frown', 'ramp', 'chest', 'van', 'pole', 'unfold', 'sound', 'unable', 'cool', 'endorse']);

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });
  });

  group('Tests of Mnemonic.isValid getter', () {
    test('Should [return TRUE] when mnemonic is valid', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('catalog letter frown ramp chest van pole unfold sound unable cool endorse');

      // Act
      bool actualIsValid = actualMnemonic.isValid;

      // Assert
      expect(actualIsValid, true);
    });

    test('Should [return FALSE] when length of the mnemonic is not divisible by 3', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('catalog letter frown ramp chest van unfold sound unable cool endorse');

      // Act
      bool actualIsValid = actualMnemonic.isValid;

      // Assert
      expect(actualIsValid, false);
    });

    test('Should [return FALSE] when mnemonic contains a word from outside the dictionary', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('ammonium nitrite atom hydrogen cyanide carbonate chlorate chlorite perchlorate cation peroxide oxalate');

      // Act
      bool actualIsValid = actualMnemonic.isValid;

      // Assert
      expect(actualIsValid, false);
    });

    test('Should [return FALSE] when mnemonic has invalid checksum', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('catalog letter frown ramp chest van pole unfold sound unable cool require');

      // Act
      bool actualIsValid = actualMnemonic.isValid;

      // Assert
      expect(actualIsValid, false);
    });
  });

  group('Tests of Mnemonic.entropy getter', () {
    test('Should [return entropy] from [12-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('admit decide brave dinosaur patch fresh april toward elite clutch toy witness');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('A6cYbR86DLmCvzBIBZOZ/g==');

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return entropy] from [15-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('lake stumble pencil clog add scan resource attend huge space three salon hip shift drama');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('fLr2ipXAM4Bt4HRuuguEX0a/i5A=');

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return entropy] from [18-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic =
          Mnemonic.fromString('very erosion proud virus remain pony dignity hat tornado art enhance enhance rabbit add hospital buffalo gallery journey');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('8umWs3pLWU/Pg0zlYZkqJUsCBlt47V8P');

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return entropy] from [21-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString(
          'concert tired breeze call boy business chronic fox crater fire arctic universe void remember giraffe fetch hint select sound insect sister');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('LrxUbhAxqj4KGuIyiuQs9u9Za1iKqmvYaz86jA==');

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return entropy] from [24-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString(
          'kiwi prosper empty sphere recall predict border bridge adult grid hunt confirm spread priority decade enrich sentence merry cactus drum example citizen choice tent');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('e3WRJOi7N1NGcN4DzM29l30xVc4iWMPxdIAhxOZSig4=');

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [throw Exception] if length of the mnemonic is not divisible by 3', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('catalog letter frown ramp chest van unfold sound unable cool endorse');

      // Assert
      expect(() => actualMnemonic.entropy, throwsA(isA<Exception>()));
    });

    test('Should [throw Exception] if mnemonic contains a word from outside the dictionary', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('ammonium nitrite atom hydrogen cyanide carbonate chlorate chlorite perchlorate cation peroxide oxalate');

      // Assert
      expect(() => actualMnemonic.entropy, throwsA(isA<Exception>()));
    });

    test('Should [throw Exception] if mnemonic has invalid checksum', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('catalog letter frown ramp chest van pole unfold sound unable cool require');

      // Assert
      expect(() => actualMnemonic.entropy, throwsA(isA<Exception>()));
    });
  });

  group('Tests of Mnemonic.length getter', () {
    test('Should [return 12] from [12-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('admit decide brave dinosaur patch fresh april toward elite clutch toy witness');

      // Act
      int actualLength = actualMnemonic.length;

      // Assert
      int expectedLength = 12;
      expect(actualLength, expectedLength);
    });

    test('Should [return 15] from [15-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString('lake stumble pencil clog add scan resource attend huge space three salon hip shift drama');

      // Act
      int actualLength = actualMnemonic.length;

      // Assert
      int expectedLength = 15;
      expect(actualLength, expectedLength);
    });

    test('Should [return 18] from [18-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic =
          Mnemonic.fromString('very erosion proud virus remain pony dignity hat tornado art enhance enhance rabbit add hospital buffalo gallery journey');

      // Act
      int actualLength = actualMnemonic.length;

      // Assert
      int expectedLength = 18;
      expect(actualLength, expectedLength);
    });

    test('Should [return 21] from [21-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString(
          'concert tired breeze call boy business chronic fox crater fire arctic universe void remember giraffe fetch hint select sound insect sister');

      // Act
      int actualLength = actualMnemonic.length;

      // Assert
      int expectedLength = 21;
      expect(actualLength, expectedLength);
    });

    test('Should [return 24] from [24-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromString(
          'kiwi prosper empty sphere recall predict border bridge adult grid hunt confirm spread priority decade enrich sentence merry cactus drum example citizen choice tent');

      // Act
      int actualLength = actualMnemonic.length;

      // Assert
      int expectedLength = 24;
      expect(actualLength, expectedLength);
    });
  });
}
