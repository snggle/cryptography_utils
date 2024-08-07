import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  ECCurve actualECCurve = ECCurve(
    a: BigInt.zero,
    b: BigInt.from(7),
    h: BigInt.one,
    p: BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007908834671663'),
  );

  group('Tests of ECPoint.infinityFrom() constructor', () {
    test('Should [return infinity ECPoint] basing on other ECPoint params (curve and order)', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798', radix: 16),
        y: BigInt.parse('483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8', radix: 16),
        z: BigInt.one,
      );

      // Act
      ECPoint actualInfinityECPoint = ECPoint.infinityFrom(actualECPoint);

      // Assert
      ECPoint expectedInfinityECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.one,
      );

      expect(actualInfinityECPoint, expectedInfinityECPoint);
    });
  });

  group('Tests of ECPoint.fromCompressedBytes() constructor', () {
    test('Should [return ECPoint] from [COMPRESSED bytes]', () {
      // Arrange
      Uint8List actualCompressedBytes = base64Decode('Ar+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2Yj');

      // Act
      ECPoint actualECPoint = ECPoint.fromCompressedBytes(actualCompressedBytes, CurvePoints.generatorSecp256k1);

      // Assert
      ECPoint expectedECPoint = ECPoint(
        curve: Curves.secp256k1,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      expect(actualECPoint, expectedECPoint);
    });
  });

  group('Tests of ECPoint.fromUncompressedBytes() constructor', () {
    test('Should [return ECPoint] from [UNCOMPRESSED bytes]', () {
      // Arrange
      Uint8List actualUncompressedBytes = base64Decode('v60uhBRqswcGVa3Zge+F4J6uG8GLdVpwnJrxc1THZiNF2HjK8gm8RXiyE3BzH9skj5ZSZ7cMZ/LVK5GUGY8Dig==');

      // Act
      ECPoint actualECPoint = ECPoint.fromUncompressedBytes(actualUncompressedBytes, CurvePoints.generatorSecp256k1);

      // Assert
      ECPoint expectedECPoint = ECPoint(
        curve: Curves.secp256k1,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      expect(actualECPoint, expectedECPoint);
    });
  });

  group('Tests of ECPoint - (negation) operator overload', () {
    test('Should [return ECPoint] with negated y coordinate', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      ECPoint actualNegatedECPoint = -actualECPoint;

      // Assert
      ECPoint expectedNegatedECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('-93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      expect(actualNegatedECPoint, expectedNegatedECPoint);
    });
  });

  group('Tests of ECPoint + (addition) operator overload', () {
    test('Should [return ECPoint] sum of given ECPoints', () {
      // Arrange
      ECPoint actualFirstECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      ECPoint actualSecondECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('52659634787550369708387590610632544125095539949942882538329891106798572607270'),
        y: BigInt.parse('107331144082566646093235576885864105124833962202338653524803423955903371062333'),
        z: BigInt.parse('23104110703327938328957906634340614657838296092781414960111073621683973006153'),
      );

      // Act
      ECPoint actualSumECPoint = actualFirstECPoint + actualSecondECPoint;

      // Assert
      ECPoint expectedSumECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('56124643589193828311348139181133800272399982504860169858574840461571348240135'),
        y: BigInt.parse('96258183351617509499000162914775031929271321389308228787763197868637048825816'),
        z: BigInt.parse('83159735987557243322677977689952171355210031557799080413077468406682155599130'),
      );

      expect(actualSumECPoint, expectedSumECPoint);
    });

    test('Should [return SECOND ECPoint] if FIRST point is an infinity point', () {
      // Arrange
      ECPoint firstECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.zero,
      );

      ECPoint secondECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('52659634787550369708387590610632544125095539949942882538329891106798572607270'),
        y: BigInt.parse('107331144082566646093235576885864105124833962202338653524803423955903371062333'),
        z: BigInt.parse('23104110703327938328957906634340614657838296092781414960111073621683973006153'),
      );

      // Act
      ECPoint actualSumECPoint = firstECPoint + secondECPoint;

      // Assert
      ECPoint expectedSumECPoint = secondECPoint;

      expect(actualSumECPoint, expectedSumECPoint);
    });

    test('Should [return FIRST ECPoint] if SECOND point is an infinity point', () {
      // Arrange
      ECPoint firstECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      ECPoint secondECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('52659634787550369708387590610632544125095539949942882538329891106798572607270'),
        y: BigInt.parse('107331144082566646093235576885864105124833962202338653524803423955903371062333'),
        z: BigInt.zero,
      );

      // Act
      ECPoint actualSumECPoint = firstECPoint + secondECPoint;

      // Assert
      ECPoint expectedSumECPoint = firstECPoint;

      expect(actualSumECPoint, expectedSumECPoint);
    });
  });

  group('Tests of ECPoint * (multiplication) operator overload', () {
    test('Should [return ECPoint] multiplied by given scalar', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      ECPoint actualMultipliedECPoint = actualECPoint * BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643');

      // Assert
      ECPoint expectedMultipliedECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('52659634787550369708387590610632544125095539949942882538329891106798572607270'),
        y: BigInt.parse('107331144082566646093235576885864105124833962202338653524803423955903371062333'),
        z: BigInt.parse('23104110703327938328957906634340614657838296092781414960111073621683973006153'),
      );

      expect(actualMultipliedECPoint, expectedMultipliedECPoint);
    });

    test('Should [return infinity ECPoint] if given [scalar == 0]', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      ECPoint actualMultipliedECPoint = actualECPoint * BigInt.zero;

      // Assert
      ECPoint expectedMultipliedECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.one,
      );

      expect(actualMultipliedECPoint, expectedMultipliedECPoint);
    });

    test('Should [return infinity ECPoint] if multiplied ECPoint has [y == 0]', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.zero,
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      ECPoint actualMultipliedECPoint = actualECPoint * BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643');

      // Assert
      ECPoint expectedMultipliedECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.zero,
        y: BigInt.zero,
        z: BigInt.one,
      );

      expect(actualMultipliedECPoint, expectedMultipliedECPoint);
    });

    test('Should [return ECPoint] without changes if given [scalar == 1]', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      ECPoint actualMultipliedECPoint = actualECPoint * BigInt.one;

      // Assert
      ECPoint expectedMultipliedECPoint = actualECPoint;

      expect(actualMultipliedECPoint, expectedMultipliedECPoint);
    });
  });

  group('Tests of ECPoint.affineX getter', () {
    test('Should [return affine x-coordinate] as affine point coordinate, constructed from projective x-coordinate', () {
      // Arrange
      ECPoint actualFirstECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      BigInt actualAffineX = actualFirstECPoint.affineX;

      // Assert
      BigInt expectedAffineX = BigInt.parse('86697739662805592488286616159167625604680832438313215935278308332575792784931');

      expect(actualAffineX, expectedAffineX);
    });

    test('Should [return current x-coordinate] if ECPoint already is affine point', () {
      // Arrange
      ECPoint actualFirstECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.one,
      );

      // Act
      BigInt actualAffineX = actualFirstECPoint.affineX;

      // Assert
      BigInt expectedAffineX = BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309');

      expect(actualAffineX, expectedAffineX);
    });
  });

  group('Tests of ECPoint.affineY getter', () {
    test('Should [return affine y-coordinate] as affine point coordinate, constructed from projective y-coordinate', () {
      // Arrange
      ECPoint actualFirstECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      BigInt actualAffineY = actualFirstECPoint.affineY;

      // Assert
      BigInt expectedAffineY = BigInt.parse('31592059199197932954509690057511721189614655546517111952787324431078282691466');

      expect(actualAffineY, expectedAffineY);
    });

    test('Should [return current y-coordinate] if ECPoint already is affine point', () {
      // Arrange
      ECPoint actualFirstECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.one,
      );

      // Act
      BigInt actualAffineY = actualFirstECPoint.affineY;

      // Assert
      BigInt expectedAffineY = BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966');

      expect(actualAffineY, expectedAffineY);
    });
  });

  group('Tests of ECPoint.isInfinity getter', () {
    test('Should [return TRUE] if point has [y == 0]', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('0'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      bool actualInfinityBool = actualECPoint.isInfinity;

      // Assert
      expect(actualInfinityBool, true);
    });

    test('Should [return TRUE] if point has [z == 0]', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('0'),
      );

      // Act
      bool actualInfinityBool = actualECPoint.isInfinity;

      // Assert
      expect(actualInfinityBool, true);
    });

    test('Should [return FALSE] if point has [y POSITIVE] and [z != 0]', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      bool actualInfinityBool = actualECPoint.isInfinity;

      // Assert
      expect(actualInfinityBool, false);
    });

    test('Should [return FALSE] if point has [y NEGATIVE] and [z != 0]', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('-93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      bool actualInfinityBool = actualECPoint.isInfinity;

      // Assert
      expect(actualInfinityBool, false);
    });

    test('Should [return FALSE] if point has [x == 0] and [y != 0] and [z != 0]', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.zero,
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      bool actualInfinityBool = actualECPoint.isInfinity;

      // Assert
      expect(actualInfinityBool, false);
    });

    test('Should [return FALSE] if point has [n == 0] and [y != 0] and [z != 0]', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.zero,
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      bool actualInfinityBool = actualECPoint.isInfinity;

      // Assert
      expect(actualInfinityBool, false);
    });
  });

  group('Tests of ECPoint.toBytes()', () {
    test('Should [return COMPRESSED bytes] from given ECPoint', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      Uint8List actualCompressedBytes = actualECPoint.toBytes(compressedBool: true);

      // Assert
      Uint8List expectedCompressedBytes = base64Decode('Ar+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2Yj');

      expect(actualCompressedBytes, expectedCompressedBytes);
    });

    test('Should [return UNCOMPRESSED bytes] from given ECPoint', () {
      // Arrange
      ECPoint actualECPoint = ECPoint(
        curve: actualECCurve,
        n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
        x: BigInt.parse('109809582697629541179477143463768131161650648020283737506803606109779771350309'),
        y: BigInt.parse('93904199375389538639503047221917403320671286887529822165996195593332713512966'),
        z: BigInt.parse('15114296647857780461657875995579731758281183768828053400819025202844531705682'),
      );

      // Act
      Uint8List actualCompressedBytes = actualECPoint.toBytes(compressedBool: false);

      // Assert
      Uint8List expectedCompressedBytes = base64Decode('BL+tLoQUarMHBlWt2YHvheCerhvBi3VacJya8XNUx2YjRdh4yvIJvEV4shNwcx/bJI+WUme3DGfy1SuRlBmPA4o=');

      expect(actualCompressedBytes, expectedCompressedBytes);
    });
  });
}
