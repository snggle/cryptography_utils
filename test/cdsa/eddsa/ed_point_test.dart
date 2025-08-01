import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EDPoint.fromBytes() constructor', () {
    test('Should [return EDPoint] from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA=');

      // Act
      EDPoint actualEDPoint = EDPoint.fromBytes(CurvePoints.generatorED25519, actualBytes);

      // Assert
      EDPoint expectedEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('36296584640568705578765211864789903326726128726082628951800433550187951947162'),
        y: BigInt.parse('21722763853247575927517928451216332729805032358530396811928860500080504648297'),
        z: BigInt.one,
        t: BigInt.parse(
            '788462136826487035517522181628529984945326118901391734773631962347443138612680071187232142979650154875261951270767071733362165107888869070753013137283114'),
      );

      expect(actualEDPoint, expectedEDPoint);
    });

    test('Should [throw Exception] if [private key bytes length != 32] (length < 32)', () {
      // Arrange
      Uint8List actualBytes = Uint8List(31);

      // Assert
      expect(
        () => EDPoint.fromBytes(CurvePoints.generatorED25519, actualBytes),
        throwsA(isA<FormatException>()),
      );
    });

    test('Should [throw Exception] if [private key bytes length != 32] (length > 32)', () {
      // Arrange
      Uint8List actualBytes = Uint8List(33);

      // Assert
      expect(
        () => EDPoint.fromBytes(CurvePoints.generatorED25519, actualBytes),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('Tests of EDPoint.infinityFrom() constructor', () {
    test('Should [return infinity EDPoint] basing on other EDPoint params (curve and order)', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      EDPoint actualInfinityEDPoint = EDPoint.infinityFrom(actualEDPoint);

      // Assert
      EDPoint expectedInfinityEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.zero,
        t: BigInt.zero,
      );

      expect(actualInfinityEDPoint, expectedInfinityEDPoint);
    });
  });

  group('Tests of EDPoint - (negation) operator overload', () {
    test('Should [return EDPoint] with negated y coordinate', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      EDPoint actualNegatedEDPoint = -actualEDPoint;

      // Assert
      EDPoint expectedNegatedEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('-19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('-18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      expect(actualNegatedEDPoint, expectedNegatedEDPoint);
    });
  });

  group('Tests of EDPoint + (addition) operator overload', () {
    test('Should [return EDPoint] sum of given EDPoint', () {
      // Arrange
      EDPoint actualFirstEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      EDPoint actualSecondEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('6096909168845075289895766140667470516872676772040305287224409768025240085365'),
        y: BigInt.parse('26827353303075333452492487487417802419667623484019508509947057840019676335990'),
        z: BigInt.parse('34167211617719735327647555959431506547296161705475459783750089478168360658532'),
        t: BigInt.parse('46277596158329281260802852912934565824330399740884467667771483970460031540457'),
      );

      // Act
      EDPoint actualSumEDPoint = actualFirstEDPoint + actualSecondEDPoint;

      // Assert
      EDPoint expectedSumEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('31526783872771802866845889330755663428311874124493638537576632137069217592509'),
        y: BigInt.parse('48629464835436797222907152574229008341263093550785796383013624914972494502600'),
        z: BigInt.parse('333800734235119114968985188976990598100047827976359596122448946415405085008'),
        t: BigInt.parse('36042969637043635775808115931322878445759837817669436253876818904907009351091'),
      );

      expect(actualSumEDPoint, expectedSumEDPoint);
    });
  });

  group('Tests of EDPoint * (multiplication) operator overload', () {
    test('Should [return EDPoint] multiplied by given scalar', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      EDPoint actualMultipliedEDPoint = actualEDPoint * BigInt.parse('52296706698976945379478339393009008515096998632529786687805880390877129570304');

      // Assert
      EDPoint expectedMultipliedEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('51244919994351172387417348510608637925235608054940772592337648463674609760537'),
        y: BigInt.parse('35449132413827682982386728877599892602830155330348740731324917440722313036655'),
        z: BigInt.parse('7168729421692682075928873541290169440201662592510102281021726379451957383384'),
        t: BigInt.parse('27233844124704309868588251123744664512193349282150838965396361685047483783056'),
      );

      expect(actualMultipliedEDPoint, expectedMultipliedEDPoint);
    });

    test('Should [return infinity EDPoint] if given [scalar == 0]', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      EDPoint actualMultipliedEDPoint = actualEDPoint * BigInt.zero;

      // Assert
      EDPoint expectedMultipliedEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.zero,
        t: BigInt.zero,
      );

      expect(actualMultipliedEDPoint, expectedMultipliedEDPoint);
    });

    test('Should [return infinity EDPoint] if multiplied EDPoint has [x == 0]', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      EDPoint actualMultipliedEDPoint = actualEDPoint * BigInt.parse('52296706698976945379478339393009008515096998632529786687805880390877129570304');

      // Assert
      EDPoint expectedMultipliedEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.zero,
        t: BigInt.zero,
      );

      expect(actualMultipliedEDPoint, expectedMultipliedEDPoint);
    });

    test('Should [return infinity EDPoint] if multiplied EDPoint has [y == 0]', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.zero,
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      EDPoint actualMultipliedEDPoint = actualEDPoint * BigInt.parse('52296706698976945379478339393009008515096998632529786687805880390877129570304');

      // Assert
      EDPoint expectedMultipliedEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.zero,
        t: BigInt.zero,
      );

      expect(actualMultipliedEDPoint, expectedMultipliedEDPoint);
    });

    test('Should [return EDPoint] without changes if given [scalar == 1]', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      EDPoint actualMultipliedEDPoint = actualEDPoint * BigInt.one;

      // Assert
      EDPoint expectedMultipliedEDPoint = actualEDPoint;

      expect(actualMultipliedEDPoint, expectedMultipliedEDPoint);
    });
  });

  group('Tests of EDPoint.toBytes()', () {
    test('Should [return bytes] from given EDPoint', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Uint8List actualBytes = actualEDPoint.toBytes();

      // Assert
      Uint8List expectedBytes = base64Decode('z7Dbiwy9pzyyNc8VrMNqmdssCM0tlKxB9Yk8umwbYwc=');

      expect(actualBytes, expectedBytes);
    });
  });

  group('Tests of EDPoint.scaleToAffineCoordinates()', () {
    test('Should [return EDPoint] scaled to affine coordinates', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      EDPoint actualAffineEDPoint = actualEDPoint.scaleToAffineCoordinates();

      // Assert
      EDPoint expectedAffineEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('54065565874754690464541746979170565753169877194888053393545030920551520745988'),
        y: BigInt.parse('3341297077934518673457142734077350879420471371059900657313532910747302736079'),
        z: BigInt.one,
        t: BigInt.parse('17889545404307743854678190178496636156195764849150499252736625982701909100111'),
      );

      expect(actualAffineEDPoint, expectedAffineEDPoint);
    });

    test('Should [return EDPoint] without changes if given point is already affine point (z == 1)', () {
      // Arrange
      EDPoint actualEDPoint = EDPoint(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('54065565874754690464541746979170565753169877194888053393545030920551520745988'),
        y: BigInt.parse('3341297077934518673457142734077350879420471371059900657313532910747302736079'),
        z: BigInt.one,
        t: BigInt.parse('17889545404307743854678190178496636156195764849150499252736625982701909100111'),
      );

      // Act
      EDPoint actualScaledEDPoint = actualEDPoint.scaleToAffineCoordinates();

      // Assert
      EDPoint expectedScaledEDPoint = actualEDPoint;

      expect(actualScaledEDPoint, expectedScaledEDPoint);
    });
  });
}
