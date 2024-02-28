import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SvgPath.addPolygon()', () {
    test('Should [return path] with added polygon', () {
      // Arrange
      SvgPath actualSvgPath = SvgPath();
      List<Point<double>> actualPoints = const <Point<double>>[
        Point<double>(3.0, 3.0),
        Point<double>(10.0, 3.0),
        Point<double>(10.0, 10.0),
        Point<double>(3.0, 10.0),
      ];

      // Act
      actualSvgPath.addPolygon(actualPoints);
      String actualDataString = actualSvgPath.dataString;

      // Assert
      String expectedDataString = 'M3.0 3.0L3.0 3.0L10.0 3.0L10.0 10.0L3.0 10.0Z';

      expect(actualDataString, expectedDataString);
    });
  });

  group('Tests of SvgPath.addCircle()', () {
    test('Should [return path] with added circle', () {
      // Arrange
      SvgPath actualSvgPath = SvgPath();
      Point<double> actualCenter = const Point<double>(5.0, 5.0);
      double actualDiameter = 10.0;

      // Act
      actualSvgPath.addCircle(actualCenter, actualDiameter);
      String actualDataString = actualSvgPath.dataString;

      // Assert
      String expectedDataString = 'M5.0 10.0a5,5 0 1,1 10 ,0a5,5 0 1,1 -10,0';

      expect(actualDataString, expectedDataString);
    });
  });

  group('Tests of SvgPath process', () {
    SvgPath actualSvgPath = SvgPath();

    test('Should [return path] with added shape', () {
      // Arrange
      List<Point<double>> actualPoints = const <Point<double>>[
        Point<double>(3.0, 3.0),
        Point<double>(10.0, 3.0),
        Point<double>(10.0, 10.0),
        Point<double>(3.0, 10.0),
      ];

      // Act
      actualSvgPath.addPolygon(actualPoints);
      String actualDataString = actualSvgPath.dataString;

      // Assert
      String expectedDataString = 'M3.0 3.0L3.0 3.0L10.0 3.0L10.0 10.0L3.0 10.0Z';

      expect(actualDataString, expectedDataString);
    });

    test('Should [return MERGED paths] with added shape', () {
      // Arrange
      Point<double> actualCenter = const Point<double>(5.0, 5.0);
      double actualDiameter = 10.0;

      // Act
      actualSvgPath.addCircle(actualCenter, actualDiameter);
      String actualDataString = actualSvgPath.dataString;

      // Assert
      String expectedDataString = 'M3.0 3.0L3.0 3.0L10.0 3.0L10.0 10.0L3.0 10.0ZM5.0 10.0a5,5 0 1,1 10 ,0a5,5 0 1,1 -10,0';

      expect(actualDataString, expectedDataString);
    });
  });
}
