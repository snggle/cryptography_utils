import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';

/// [SvgPolygon] represents a polygon shape in SVG image
class SvgPolygon extends ASvgShape {
  final List<Point<double>> points;

  const SvgPolygon({
    required super.fill,
    required this.points,
    super.invert = false,
  });

  SvgPolygon.rectangle({
    required super.fill,
    required double x,
    required double y,
    required double w,
    required double h,
    super.invert = false,
  }) : points = <Point<double>>[
          Point<double>(x, y),
          Point<double>(x + w, y),
          Point<double>(x + w, y + h),
          Point<double>(x, y + h),
        ];

  SvgPolygon.square({
    required super.fill,
    required double x,
    required double y,
    required double size,
    super.invert = false,
  }) : points = <Point<double>>[
          Point<double>(x, y),
          Point<double>(x + size, y),
          Point<double>(x + size, y + size),
          Point<double>(x, y + size),
        ];

  SvgPolygon.rhombus({
    required super.fill,
    required double x,
    required double y,
    required double w,
    required double h,
    super.invert = false,
  }) : points = <Point<double>>[
          Point<double>(x + w / 2.0, y),
          Point<double>(x + w, y + h / 2.0),
          Point<double>(x + w / 2.0, y + h),
          Point<double>(x, y + h / 2.0)
        ];

  SvgPolygon.triangle({
    required super.fill,
    required double x,
    required double y,
    required double w,
    required double h,
    required double r,
    super.invert = false,
  }) : points = <Point<double>>[
          Point<double>(x + w, y),
          Point<double>(x + w, y + h),
          Point<double>(x, y + h),
          Point<double>(x, y),
        ]..removeAt(r.floor() % 4);

  @override
  void draw(SvgPath svgPath) {
    svgPath.addPolygon(points);
  }

  @override
  SvgPolygon transform(SvgTransformation svgTransformation) {
    List<Point<double>> transformedPoints = <Point<double>>[];
    int i = invert ? points.length - 1 : 0;
    if (!invert) {
      for (; i < points.length; i++) {
        transformedPoints.add(svgTransformation.transformPoint(points[i]));
      }
    } else {
      for (; i > -1; i--) {
        transformedPoints.add(svgTransformation.transformPoint(points[i]));
      }
    }
    return SvgPolygon(fill: fill, points: transformedPoints, invert: invert);
  }

  @override
  List<Object?> get props => <Object>[points, fill, invert];
}
