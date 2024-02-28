import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SvgCircle.draw()', () {
    test('Should [update SvgPath] with circle data (invert == false)', () {
      // Arrange
      SvgCircle actualSvgCircle = const SvgCircle(
        fill: '#fff',
        point: Point<double>(0, 0),
        diameter: 10,
        invert: false,
      );
      SvgPath actualSvgPath = SvgPath();

      // Act
      actualSvgCircle.draw(actualSvgPath);
      String actualDataString = actualSvgPath.dataString;

      // Assert
      String expectedDataString = 'M0.0 5.0a5,5 0 1,1 10 ,0a5,5 0 1,1 -10,0';

      expect(actualDataString, expectedDataString);
    });

    test('Should [update SvgPath] with circle data (invert == true)', () {
      // Arrange
      SvgCircle actualSvgCircle = const SvgCircle(
        fill: '#fff',
        point: Point<double>(0, 0),
        diameter: 10,
        invert: true,
      );
      SvgPath actualSvgPath = SvgPath();

      // Act
      actualSvgCircle.draw(actualSvgPath);
      String actualDataString = actualSvgPath.dataString;

      // Assert
      String expectedDataString = 'M0.0 5.0a5,5 0 1,0 10 ,0a5,5 0 1,0 -10,0';

      expect(actualDataString, expectedDataString);
    });
  });

  group('Tests of SvgCircle.transform()', () {
    test('Should [return SvgCircle] with updated values', () {
      // Arrange
      SvgCircle actualSvgCircle = const SvgCircle(
        fill: '#fff',
        point: Point<double>(0, 0),
        diameter: 10,
        invert: false,
      );

      SvgTransformation actualSvgTransformation = SvgTransformation(x: 100, y: 100, size: 50, rotation: 3);

      // Act
      SvgCircle actualTransformedSvgCircle = actualSvgCircle.transform(actualSvgTransformation);

      // Assert
      SvgCircle expectedTransformedSvgCircle = const SvgCircle(
        fill: '#fff',
        point: Point<double>(100, 140),
        diameter: 10,
        invert: false,
      );

      expect(actualTransformedSvgCircle, expectedTransformedSvgCircle);
    });
  });
}
