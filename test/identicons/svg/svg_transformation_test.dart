import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SvgTransformation.transformPoint()', () {
    test('Should [return transformed Point] (rotation == 1)', () {
      // Arrange
      SvgTransformation actualTransformation = SvgTransformation(x: 10, y: 20, size: 30, rotation: 1);
      Point<double> actualPointToTransform = const Point<double>(10, 10);

      // Act
      Point<double> actualTransformedPoint = actualTransformation.transformPoint(actualPointToTransform);

      // Assert
      Point<double> expectedTransformedPoint = const Point<double>(30, 30);

      expect(actualTransformedPoint, expectedTransformedPoint);
    });

    test('Should [return transformed Point] (rotation == 2)', () {
      // Arrange
      SvgTransformation actualTransformation = SvgTransformation(x: 10, y: 20, size: 30, rotation: 2);
      Point<double> actualPointToTransform = const Point<double>(10, 10);

      // Act
      Point<double> actualTransformedPoint = actualTransformation.transformPoint(actualPointToTransform);

      // Assert
      Point<double> expectedTransformedPoint = const Point<double>(30, 40);

      expect(actualTransformedPoint, expectedTransformedPoint);
    });

    test('Should [return transformed Point] (rotation == 3)', () {
      // Arrange
      SvgTransformation actualTransformation = SvgTransformation(x: 10, y: 20, size: 30, rotation: 3);
      Point<double> actualPointToTransform = const Point<double>(10, 10);

      // Act
      Point<double> actualTransformedPoint = actualTransformation.transformPoint(actualPointToTransform);

      // Assert
      Point<double> expectedTransformedPoint = const Point<double>(20, 40);

      expect(actualTransformedPoint, expectedTransformedPoint);
    });

    test('Should [return transformed Point] (rotation == 4)', () {
      // Arrange
      SvgTransformation actualTransformation = SvgTransformation(x: 10, y: 20, size: 30, rotation: 4);
      Point<double> actualPointToTransform = const Point<double>(10, 10);

      // Act
      Point<double> actualTransformedPoint = actualTransformation.transformPoint(actualPointToTransform);

      // Assert
      Point<double> expectedTransformedPoint = const Point<double>(20, 30);

      expect(actualTransformedPoint, expectedTransformedPoint);
    });
  });
}
