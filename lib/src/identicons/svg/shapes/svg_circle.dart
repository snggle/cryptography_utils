import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [SvgCircle] represents a circle shape in SVG image
class SvgCircle extends ASvgShape {
  final Point<double> point;
  final double diameter;

  const SvgCircle({
    required super.fill,
    required this.point,
    required this.diameter,
    super.invert = false,
  });

  @override
  void draw(SvgPath svgPath) {
    svgPath.addCircle(point, diameter, counterClockwise: invert);
  }

  @override
  SvgCircle transform(SvgTransformation svgTransformation) {
    Point<double> transformedPoint = svgTransformation.transformPoint(point, diameter, diameter);
    return SvgCircle(fill: fill, point: transformedPoint, diameter: diameter, invert: invert);
  }

  @override
  List<Object?> get props => <Object>[point, fill, diameter];
}
