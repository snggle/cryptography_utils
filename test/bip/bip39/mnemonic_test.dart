import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Mnemonic() constructor', () {
    test('Should [return Mnemonic] from given mnemonic phrase', () {
      // Arrange
      // @formatter:off
      List<String> actualMnemonicList = <String>['catalog', 'letter', 'frown', 'ramp', 'chest', 'van', 'pole', 'unfold', 'sound', 'unable', 'cool', 'endorse'];
      // @formatter:on

      // Act
      Mnemonic actualMnemonic = Mnemonic(actualMnemonicList);

      // Assert
      // @formatter:off
      List<String> expectedMnemonicList = <String>['catalog', 'letter', 'frown', 'ramp', 'chest', 'van', 'pole', 'unfold', 'sound', 'unable', 'cool', 'endorse'];
      // @formatter:on

      expect(actualMnemonic.mnemonicList, expectedMnemonicList);
    });

    test('Should [throw MnemonicException] (MnemonicExceptionType.invalidLength) if length of the mnemonic phrase is not divisible by 3', () {
      // Assert
      expect(
        () => Mnemonic(const <String>['catalog', 'letter', 'frown', 'ramp', 'chest', 'van', 'unfold', 'sound', 'unable', 'cool', 'endorse']),
        throwsA(const MnemonicException(MnemonicExceptionType.invalidLength)),
      );
    });

    test('Should [throw MnemonicException] (MnemonicExceptionType.invalidWord) if mnemonic phrase contains words from outside the dictionary', () {
      // Assert
      // @formatter:off
      expect(
        () =>  Mnemonic(const <String>['ammonium', 'nitrite', 'atom', 'hydrogen', 'cyanide', 'carbonate', 'chlorate', 'chlorite', 'perchlorate', 'cation', 'peroxide', 'oxalate']),
        throwsA(const MnemonicException(MnemonicExceptionType.invalidWord)),
      );
      // @formatter:on
    });

    test('Should [throw MnemonicException] (MnemonicExceptionType.invalidChecksum) if mnemonic phrase has invalid checksum', () {
      // Assert
      expect(
        () => Mnemonic(const <String>['catalog', 'letter', 'frown', 'ramp', 'chest', 'van', 'pole', 'unfold', 'sound', 'unable', 'cool', 'require']),
        throwsA(const MnemonicException(MnemonicExceptionType.invalidChecksum)),
      );
    });
  });

  group('Tests of Mnemonic.generate() constructor', () {
    test('Should [return 12-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words12);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 12 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 12);
    });

    test('Should [return 15-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words15);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 15 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 15);
    });

    test('Should [return 18-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words18);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 18 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 18);
    });

    test('Should [return 21-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words21);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 21 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 21);
    });

    test('Should [return 24-word Mnemonic] from random entropy', () {
      // Act
      Mnemonic actualMnemonic = Mnemonic.generate(mnemonicSize: MnemonicSize.words24);

      // Assert
      // Mnemonic generation is an random process, so we can't check the expected result.
      // Because of that we only verify that it has 24 words and that it is valid.
      expect(actualMnemonic.mnemonicList.length, 24);
    });
  });

  group('Tests of Mnemonic.fromEntropy() constructor', () {
    test('Should [return 12-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('A6cYbR86DLmCvzBIBZOZ/g==');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromMnemonicPhrase('admit decide brave dinosaur patch fresh april toward elite clutch toy witness');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return 15-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('fLr2ipXAM4Bt4HRuuguEX0a/i5A=');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromMnemonicPhrase('lake stumble pencil clog add scan resource attend huge space three salon hip shift drama');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return 18-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('8umWs3pLWU/Pg0zlYZkqJUsCBlt47V8P');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromMnemonicPhrase(
          'very erosion proud virus remain pony dignity hat tornado art enhance enhance rabbit add hospital buffalo gallery journey');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return 21-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('LrxUbhAxqj4KGuIyiuQs9u9Za1iKqmvYaz86jA==');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromMnemonicPhrase(
          'concert tired breeze call boy business chronic fox crater fire arctic universe void remember giraffe fetch hint select sound insect sister');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return 24-word Mnemonic] from given entropy', () {
      // Arrange
      Uint8List actualEntropy = base64Decode('e3WRJOi7N1NGcN4DzM29l30xVc4iWMPxdIAhxOZSig4=');

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromEntropy(actualEntropy);

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromMnemonicPhrase(
          'kiwi prosper empty sphere recall predict border bridge adult grid hunt confirm spread priority decade enrich sentence merry cactus drum example citizen choice tent');

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });
  });

  group('Tests of Mnemonic.fromMnemonicPhrase() constructor', () {
    test('Should [return Mnemonic] from given mnemonic phrase', () {
      // Arrange
      String actualMnemonicString = 'catalog letter frown ramp chest van pole unfold sound unable cool endorse';

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(actualMnemonicString);

      // Assert
      Mnemonic expectedMnemonic =
          Mnemonic(const <String>['catalog', 'letter', 'frown', 'ramp', 'chest', 'van', 'pole', 'unfold', 'sound', 'unable', 'cool', 'endorse']);

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [return Mnemonic] from given mnemonic phrase (custom delimiter)', () {
      // Arrange
      String actualMnemonicString = 'catalogdeliletterdelifrowndelirampdelichestdelivandelipoledeliunfolddelisounddeliunabledelicooldeliendorse';

      // Act
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(actualMnemonicString, delimiter: 'deli');

      // Assert
      Mnemonic expectedMnemonic =
          Mnemonic(const <String>['catalog', 'letter', 'frown', 'ramp', 'chest', 'van', 'pole', 'unfold', 'sound', 'unable', 'cool', 'endorse']);

      expect(actualMnemonic.mnemonicList, expectedMnemonic.mnemonicList);
    });

    test('Should [throw MnemonicException] (MnemonicExceptionType.invalidLength) if length of the mnemonic phrase is not divisible by 3', () {
      // Assert
      expect(
        () => Mnemonic.fromMnemonicPhrase('catalog letter frown ramp chest van unfold sound unable cool endorse'),
        throwsA(const MnemonicException(MnemonicExceptionType.invalidLength)),
      );
    });

    test('Should [throw MnemonicException] (MnemonicExceptionType.invalidWord) if mnemonic phrase contains words from outside the dictionary', () {
      // Assert
      expect(
        () => Mnemonic.fromMnemonicPhrase('ammonium nitrite atom hydrogen cyanide carbonate chlorate chlorite perchlorate cation peroxide oxalate'),
        throwsA(const MnemonicException(MnemonicExceptionType.invalidWord)),
      );
    });

    test('Should [throw MnemonicException] (MnemonicExceptionType.invalidChecksum) if mnemonic phrase has invalid checksum', () {
      // Assert
      expect(
        () => Mnemonic.fromMnemonicPhrase('catalog letter frown ramp chest van pole unfold sound unable cool require'),
        throwsA(const MnemonicException(MnemonicExceptionType.invalidChecksum)),
      );
    });
  });

  group('Tests of Mnemonic.isValidMnemonic()', () {
    test('Should [return TRUE] for a valid mnemonic', () {
      // Arrange
      // @formatter:off
      List<String> mnemonicList = <String>['catalog', 'letter', 'frown', 'ramp', 'chest', 'van', 'pole', 'unfold', 'sound', 'unable', 'cool', 'endorse'];
      // @formatter:on

      // Act
      bool actualValidBool = Mnemonic.isValidMnemonic(mnemonicList);

      // Assert
      bool expectedValidBool = true;

      expect(actualValidBool, expectedValidBool);
    });

    test('Should [return FALSE] if mnemonic phrase has invalid length', () {
      // Arrange
      List<String> mnemonicList = <String>['catalog', 'letter', 'frown'];

      // Act
      bool actualValidBool = Mnemonic.isValidMnemonic(mnemonicList);

      // Assert
      bool expectedValidBool = false;

      expect(actualValidBool, expectedValidBool);
    });

    test('Should [return FALSE] if mnemonic phrase has invalid checksum', () {
      // Arrange
      // @formatter:off
      List<String> mnemonicList = <String>['attend', 'piano', 'mail', 'clap', 'argue', 'square', 'effort', 'cause', 'cook', 'onion', 'mouse', 'delay' ];
      // @formatter:on

      // Act
      bool actualValidBool = Mnemonic.isValidMnemonic(mnemonicList);

      // Assert
      bool expectedValidBool = false;

      expect(actualValidBool, expectedValidBool);
    });
  });

  group('Tests of Mnemonic.entropy getter', () {
    test('Should [return entropy] from [12-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('admit decide brave dinosaur patch fresh april toward elite clutch toy witness');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('A6cYbR86DLmCvzBIBZOZ/g==');

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return entropy] from [15-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase('lake stumble pencil clog add scan resource attend huge space three salon hip shift drama');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('fLr2ipXAM4Bt4HRuuguEX0a/i5A=');

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return entropy] from [18-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'very erosion proud virus remain pony dignity hat tornado art enhance enhance rabbit add hospital buffalo gallery journey');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('8umWs3pLWU/Pg0zlYZkqJUsCBlt47V8P');

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return entropy] from [21-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'concert tired breeze call boy business chronic fox crater fire arctic universe void remember giraffe fetch hint select sound insect sister');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('LrxUbhAxqj4KGuIyiuQs9u9Za1iKqmvYaz86jA==');

      expect(actualEntropy, expectedEntropy);
    });

    test('Should [return entropy] from [24-word Mnemonic]', () {
      // Arrange
      Mnemonic actualMnemonic = Mnemonic.fromMnemonicPhrase(
          'kiwi prosper empty sphere recall predict border bridge adult grid hunt confirm spread priority decade enrich sentence merry cactus drum example citizen choice tent');

      // Act
      Uint8List actualEntropy = actualMnemonic.entropy;

      // Assert
      Uint8List expectedEntropy = base64Decode('e3WRJOi7N1NGcN4DzM29l30xVc4iWMPxdIAhxOZSig4=');

      expect(actualEntropy, expectedEntropy);
    });
  });
}
