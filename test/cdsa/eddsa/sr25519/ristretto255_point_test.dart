import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Ristretto255Point.fromBytes constructor', () {
    test('Should [return Ristretto255Point] from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode('abIMh62tm/MyZmOQVNz7uNdqfIgBr/ye5o6n8QymBjA=');

      // Act
      Ristretto255Point actualRistretto255Point = Ristretto255Point.fromBytes(CurvePoints.generatorED25519, actualBytes);

      // Assert
      Ristretto255Point expectedRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('36296584640568705578765211864789903326726128726082628951800433550187951947162'),
        y: BigInt.parse('21722763853247575927517928451216332729805032358530396811928860500080504648297'),
        z: BigInt.one,
        t: BigInt.parse(
            '788462136826487035517522181628529984945326118901391734773631962347443138612680071187232142979650154875261951270767071733362165107888869070753013137283114'),
      );

      expect(actualRistretto255Point, expectedRistretto255Point);
    });
  });

  group('Tests of Ristretto255Point.infinityFrom constructor', () {
    test('Should [return infinity Ristretto255Point] basing on other Ristretto255Point params (curve and order)', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Ristretto255Point actualInfinityRistretto255Point = Ristretto255Point.infinityFrom(actualRistretto255Point);

      // Assert
      Ristretto255Point expectedInfinityRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.zero,
        t: BigInt.zero,
      );

      expect(actualInfinityRistretto255Point, expectedInfinityRistretto255Point);
    });
  });

  group('Tests of Ristretto255Point - (negation) operator overload', () {
    test('Should [return Ristretto255Point] with negated y coordinate', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Ristretto255Point actualNegatedRistretto255Point = -actualRistretto255Point;

      // Assert
      Ristretto255Point expectedNegatedRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('-19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('-18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      expect(actualNegatedRistretto255Point, expectedNegatedRistretto255Point);
    });
  });

  group('Tests of Ristretto255Point + (addition) operator overload', () {
    test('Should [return Ristretto255Point] sum of given Ristretto255Point', () {
      // Arrange
      Ristretto255Point actualFirstRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      Ristretto255Point actualSecondRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('6096909168845075289895766140667470516872676772040305287224409768025240085365'),
        y: BigInt.parse('26827353303075333452492487487417802419667623484019508509947057840019676335990'),
        z: BigInt.parse('34167211617719735327647555959431506547296161705475459783750089478168360658532'),
        t: BigInt.parse('46277596158329281260802852912934565824330399740884467667771483970460031540457'),
      );

      // Act
      Ristretto255Point actualSumRistretto255Point = actualFirstRistretto255Point + actualSecondRistretto255Point;

      // Assert
      Ristretto255Point expectedSumRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('31526783872771802866845889330755663428311874124493638537576632137069217592509'),
        y: BigInt.parse('48629464835436797222907152574229008341263093550785796383013624914972494502600'),
        z: BigInt.parse('333800734235119114968985188976990598100047827976359596122448946415405085008'),
        t: BigInt.parse('36042969637043635775808115931322878445759837817669436253876818904907009351091'),
      );

      expect(actualSumRistretto255Point, expectedSumRistretto255Point);
    });
  });

  group('Tests of Ristretto255Point * (multiplication) operator overload', () {
    test('Should [return Ristretto255Point] multiplied by given scalar', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Ristretto255Point actualMultipliedRistretto255Point =
          actualRistretto255Point * BigInt.parse('52296706698976945379478339393009008515096998632529786687805880390877129570304');

      // Assert
      Ristretto255Point expectedMultipliedRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('51244919994351172387417348510608637925235608054940772592337648463674609760537'),
        y: BigInt.parse('35449132413827682982386728877599892602830155330348740731324917440722313036655'),
        z: BigInt.parse('7168729421692682075928873541290169440201662592510102281021726379451957383384'),
        t: BigInt.parse('27233844124704309868588251123744664512193349282150838965396361685047483783056'),
      );

      expect(actualMultipliedRistretto255Point, expectedMultipliedRistretto255Point);
    });

    test('Should [return infinity Ristretto255Point] if given [scalar == 0]', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Ristretto255Point actualMultipliedRistretto255Point = actualRistretto255Point * BigInt.zero;

      // Assert
      Ristretto255Point expectedMultipliedRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.zero,
        t: BigInt.zero,
      );

      expect(actualMultipliedRistretto255Point, expectedMultipliedRistretto255Point);
    });

    test('Should [return infinity Ristretto255Point] if multiplied EDPoint has [x == 0]', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Ristretto255Point actualMultipliedRistretto255Point =
          actualRistretto255Point * BigInt.parse('52296706698976945379478339393009008515096998632529786687805880390877129570304');

      // Assert
      Ristretto255Point expectedMultipliedRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.zero,
        t: BigInt.zero,
      );

      expect(actualMultipliedRistretto255Point, expectedMultipliedRistretto255Point);
    });

    test('Should [return infinity Ristretto255Point] if multiplied EDPoint has [y == 0]', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.zero,
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Ristretto255Point actualMultipliedRistretto255Point =
          actualRistretto255Point * BigInt.parse('52296706698976945379478339393009008515096998632529786687805880390877129570304');

      // Assert
      Ristretto255Point expectedMultipliedRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.zero,
        t: BigInt.zero,
      );

      expect(actualMultipliedRistretto255Point, expectedMultipliedRistretto255Point);
    });

    test('Should [return Ristretto255Point] without changes if given [scalar == 1]', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Ristretto255Point actualMultipliedRistretto255Point = actualRistretto255Point * BigInt.one;

      // Assert
      Ristretto255Point expectedMultipliedRistretto255Point = actualRistretto255Point;

      expect(actualMultipliedRistretto255Point, expectedMultipliedRistretto255Point);
    });
  });

  group('Tests of Ristretto255Point.toBytes()', () {
    test('Should [return bytes] from given Ristretto255Point', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Uint8List actualBytes = actualRistretto255Point.toBytes();

      // Assert
      Uint8List expectedBytes = base64Decode('9KkFFVRriU9GWVYGHY70Kzuk1pS1/4yCqPW5PfsEWXw=');

      expect(actualBytes, expectedBytes);
    });
  });

  group('Tests of Ristretto255Point.scaleToAffineCoordinates()', () {
    test('Should [return Ristretto255Point] scaled to affine coordinates', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('19793122580953396643657614893737675412715271732516190437477497872396293476517'),
        y: BigInt.parse('11043535616153659670420426046812415327322207260394876224747641236324749531277'),
        z: BigInt.parse('52307325976996590356746334614254516249809358280279038039749391123110162041889'),
        t: BigInt.parse('18663140037355883143136513717086037971900193259991003799674694468591719114115'),
      );

      // Act
      Ristretto255Point actualAffineRistretto255Point = actualRistretto255Point.scaleToAffineCoordinates();

      // Assert
      Ristretto255Point expectedAffineRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('54065565874754690464541746979170565753169877194888053393545030920551520745988'),
        y: BigInt.parse('3341297077934518673457142734077350879420471371059900657313532910747302736079'),
        z: BigInt.one,
        t: BigInt.parse('17889545404307743854678190178496636156195764849150499252736625982701909100111'),
      );

      expect(actualAffineRistretto255Point, expectedAffineRistretto255Point);
    });

    test('Should [return Ristretto255Point] without changes if given point is already affine point (z == 1)', () {
      // Arrange
      Ristretto255Point actualRistretto255Point = Ristretto255Point(
        curve: Curves.ed25519,
        n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
        x: BigInt.parse('54065565874754690464541746979170565753169877194888053393545030920551520745988'),
        y: BigInt.parse('3341297077934518673457142734077350879420471371059900657313532910747302736079'),
        z: BigInt.one,
        t: BigInt.parse('17889545404307743854678190178496636156195764849150499252736625982701909100111'),
      );

      // Act
      Ristretto255Point actualScaledRistretto255Point = actualRistretto255Point.scaleToAffineCoordinates();

      // Assert
      Ristretto255Point expectedScaledRistretto255Point = actualRistretto255Point;

      expect(actualScaledRistretto255Point, expectedScaledRistretto255Point);
    });
  });
}
