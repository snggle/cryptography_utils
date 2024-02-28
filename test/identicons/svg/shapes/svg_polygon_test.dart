import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SvgPolygon constructors', () {
    group('Tests of SvgPolygon.rectangle()', () {
      test('Should [return SvgPolygon] representing Rectangle shape', () {
        // Act
        SvgPolygon actualSvgPolygon = SvgPolygon.rectangle(fill: '#fff', x: 0, y: 0, w: 10, h: 20);

        // Assert
        SvgPolygon expectedSvgPolygon = const SvgPolygon(
          fill: '#fff',
          points: <Point<double>>[
            Point<double>(0, 0),
            Point<double>(10, 0),
            Point<double>(10, 20),
            Point<double>(0, 20),
          ],
        );

        expect(actualSvgPolygon, expectedSvgPolygon);
      });
    });

    group('Tests of SvgPolygon.square()', () {
      test('Should [return SvgPolygon] representing Square shape', () {
        // Act
        SvgPolygon actualSvgPolygon = SvgPolygon.square(fill: '#fff', x: 0, y: 0, size: 10);

        // Assert
        SvgPolygon expectedSvgPolygon = const SvgPolygon(
          fill: '#fff',
          points: <Point<double>>[
            Point<double>(0, 0),
            Point<double>(10, 0),
            Point<double>(10, 10),
            Point<double>(0, 10),
          ],
        );

        expect(actualSvgPolygon, expectedSvgPolygon);
      });
    });

    group('Tests of SvgPolygon.rhombus()', () {
      test('Should [return SvgPolygon] representing Rhombus shape', () {
        // Act
        SvgPolygon actualSvgPolygon = SvgPolygon.rhombus(fill: '#fff', x: 0, y: 0, w: 10, h: 20);

        // Assert
        SvgPolygon expectedSvgPolygon = const SvgPolygon(
          fill: '#fff',
          points: <Point<double>>[
            Point<double>(5, 0),
            Point<double>(10, 10),
            Point<double>(5, 20),
            Point<double>(0, 10),
          ],
        );

        expect(actualSvgPolygon, expectedSvgPolygon);
      });
    });

    group('Tests of SvgPolygon.triangle()', () {
      test('Should [return SvgPolygon] representing Triangle shape', () {
        // Act
        SvgPolygon actualSvgPolygon = SvgPolygon.triangle(fill: '#fff', x: 0, y: 0, w: 10, h: 20, r: 0);

        // Assert
        SvgPolygon expectedSvgPolygon = const SvgPolygon(
          fill: '#fff',
          points: <Point<double>>[
            Point<double>(10, 20),
            Point<double>(0, 20),
            Point<double>(0, 0),
          ],
        );

        expect(actualSvgPolygon, expectedSvgPolygon);
      });
    });
  });

  group('Tests of SvgPolygon.draw()', () {
    test('Should [update SvgPath] with polygon data', () {
      // Arrange
      SvgPolygon actualSvgPolygon = const SvgPolygon(
        fill: '#fff',
        points: <Point<double>>[
          Point<double>(10, 20),
          Point<double>(0, 20),
          Point<double>(0, 0),
        ],
      );
      SvgPath actualSvgPath = SvgPath();

      // Act
      actualSvgPolygon.draw(actualSvgPath);
      String actualDataString = actualSvgPath.dataString;

      // Assert
      String expectedDataString = 'M10.0 20.0L10.0 20.0L0.0 20.0L0.0 0.0Z';

      expect(actualDataString, expectedDataString);
    });
  });

  group('Tests of SvgPolygon.transform()', () {
    test('Should [return SvgPolygon] with updated values (invert == false)', () {
      // Arrange
      SvgPolygon actualSvgPolygon = const SvgPolygon(
        fill: '#fff',
        points: <Point<double>>[
          Point<double>(10, 20),
          Point<double>(0, 20),
          Point<double>(0, 0),
        ],
        invert: false,
      );

      SvgTransformation actualSvgTransformation = SvgTransformation(x: 100, y: 100, size: 50, rotation: 3);

      // Act
      SvgPolygon actualTransformedSvgPolygon = actualSvgPolygon.transform(actualSvgTransformation);

      // Assert
      SvgPolygon expectedTransformedSvgPolygon = const SvgPolygon(
        fill: '#fff',
        points: <Point<double>>[
          Point<double>(120, 140),
          Point<double>(120, 150),
          Point<double>(100, 150),
        ],
        invert: false,
      );

      expect(actualTransformedSvgPolygon, expectedTransformedSvgPolygon);
    });

    test('Should [return SvgPolygon] with updated values (invert == true)', () {
      // Arrange
      SvgPolygon actualSvgPolygon = const SvgPolygon(
        fill: '#fff',
        points: <Point<double>>[
          Point<double>(10, 20),
          Point<double>(0, 20),
          Point<double>(0, 0),
        ],
        invert: true,
      );

      SvgTransformation actualSvgTransformation = SvgTransformation(x: 100, y: 100, size: 50, rotation: 3);

      // Act
      SvgPolygon actualTransformedSvgPolygon = actualSvgPolygon.transform(actualSvgTransformation);

      // Assert
      SvgPolygon expectedTransformedSvgPolygon = const SvgPolygon(
        fill: '#fff',
        points: <Point<double>>[
          Point<double>(100, 150),
          Point<double>(120, 150),
          Point<double>(120, 140),
        ],
        invert: true,
      );

      expect(actualTransformedSvgPolygon, expectedTransformedSvgPolygon);
    });
  });
}
