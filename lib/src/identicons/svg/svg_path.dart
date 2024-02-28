import 'dart:math' show Point;

class SvgPath {
  String dataString = '';

  void addPolygon(List<Point<double>> points) {
    StringBuffer path = StringBuffer('M${points[0].x.toStringAsFixed(1)} ${points[0].y.toStringAsFixed(1)}');
    for (int i = 0; i < points.length; i++) {
      path.write('L${points[i].x.toStringAsFixed(1)} ${points[i].y.toStringAsFixed(1)}');
    }
    path.write('Z');
    dataString += path.toString();
  }

  void addCircle(Point<double> center, double diameter, {bool counterClockwise = false}) {
    int sweepFlag = counterClockwise ? 0 : 1;
    int svgRadius = (diameter / 2).floor();
    int svgDiameter = diameter.floor();

    dataString +=
        'M${center.x} ${center.y + diameter / 2}a$svgRadius,$svgRadius 0 1,$sweepFlag $svgDiameter ,0a$svgRadius,$svgRadius 0 1,$sweepFlag -$svgDiameter,0';
  }
}
