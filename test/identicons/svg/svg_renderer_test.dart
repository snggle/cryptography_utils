import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SvgRenderer.renderShapes()', () {
    test('Should [return SVG string] constructed from given shapes', () {
      // Arrange
      List<ASvgShape> actualShapes = const <ASvgShape>[
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(32.0, 6.0),
            Point<double>(32.0, 19.0),
            Point<double>(19.0, 19.0),
          ],
          fill: 'hsl(311.3733876920245, 0.0%, 33.0%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(45.0, 19.0),
            Point<double>(32.0, 19.0),
            Point<double>(32.0, 6.0),
          ],
          fill: 'hsl(311.3733876920245, 0.0%, 33.0%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(32.0, 58.0),
            Point<double>(32.0, 45.0),
            Point<double>(45.0, 45.0),
          ],
          fill: 'hsl(311.3733876920245, 0.0%, 33.0%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(19.0, 45.0),
            Point<double>(32.0, 45.0),
            Point<double>(32.0, 58.0),
          ],
          fill: 'hsl(311.3733876920245, 0.0%, 33.0%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(19.0, 19.0),
            Point<double>(19.0, 32.0),
            Point<double>(6.0, 32.0),
          ],
          fill: 'hsl(311.3733876920245, 0.0%, 33.0%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(58.0, 32.0),
            Point<double>(45.0, 32.0),
            Point<double>(45.0, 19.0),
          ],
          fill: 'hsl(311.3733876920245, 0.0%, 33.0%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(45.0, 45.0),
            Point<double>(45.0, 32.0),
            Point<double>(58.0, 32.0),
          ],
          fill: 'hsl(311.3733876920245, 0.0%, 33.0%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(6.0, 32.0),
            Point<double>(19.0, 32.0),
            Point<double>(19.0, 45.0),
          ],
          fill: 'hsl(311.3733876920245, 0.0%, 33.0%)',
          invert: false,
        ),
        SvgCircle(
          point: Point<double>(8.166666666666664, 8.166666666666664),
          fill: 'hsl(311.3733876920245, 50.0%, 82.0%)',
          diameter: 8.666666666666668,
        ),
        SvgCircle(
          point: Point<double>(47.166666666666664, 8.166666666666664),
          fill: 'hsl(311.3733876920245, 50.0%, 82.0%)',
          diameter: 8.666666666666668,
        ),
        SvgCircle(
          point: Point<double>(47.166666666666664, 47.166666666666664),
          fill: 'hsl(311.3733876920245, 50.0%, 82.0%)',
          diameter: 8.666666666666668,
        ),
        SvgCircle(
          point: Point<double>(8.166666666666664, 47.166666666666664),
          fill: 'hsl(311.3733876920245, 50.0%, 82.0%)',
          diameter: 8.666666666666668,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(23.0, 23.0),
            Point<double>(32.0, 23.0),
            Point<double>(32.0, 32.0),
            Point<double>(23.0, 32.0),
          ],
          fill: 'hsl(311.3733876920245, 50.0%, 64.00000000000001%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(41.0, 23.0),
            Point<double>(41.0, 32.0),
            Point<double>(32.0, 32.0),
            Point<double>(32.0, 23.0),
          ],
          fill: 'hsl(311.3733876920245, 50.0%, 64.00000000000001%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(41.0, 41.0),
            Point<double>(32.0, 41.0),
            Point<double>(32.0, 32.0),
            Point<double>(41.0, 32.0),
          ],
          fill: 'hsl(311.3733876920245, 50.0%, 64.00000000000001%)',
          invert: false,
        ),
        SvgPolygon(
          points: <Point<double>>[
            Point<double>(23.0, 41.0),
            Point<double>(23.0, 32.0),
            Point<double>(32.0, 32.0),
            Point<double>(32.0, 41.0),
          ],
          fill: 'hsl(311.3733876920245, 50.0%, 64.00000000000001%)',
          invert: false,
        ),
      ];

      // Act
      String actualSvg = SvgRenderer(size: 64).renderShapes(actualShapes);

      // Assert
      String expectedSvg =
          '<svg xmlns="http://www.w3.org/2000/svg" width="64.0" height="64.0" viewBox="0 0 64.0 64.0" preserveAspectRatio="xMidYMid meet"><path fill="hsl(311.3733876920245, 0.0%, 33.0%)" d="M32.0 6.0L32.0 6.0L32.0 19.0L19.0 19.0ZM45.0 19.0L45.0 19.0L32.0 19.0L32.0 6.0ZM32.0 58.0L32.0 58.0L32.0 45.0L45.0 45.0ZM19.0 45.0L19.0 45.0L32.0 45.0L32.0 58.0ZM19.0 19.0L19.0 19.0L19.0 32.0L6.0 32.0ZM58.0 32.0L58.0 32.0L45.0 32.0L45.0 19.0ZM45.0 45.0L45.0 45.0L45.0 32.0L58.0 32.0ZM6.0 32.0L6.0 32.0L19.0 32.0L19.0 45.0Z" /><path fill="hsl(311.3733876920245, 50.0%, 82.0%)" d="M8.166666666666664 12.499999999999998a4,4 0 1,1 8 ,0a4,4 0 1,1 -8,0M47.166666666666664 12.499999999999998a4,4 0 1,1 8 ,0a4,4 0 1,1 -8,0M47.166666666666664 51.5a4,4 0 1,1 8 ,0a4,4 0 1,1 -8,0M8.166666666666664 51.5a4,4 0 1,1 8 ,0a4,4 0 1,1 -8,0" /><path fill="hsl(311.3733876920245, 50.0%, 64.00000000000001%)" d="M23.0 23.0L23.0 23.0L32.0 23.0L32.0 32.0L23.0 32.0ZM41.0 23.0L41.0 23.0L41.0 32.0L32.0 32.0L32.0 23.0ZM41.0 41.0L41.0 41.0L32.0 41.0L32.0 32.0L41.0 32.0ZM23.0 41.0L23.0 41.0L23.0 32.0L32.0 32.0L32.0 41.0Z" /></svg>';

      expect(actualSvg, expectedSvg);
    });
  });
}
