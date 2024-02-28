import 'dart:math' show Point;

class SvgTransformation {
  final double x;
  final double y;
  final double size;
  final double rotation;

  SvgTransformation({
    required this.x,
    required this.y,
    required this.size,
    required this.rotation,
  });

  Point<double> transformPoint(Point<double> point, [double width = 0, double height = 0]) {
    double right = x + size;
    double bottom = y + size;

    if (rotation == 1) {
      return Point<double>(right - point.y - height, y + point.x);
    } else if (rotation == 2) {
      return Point<double>(right - point.x - width, bottom - point.y - height);
    } else if (rotation == 3) {
      return Point<double>(x + point.y, bottom - point.x - width);
    } else {
      return Point<double>(x + point.x, y + point.y);
    }
  }
}
