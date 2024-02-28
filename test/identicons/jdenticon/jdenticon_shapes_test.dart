import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  double actualCellSize = 10;
  String actualFill = '#fff';

  group('Tests of JdenticonShapes - JdenticonShapeBuilders', () {
    test('Should return a list of ASvgShape (Shape: Center 1)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[0];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(0.0, 0.0),
            Point<double>(10.0, 0.0),
            Point<double>(10.0, 1.5999999999999996),
            Point<double>(5.8, 10.0),
            Point<double>(0.0, 10.0)
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 2)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[1];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(10.0, 0.0),
            Point<double>(10.0, 8.0),
            Point<double>(5.0, 0.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 3)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[2];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(3.0, 3.0),
            Point<double>(10.0, 3.0),
            Point<double>(10.0, 10.0),
            Point<double>(3.0, 10.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 4)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[3];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(2.0, 2.0),
            Point<double>(9.0, 2.0),
            Point<double>(9.0, 9.0),
            Point<double>(2.0, 9.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 5)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[4];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgCircle(point: Point<double>(4.0, 4.0), fill: '#fff', diameter: 5.0),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 6)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[5];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(0.0, 0.0),
            Point<double>(10.0, 0.0),
            Point<double>(10.0, 10.0),
            Point<double>(0.0, 10.0),
          ],
          fill: '#fff',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(4.0, 4.0),
            Point<double>(9.0, 4.0),
            Point<double>(6.5, 9.0),
          ],
          fill: '#fff',
          invert: true,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 7)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[6];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(0.0, 0.0),
            Point<double>(10.0, 0.0),
            Point<double>(10.0, 7.0),
            Point<double>(4.0, 4.0),
            Point<double>(7.0, 10.0),
            Point<double>(0.0, 10.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 8)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[7];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(10.0, 5.0),
            Point<double>(10.0, 10.0),
            Point<double>(5.0, 10.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 9)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[8];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(0.0, 0.0),
            Point<double>(10.0, 0.0),
            Point<double>(10.0, 5.0),
            Point<double>(0.0, 5.0),
          ],
          fill: '#fff',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(0.0, 5.0),
            Point<double>(5.0, 5.0),
            Point<double>(5.0, 10.0),
            Point<double>(0.0, 10.0),
          ],
          fill: '#fff',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(10.0, 5.0),
            Point<double>(5.0, 10.0),
            Point<double>(5.0, 5.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 10)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[9];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(0.0, 0.0),
            Point<double>(10.0, 0.0),
            Point<double>(10.0, 10.0),
            Point<double>(0.0, 10.0),
          ],
          fill: '#fff',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(3.0, 3.0),
            Point<double>(9.0, 3.0),
            Point<double>(9.0, 9.0),
            Point<double>(3.0, 9.0),
          ],
          fill: '#fff',
          invert: true,
        )
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 11)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[10];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(0.0, 0.0),
            Point<double>(10.0, 0.0),
            Point<double>(10.0, 10.0),
            Point<double>(0.0, 10.0),
          ],
          fill: '#fff',
          invert: false,
        ),
        SvgCircle(
          point: Point<double>(3.5999999999999996, 3.5999999999999996),
          fill: '#fff',
          diameter: 5.200000000000001,
        )
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 12)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[11];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(10.0, 5.0),
            Point<double>(10.0, 10.0),
            Point<double>(5.0, 10.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 13)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[12];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(0.0, 0.0),
            Point<double>(10.0, 0.0),
            Point<double>(10.0, 10.0),
            Point<double>(0.0, 10.0),
          ],
          fill: '#fff',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(6.25, 2.5),
            Point<double>(10.0, 6.25),
            Point<double>(6.25, 10.0),
            Point<double>(2.5, 6.25),
          ],
          fill: '#fff',
          invert: true,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Center 14)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.centerShapes[13];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgCircle(
          point: Point<double>(4.0, 4.0),
          fill: '#fff',
          diameter: 12.0,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Outer 1)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.outerShapes[0];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(10.0, 10.0),
            Point<double>(0.0, 10.0),
            Point<double>(0.0, 0.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Outer 2)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.outerShapes[1];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(10.0, 10.0),
            Point<double>(0.0, 10.0),
            Point<double>(0.0, 5.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Outer 3)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.outerShapes[2];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(5.0, 0.0),
            Point<double>(10.0, 5.0),
            Point<double>(5.0, 10.0),
            Point<double>(0.0, 5.0),
          ],
          fill: '#fff',
          invert: false,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });

    test('Should return a list of ASvgShape (Shape: Outer 4)', () {
      // Arrange
      JdenticonShapeBuilder actualJdenticonShapeBuilder = JdenticonShapes.outerShapes[3];

      // Act
      List<ASvgShape> actualShapes = actualJdenticonShapeBuilder(actualCellSize, actualFill, 0);

      // Assert
      List<ASvgShape> expectedShapes = const <ASvgShape>[
        SvgCircle(
          point: Point<double>(1.6666666666666667, 1.6666666666666667),
          fill: '#fff',
          diameter: 6.666666666666666,
        ),
      ];

      expect(actualShapes, expectedShapes);
    });
  });
}
