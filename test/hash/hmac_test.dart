import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of HMAC.process()', () {
    test('Should [return HMAC digest] constructed using SHA256 algorithm (key length < digest size)', () {
      // Arrange
      Uint8List actualDataToHash = base64Decode('Q1JZUFRP');
      Uint8List actualHMACKey = base64Decode('Qml0Y29pbiBzZWVk');

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha256(), key: actualHMACKey).process(actualDataToHash);

      // Assert
      Uint8List expectedHMACResult = base64Decode('v2mD8MCO7DhGtDEDnyf1bextorPfq2WWl4tMV9uGqEU=');

      expect(actualHMACResult, expectedHMACResult);
    });

    test('Should [return HMAC digest] constructed using SHA256 algorithm (key length == digest size)', () {
      // Arrange
      Uint8List actualDataToHash = base64Decode('Q1JZUFRP');
      Uint8List actualHMACKey = base64Decode('BucEJucuy4B7Xo9OvwvDO0Z3HokXk3DjIQC51BiJGdU=');

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha256(), key: actualHMACKey).process(actualDataToHash);

      // Assert
      Uint8List expectedHMACResult = base64Decode('LmFRERNSnjn0Z1qgGrzq/iv9zSZA4kzJ/3U7CeZ5+wE=');

      expect(actualHMACResult, expectedHMACResult);
    });

    test('Should [return HMAC digest] constructed using SHA256 algorithm (key length > digest size)', () {
      // Arrange
      Uint8List actualDataToHash = base64Decode('Q1JZUFRP');
      Uint8List actualHMACKey = base64Decode(
          'ZXhjbHVkZSB3ZXN0IG5vYmxlIHB1cml0eSBiZXlvbmQgaWxsbmVzcyBzb3VwIHJlc2VtYmxlIGF0b20gb2J2aW91cyBtZXRob2QgZmVzdGl2YWwgbmFtZSBpZGVudGlmeSBlbGVwaGFudCBzYXRpc2Z5IHdlZGRpbmcgaG9uZXkgY2VydGFpbiB0b2UgZXJvZGU=');

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha256(), key: actualHMACKey).process(actualDataToHash);

      // Assert
      Uint8List expectedHMACResult = base64Decode('LmFRERNSnjn0Z1qgGrzq/iv9zSZA4kzJ/3U7CeZ5+wE=');

      expect(actualHMACResult, expectedHMACResult);
    });

    // ********************************************************************************************************

    test('Should [return HMAC digest] constructed using SHA512 algorithm (key length < digest size)', () {
      // Arrange
      Uint8List actualDataToHash = base64Decode('Q1JZUFRP');
      Uint8List actualHMACKey = base64Decode('Qml0Y29pbiBzZWVk');

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha512(), key: actualHMACKey).process(actualDataToHash);

      // Assert
      Uint8List expectedHMACResult = base64Decode('tNAYHKi1A1v+dYxeuRBssVzo0wD/BccFLM8Ek2MUKfghQaRFgE4jqQND6+UBYd2CADPxl03Yu1wIorDCokjZlA==');

      expect(actualHMACResult, expectedHMACResult);
    });

    test('Should [return HMAC digest] constructed using SHA512 algorithm (key length == digest size)', () {
      // Arrange
      Uint8List actualDataToHash = base64Decode('Q1JZUFRP');
      Uint8List actualHMACKey = base64Decode('YLx7mbfIG2DJhqGhJdI0TgJGcDPyouYG/jURk8BZNr5N706v+vpVknd9X4as7jVrOkgBHFOkLmWuGSdWXTkqLw==');

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha512(), key: actualHMACKey).process(actualDataToHash);

      // Assert
      Uint8List expectedHMACResult = base64Decode('rJmboYqazBqeHW/vUXGSTcj7hE67pNaxyJoqS7/VnR0QIxDuK7+t2YWo/7X1SoAmXXoGxYQobJj8RWLZpb/LYg==');

      expect(actualHMACResult, expectedHMACResult);
    });

    test('Should [return HMAC digest] constructed using SHA512 algorithm (key length > digest size)', () {
      // Arrange
      Uint8List actualDataToHash = base64Decode('Q1JZUFRP');
      Uint8List actualHMACKey = base64Decode(
          'ZXhjbHVkZSB3ZXN0IG5vYmxlIHB1cml0eSBiZXlvbmQgaWxsbmVzcyBzb3VwIHJlc2VtYmxlIGF0b20gb2J2aW91cyBtZXRob2QgZmVzdGl2YWwgbmFtZSBpZGVudGlmeSBlbGVwaGFudCBzYXRpc2Z5IHdlZGRpbmcgaG9uZXkgY2VydGFpbiB0b2UgZXJvZGU=');

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha512(), key: actualHMACKey).process(actualDataToHash);

      // Assert
      Uint8List expectedHMACResult = base64Decode('rJmboYqazBqeHW/vUXGSTcj7hE67pNaxyJoqS7/VnR0QIxDuK7+t2YWo/7X1SoAmXXoGxYQobJj8RWLZpb/LYg==');

      expect(actualHMACResult, expectedHMACResult);
    });
  });

  group('Tests of HMAC.processChunks()', () {
    test('Should [return HMAC digest] constructed using SHA256 algorithm (key length < digest size)', () {
      // Arrange
      Uint8List actualHMACKey = base64Decode('Qml0Y29pbiBzZWVk');
      List<Uint8List> actualDataChunks = <Uint8List>[
        base64Decode('RE9HRQ=='),
        base64Decode('V0lMTA=='),
        base64Decode('UFVNUA=='),
        base64Decode('U09PTg==')
      ];

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha256(), key: actualHMACKey).processChunks(actualDataChunks);

      // Assert
      Uint8List expectedHMACResult = base64Decode('7uihKHgHk+0F3U6SLKY0bkDMOXM8sypysER56JBcH5E=');

      expect(actualHMACResult, expectedHMACResult);
    });

    test('Should [return HMAC digest] constructed using SHA256 algorithm (key length == digest size)', () {
      // Arrange
      Uint8List actualHMACKey = base64Decode('BucEJucuy4B7Xo9OvwvDO0Z3HokXk3DjIQC51BiJGdU=');
      List<Uint8List> actualDataChunks = <Uint8List>[
        base64Decode('RE9HRQ=='),
        base64Decode('V0lMTA=='),
        base64Decode('UFVNUA=='),
        base64Decode('U09PTg==')
      ];

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha256(), key: actualHMACKey).processChunks(actualDataChunks);

      // Assert
      Uint8List expectedHMACResult = base64Decode('XvKsFtyfohW5qhl46GezrMqKHGLP1i9LZ8HBRcmW5cA=');

      expect(actualHMACResult, expectedHMACResult);
    });

    test('Should [return HMAC digest] constructed using SHA256 algorithm (key length > digest size)', () {
      // Arrange
      Uint8List actualHMACKey = base64Decode(
          'ZXhjbHVkZSB3ZXN0IG5vYmxlIHB1cml0eSBiZXlvbmQgaWxsbmVzcyBzb3VwIHJlc2VtYmxlIGF0b20gb2J2aW91cyBtZXRob2QgZmVzdGl2YWwgbmFtZSBpZGVudGlmeSBlbGVwaGFudCBzYXRpc2Z5IHdlZGRpbmcgaG9uZXkgY2VydGFpbiB0b2UgZXJvZGU=');
      List<Uint8List> actualDataChunks = <Uint8List>[
        base64Decode('RE9HRQ=='),
        base64Decode('V0lMTA=='),
        base64Decode('UFVNUA=='),
        base64Decode('U09PTg==')
      ];

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha256(), key: actualHMACKey).processChunks(actualDataChunks);

      // Assert
      Uint8List expectedHMACResult = base64Decode('XvKsFtyfohW5qhl46GezrMqKHGLP1i9LZ8HBRcmW5cA=');

      expect(actualHMACResult, expectedHMACResult);
    });

    // ********************************************************************************************************

    test('Should [return HMAC digest] constructed using SHA512 algorithm (key length < digest size)', () {
      // Arrange
      Uint8List actualHMACKey = base64Decode('Qml0Y29pbiBzZWVk');
      List<Uint8List> actualDataChunks = <Uint8List>[
        base64Decode('RE9HRQ=='),
        base64Decode('V0lMTA=='),
        base64Decode('UFVNUA=='),
        base64Decode('U09PTg==')
      ];

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha512(), key: actualHMACKey).processChunks(actualDataChunks);

      // Assert
      Uint8List expectedHMACResult = base64Decode('eEpNI3pCXfnKPZ8jEXJTmKl1hJDoiEHl66YCHD9q4f7KULIwqrfw3FMraqHhfObTv692Kmans1yNHwkVG//v/g==');

      expect(actualHMACResult, expectedHMACResult);
    });

    test('Should [return HMAC digest] constructed using SHA512 algorithm (key length == digest size)', () {
      // Arrange
      Uint8List actualHMACKey = base64Decode('YLx7mbfIG2DJhqGhJdI0TgJGcDPyouYG/jURk8BZNr5N706v+vpVknd9X4as7jVrOkgBHFOkLmWuGSdWXTkqLw==');
      List<Uint8List> actualDataChunks = <Uint8List>[
        base64Decode('RE9HRQ=='),
        base64Decode('V0lMTA=='),
        base64Decode('UFVNUA=='),
        base64Decode('U09PTg==')
      ];

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha512(), key: actualHMACKey).processChunks(actualDataChunks);

      // Assert
      Uint8List expectedHMACResult = base64Decode('30yTALZp0ra21ujiDOOFLf56WpOXeBrWL+Bg/LQLw7y1mgncKn9rRwX3whAiQ8miZWNNnVmM9vjMFE1OFmU/EA==');

      expect(actualHMACResult, expectedHMACResult);
    });

    test('Should [return HMAC digest] constructed using SHA512 algorithm (key length > digest size)', () {
      // Arrange
      Uint8List actualHMACKey = base64Decode(
          'ZXhjbHVkZSB3ZXN0IG5vYmxlIHB1cml0eSBiZXlvbmQgaWxsbmVzcyBzb3VwIHJlc2VtYmxlIGF0b20gb2J2aW91cyBtZXRob2QgZmVzdGl2YWwgbmFtZSBpZGVudGlmeSBlbGVwaGFudCBzYXRpc2Z5IHdlZGRpbmcgaG9uZXkgY2VydGFpbiB0b2UgZXJvZGU=');
      List<Uint8List> actualDataChunks = <Uint8List>[
        base64Decode('RE9HRQ=='),
        base64Decode('V0lMTA=='),
        base64Decode('UFVNUA=='),
        base64Decode('U09PTg==')
      ];

      // Act
      Uint8List actualHMACResult = HMAC(hash: Sha512(), key: actualHMACKey).processChunks(actualDataChunks);

      // Assert
      Uint8List expectedHMACResult = base64Decode('30yTALZp0ra21ujiDOOFLf56WpOXeBrWL+Bg/LQLw7y1mgncKn9rRwX3whAiQ8miZWNNnVmM9vjMFE1OFmU/EA==');

      expect(actualHMACResult, expectedHMACResult);
    });
  });

  group('Tests of HMAC.update() method and HMAC.digest getter', () {
    group('Tests for SHA256 algorithm (key length < digest size)', () {
      Uint8List actualHMACKey = base64Decode('Qml0Y29pbiBzZWVk');
      HMAC actualHMAC = HMAC(hash: Sha256(), key: actualHMACKey);

      test('Should [return HMAC digest] constructed using SHA256 algorithm (empty chunks)', () {
        // Act
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('Em3Iv1QKPUpCHSzc6aBBMrlOxI0i5nLd2XCkzMpb42U=');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (1st chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('RE9HRQ==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('hf6k/W5HSP1bor1Zbrlymsbgd/p9i/uEDkeXkxMtOa4=');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (2nd chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('V0lMTA==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('yDKTCTlfNROblKdTGeta2EV7C+C+x3/luBF4Qmoq/Tk=');

        expect(actualHMACResult, expectedHMACResult);
      });
    });

    group('Tests for SHA256 algorithm (key length == digest size)', () {
      Uint8List actualHMACKey = base64Decode('BucEJucuy4B7Xo9OvwvDO0Z3HokXk3DjIQC51BiJGdU=');
      HMAC actualHMAC = HMAC(hash: Sha256(), key: actualHMACKey);

      test('Should [return HMAC digest] constructed using SHA256 algorithm (empty chunks)', () {
        // Act
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('Pcpjs9WTMBX0EJsCOMUkmI0VoP3rt3TIZiWIJgMCU7s=');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (1st chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('RE9HRQ==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('IZnchVjQWoytlo2RYj7e+BVDHHm69MVhMG0E9aTBMA4=');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (2nd chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('V0lMTA==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('tu0Du07BC3qNymh31bSzHtupZn1Ufn5KUVdXq7ZtMvg=');

        expect(actualHMACResult, expectedHMACResult);
      });
    });

    group('Tests for SHA256 algorithm (key length > digest size)', () {
      Uint8List actualHMACKey = base64Decode(
          'ZXhjbHVkZSB3ZXN0IG5vYmxlIHB1cml0eSBiZXlvbmQgaWxsbmVzcyBzb3VwIHJlc2VtYmxlIGF0b20gb2J2aW91cyBtZXRob2QgZmVzdGl2YWwgbmFtZSBpZGVudGlmeSBlbGVwaGFudCBzYXRpc2Z5IHdlZGRpbmcgaG9uZXkgY2VydGFpbiB0b2UgZXJvZGU=');
      HMAC actualHMAC = HMAC(hash: Sha256(), key: actualHMACKey);

      test('Should [return HMAC digest] constructed using SHA256 algorithm (empty chunks)', () {
        // Act
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('Pcpjs9WTMBX0EJsCOMUkmI0VoP3rt3TIZiWIJgMCU7s=');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (1st chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('RE9HRQ==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('IZnchVjQWoytlo2RYj7e+BVDHHm69MVhMG0E9aTBMA4=');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (2nd chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('V0lMTA==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('tu0Du07BC3qNymh31bSzHtupZn1Ufn5KUVdXq7ZtMvg=');

        expect(actualHMACResult, expectedHMACResult);
      });
    });

    // ********************************************************************************************************

    group('Tests for SHA512 algorithm (key length < digest size)', () {
      Uint8List actualHMACKey = base64Decode('Qml0Y29pbiBzZWVk');
      HMAC actualHMAC = HMAC(hash: Sha512(), key: actualHMACKey);

      test('Should [return HMAC digest] constructed using SHA256 algorithm (empty chunks)', () {
        // Act
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('MAsVX3UZZCdsBTYjC9mxb+eoZTPDy6p1dejQQx2+3yP5lFu4sFK9CwgCwQx8hS53ZbabYc5yM9n+WjWrEIyjtg==');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (1st chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('RE9HRQ==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('7/zrzSVoW/6yfkF2YprgfP4ePi45i6UclC1U6VMGh+cvyES9yPPF25Krg3oAZ6NrfVELjk0y+5caflPPbOXxpA==');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (2nd chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('V0lMTA==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('KXWCvsfhsuEfg9gg8X/GGCqwEZkA2LhlkyV/c1HZwOsNNSrYpcbt1uUCfWAeHOp4Ug7YOBnBtdB1lcMt7AWIqA==');

        expect(actualHMACResult, expectedHMACResult);
      });
    });

    group('Tests for SHA512 algorithm (key length == digest size)', () {
      Uint8List actualHMACKey = base64Decode('YLx7mbfIG2DJhqGhJdI0TgJGcDPyouYG/jURk8BZNr5N706v+vpVknd9X4as7jVrOkgBHFOkLmWuGSdWXTkqLw==');
      HMAC actualHMAC = HMAC(hash: Sha512(), key: actualHMACKey);

      test('Should [return HMAC digest] constructed using SHA256 algorithm (empty chunks)', () {
        // Act
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('aAlFiZrIWpxmtdjoSnAR4gMyl+Wuklzy/C8kzd2FVatW28IbUk7ut8mecaJH+rBQV16Uj0SKW08NtUTDgXPnZA==');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (1st chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('RE9HRQ==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('55F8UrilddQzPXb+Lz+2xvaFLhd+rCq8Hnzj5KLqkTlmKsUlocfaRXm5L/1wzSkbp22o/87YDzVkHTa+DMDgIA==');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (2nd chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('V0lMTA==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('aJpE6XPRfzYe6H9641BSRnTAwLX48gcx8UeHR9NOP8bpJFFAuSKGvTBk7hYOGXgvFzC32d4XJyORz/mint7QOw==');

        expect(actualHMACResult, expectedHMACResult);
      });
    });

    group('Tests for SHA512 algorithm (key length > digest size)', () {
      Uint8List actualHMACKey = base64Decode(
          'ZXhjbHVkZSB3ZXN0IG5vYmxlIHB1cml0eSBiZXlvbmQgaWxsbmVzcyBzb3VwIHJlc2VtYmxlIGF0b20gb2J2aW91cyBtZXRob2QgZmVzdGl2YWwgbmFtZSBpZGVudGlmeSBlbGVwaGFudCBzYXRpc2Z5IHdlZGRpbmcgaG9uZXkgY2VydGFpbiB0b2UgZXJvZGU=');
      HMAC actualHMAC = HMAC(hash: Sha512(), key: actualHMACKey);

      test('Should [return HMAC digest] constructed using SHA256 algorithm (empty chunks)', () {
        // Act
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('aAlFiZrIWpxmtdjoSnAR4gMyl+Wuklzy/C8kzd2FVatW28IbUk7ut8mecaJH+rBQV16Uj0SKW08NtUTDgXPnZA==');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (1st chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('RE9HRQ==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('55F8UrilddQzPXb+Lz+2xvaFLhd+rCq8Hnzj5KLqkTlmKsUlocfaRXm5L/1wzSkbp22o/87YDzVkHTa+DMDgIA==');

        expect(actualHMACResult, expectedHMACResult);
      });

      test('Should [return HMAC digest] constructed using SHA256 algorithm (2nd chunk)', () {
        // Arrange
        Uint8List actualDataToHash = base64Decode('V0lMTA==');

        // Act
        actualHMAC.update(actualDataToHash);
        Uint8List actualHMACResult = actualHMAC.digest;

        // Assert
        Uint8List expectedHMACResult = base64Decode('aJpE6XPRfzYe6H9641BSRnTAwLX48gcx8UeHR9NOP8bpJFFAuSKGvTBk7hYOGXgvFzC32d4XJyORz/mint7QOw==');

        expect(actualHMACResult, expectedHMACResult);
      });
    });
  });
}
