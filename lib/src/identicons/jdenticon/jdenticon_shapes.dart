import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';

typedef JdenticonShapeBuilder = List<ASvgShape> Function(double cellSize, String fill, int index);

/// [JdenticonShapes] contains the lists of [JdenticonShapeBuilder] which are used
/// to draw specific shapes for the Jdenticon identicon.
class JdenticonShapes {
  static List<JdenticonShapeBuilder> centerShapes = <JdenticonShapeBuilder>[
    (double cellSize, String fill, int index) {
      double k = cellSize * 0.42;
      return <ASvgShape>[
        SvgPolygon(fill: fill, points: <Point<double>>[
          const Point<double>(0.0, 0.0),
          Point<double>(cellSize, 0.0),
          Point<double>(cellSize, cellSize - k * 2.0),
          Point<double>(cellSize - k, cellSize),
          Point<double>(0.0, cellSize)
        ]),
      ];
    },
    (double cellSize, String fill, int index) {
      double w = (cellSize * 0.5).floorToDouble();
      double h = (cellSize * 0.8).floorToDouble();
      return <ASvgShape>[
        SvgPolygon.triangle(fill: fill, x: cellSize - w, y: 0.0, w: w, h: h, r: 2.0),
      ];
    },
    (double cellSize, String fill, int index) {
      double s = (cellSize / 3.0).floorToDouble();
      return <ASvgShape>[
        SvgPolygon.square(fill: fill, x: s, y: s, size: cellSize - s),
      ];
    },
    (double cellSize, String fill, int index) {
      double inner = cellSize * 0.1;
      inner = inner > 1 ? inner.floorToDouble() : (inner > 0.5 ? 1.0 : inner);

      double outer = cellSize < 6.0 ? 1.0 : (cellSize < 8.0 ? 2.0 : (cellSize * 0.25).floorToDouble());
      return <ASvgShape>[
        SvgPolygon.square(fill: fill, x: outer, y: outer, size: cellSize - inner - outer),
      ];
    },
    (double cellSize, String fill, int index) {
      double m = (cellSize * 0.15).floorToDouble();
      double s = (cellSize * 0.5).floorToDouble();
      return <ASvgShape>[
        SvgCircle(fill: fill, point: Point<double>(cellSize - s - m, cellSize - s - m), diameter: s),
      ];
    },
    (double cellSize, String fill, int index) {
      double inner = cellSize * 0.1;
      double outer = inner * 4.0;
      if (outer > 3) {
        outer = outer.floorToDouble();
      }

      return <ASvgShape>[
        SvgPolygon.square(fill: fill, x: 0.0, y: 0.0, size: cellSize),
        SvgPolygon(
          fill: fill,
          points: <Point<double>>[
            Point<double>(outer, outer.floorToDouble()),
            Point<double>(cellSize - inner, outer.floorToDouble()),
            Point<double>(outer + (cellSize - outer - inner) / 2.0, cellSize - inner)
          ],
          invert: true,
        ),
      ];
    },
    (double cellSize, String fill, int index) {
      return <ASvgShape>[
        SvgPolygon(
          fill: fill,
          points: <Point<double>>[
            const Point<double>(0.0, 0.0),
            Point<double>(cellSize, 0.0),
            Point<double>(cellSize, cellSize * 0.7),
            Point<double>(cellSize * 0.4, cellSize * 0.4),
            Point<double>(cellSize * 0.7, cellSize),
            Point<double>(0.0, cellSize)
          ],
        ),
      ];
    },
    (double cellSize, String fill, int index) {
      return <ASvgShape>[
        SvgPolygon.triangle(fill: fill, x: cellSize / 2, y: cellSize / 2, w: cellSize / 2, h: cellSize / 2, r: 3),
      ];
    },
    (double cellSize, String fill, int index) {
      return <ASvgShape>[
        SvgPolygon.rectangle(fill: fill, x: 0.0, y: 0.0, w: cellSize, h: cellSize / 2),
        SvgPolygon.rectangle(fill: fill, x: 0.0, y: cellSize / 2, w: cellSize / 2, h: cellSize / 2),
        SvgPolygon.triangle(fill: fill, x: cellSize / 2, y: cellSize / 2, w: cellSize / 2, h: cellSize / 2, r: 1),
      ];
    },
    (double cellSize, String fill, int index) {
      double inner = cellSize * 0.14;
      inner = cellSize < 8 ? inner : inner.floorToDouble();

      double outer = cellSize < 4 ? 1 : (cellSize < 6 ? 2 : (cellSize * 0.35).floorToDouble());

      return <ASvgShape>[
        SvgPolygon.square(fill: fill, x: 0, y: 0, size: cellSize),
        SvgPolygon.rectangle(fill: fill, x: outer, y: outer, w: cellSize - inner - outer, h: cellSize - inner - outer, invert: true),
      ];
    },
    (double cellSize, String fill, int index) {
      double inner = cellSize * 0.12;
      double outer = inner * 3;

      return <ASvgShape>[
        SvgPolygon.square(fill: fill, x: 0, y: 0, size: cellSize),
        SvgCircle(fill: fill, point: Point<double>(outer, outer), diameter: cellSize - inner - outer, invert: true),
      ];
    },
    (double cellSize, String fill, int index) {
      return <ASvgShape>[
        SvgPolygon.triangle(fill: fill, x: cellSize / 2, y: cellSize / 2, w: cellSize / 2, h: cellSize / 2, r: 3),
      ];
    },
    (double cellSize, String fill, int index) {
      double m = cellSize * 0.25;
      return <ASvgShape>[
        SvgPolygon.square(fill: fill, x: 0, y: 0, size: cellSize),
        SvgPolygon.rhombus(fill: fill, x: m, y: m, w: cellSize - m, h: cellSize - m, invert: true),
      ];
    },
    (double cellSize, String fill, int index) {
      double m = cellSize * 0.4;
      double s = cellSize * 1.2;

      return <ASvgShape>[
        if (index == 0) SvgCircle(fill: fill, point: Point<double>(m, m), diameter: s),
      ];
    },
  ];

  static List<JdenticonShapeBuilder> outerShapes = <JdenticonShapeBuilder>[
    (double cellSize, String fill, int index) {
      return <ASvgShape>[
        SvgPolygon.triangle(fill: fill, x: 0.0, y: 0.0, w: cellSize, h: cellSize, r: 0.0),
      ];
    },
    (double cellSize, String fill, int index) {
      return <ASvgShape>[
        SvgPolygon.triangle(fill: fill, x: 0.0, y: cellSize / 2.0, w: cellSize, h: cellSize / 2.0, r: 0.0),
      ];
    },
    (double cellSize, String fill, int index) {
      return <ASvgShape>[
        SvgPolygon.rhombus(fill: fill, x: 0.0, y: 0.0, w: cellSize, h: cellSize),
      ];
    },
    (double cellSize, String fill, int index) {
      double m = cellSize / 6.0;
      return <ASvgShape>[
        SvgCircle(fill: fill, point: Point<double>(m, m), diameter: cellSize - 2 * m),
      ];
    }
  ];
}
