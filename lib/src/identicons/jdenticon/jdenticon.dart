import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The Jdenticon class facilitates the generation of identicons, which are unique, geometric
/// representations of hash values, commonly used for visual identification in digital applications.
class Jdenticon extends AIdenticon {
  late final int _padding;
  late final int _canvasSize;
  late final JdenticonTheme _theme;

  late int _cellSize;
  late String _seed;

  Jdenticon({
    super.iconSize,
    double padding = 0.08,
    JdenticonTheme? theme,
  }) {
    _theme = theme ?? JdenticonTheme.withDefaults();
    _padding = (0.5 + iconSize * padding).floor();
    _canvasSize = (iconSize.abs() - _padding * 2).floor().abs();
  }

  /// Returns a list of [ASvgShape] objects that represent the Jdenticon.
  @override
  List<ASvgShape> getShapes(String data) {
    _seed = '${sha1.convert(utf8.encode(data))}';
    _cellSize = (_canvasSize / 4).floor();

    List<String> colorPalette = _getColorPalette(_seed);
    List<ASvgShape> outerShapes1 = _renderShape(
      index: 2,
      rotationIndex: 3,
      color: colorPalette[0],
      shapeBuilders: JdenticonShapes.outerShapes,
      positions: const <Point<int>>[
        Point<int>(1, 0),
        Point<int>(2, 0),
        Point<int>(2, 3),
        Point<int>(1, 3),
        Point<int>(0, 1),
        Point<int>(3, 1),
        Point<int>(3, 2),
        Point<int>(0, 2)
      ],
    );
    List<ASvgShape> outerShapes2 = _renderShape(
      index: 4,
      rotationIndex: 5,
      color: colorPalette[1],
      shapeBuilders: JdenticonShapes.outerShapes,
      positions: const <Point<int>>[
        Point<int>(0, 0),
        Point<int>(3, 0),
        Point<int>(3, 3),
        Point<int>(0, 3),
      ],
    );
    List<ASvgShape> centerShapes = _renderShape(
      index: 1,
      color: colorPalette[2],
      shapeBuilders: JdenticonShapes.centerShapes,
      positions: const <Point<int>>[
        Point<int>(1, 1),
        Point<int>(2, 1),
        Point<int>(2, 2),
        Point<int>(1, 2),
      ],
    );

    return <ASvgShape>[...outerShapes1, ...outerShapes2, ...centerShapes];
  }

  /// Returns the color palette that will be used to fill the shapes in the identicon.
  List<String> _getColorPalette(String hash) {
    double hue = int.parse(_seed.substring(_seed.length - 7), radix: 16) / 0xfffffff;
    List<String> availableColors = _theme.getAvailableColors(hue);
    List<int> colorIndexes = <int>[];
    for (int i = 0; i < 3; i++) {
      int index = int.parse(hash.substring(8 + i, 9 + i), radix: 16) % availableColors.length;
      bool restrictedPairDarkBool = _isRestrictedPair(colorIndexes, <int>[0, 4], index);
      bool restrictedPairLightBool = _isRestrictedPair(colorIndexes, <int>[2, 3], index);
      if (restrictedPairDarkBool || restrictedPairLightBool) {
        index = 1;
      }
      colorIndexes.add(index);
    }
    return colorIndexes.map((int index) => availableColors[index]).toList();
  }

  /// Returns a boolean value indicating whether the current pair of colors is restricted.
  /// For example dark gray and dark color, and light gray and light color cannot be used together in the same identicon.
  bool _isRestrictedPair(List<int> currentList, List<int> disallowedPair, int index) {
    if (disallowedPair.contains(index)) {
      for (int i = 0; i < disallowedPair.length; i++) {
        if (currentList.contains(disallowedPair[i])) {
          return true;
        }
      }
    }
    return false;
  }

  /// Returns a list of [ASvgShape] objects that represent the center or outer shapes of the Jdenticon.
  List<ASvgShape> _renderShape({
    required int index,
    required String color,
    required List<JdenticonShapeBuilder> shapeBuilders,
    required List<Point<int>> positions,
    int? rotationIndex,
  }) {
    double xScale = (_padding + _canvasSize / 2.0 - _cellSize * 2.0).floorToDouble();
    double yScale = (_padding + _canvasSize / 2.0 - _cellSize * 2.0).floorToDouble();
    int r = rotationIndex != null ? int.parse(_seed.substring(rotationIndex, rotationIndex + 1), radix: 16) : 0;

    JdenticonShapeBuilder shapeBuilder = shapeBuilders[int.parse(_seed.substring(index, index + 1), radix: 16) % shapeBuilders.length];
    List<ASvgShape> shapes = <ASvgShape>[];

    for (int i = 0; i < positions.length; i++) {
      SvgTransformation svgTransformation = SvgTransformation(
        x: xScale + positions[i].x * _cellSize,
        y: yScale + positions[i].y * _cellSize,
        size: _cellSize.toDouble(),
        rotation: (r++ % 4).toDouble(),
      );

      List<ASvgShape> localShapes = shapeBuilder(_cellSize.toDouble(), color, i);
      for (ASvgShape shape in localShapes) {
        ASvgShape transformedShape = shape.transform(svgTransformation);
        shapes.add(transformedShape);
      }
    }
    return shapes;
  }
}
