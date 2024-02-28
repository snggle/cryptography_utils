import 'package:cryptography_utils/cryptography_utils.dart';

/// The [Blockies] class generates block-style identicons primarily used for visually
/// representing Ethereum (ETH) addresses. It creates unique and recognizable patterns
/// that facilitate the identification of blockchain participants.
class Blockies extends AIdenticon {
  final int _elementsCount;
  final double _squareSize;

  Blockies({
    super.iconSize,
    int elementsCount = 8,
  })  : _elementsCount = elementsCount,
        _squareSize = iconSize / elementsCount;

  /// Returns a list of [ASvgShape] objects that represent the Blockies identicon.
  @override
  List<ASvgShape> getShapes(String data) {
    List<int> seed = _createSeed(data.toLowerCase());
    String color = _createColor(seed);
    String backgroundColor = _createColor(seed);
    String spotColor = _createColor(seed);

    List<int> colorsMatrix = _getColorsMatrix(seed);
    List<ASvgShape> shapes = <ASvgShape>[];

    for (int i = 0; i < colorsMatrix.length; i++) {
      if (colorsMatrix[i] != 0) {
        double x = (i / _elementsCount).floor() * _squareSize;
        double y = i % _elementsCount * _squareSize;

        String tileColor = colorsMatrix[i] == 1 ? color : spotColor;
        shapes.add(SvgPolygon.square(x: x, y: y, size: _squareSize, fill: tileColor));
      }
    }

    return <ASvgShape>[
      SvgPolygon.square(x: 0, y: 0, size: _squareSize * _elementsCount, fill: backgroundColor),
      ...shapes,
    ];
  }

  /// Calculates the seed that will be used to generate the identicon.
  List<int> _createSeed(String address) {
    List<int> seed = List<int>.filled(4, 0);
    for (int i = 0; i < address.length; i++) {
      seed[i % 4] = (seed[i % 4] << 5).toSigned(32) - seed[i % 4] + address.codeUnitAt(i);
    }
    return seed;
  }

  /// Generates color in HSL format based on the specified seed, simultaneously shuffling the it.
  String _createColor(List<int> seed) {
    double hue = (_shuffleSeed(seed) * 360).floorToDouble();
    double saturation = (_shuffleSeed(seed) * 60) + 40;
    double lightness = (_shuffleSeed(seed) + _shuffleSeed(seed) + _shuffleSeed(seed) + _shuffleSeed(seed)) * 25;

    return 'hsl(${hue}, ${saturation}%, ${lightness}%)';
  }

  List<int> _getColorsMatrix(List<int> seed) {
    int lWidth = (_elementsCount / 2).ceil();
    int rWidth = _elementsCount - lWidth;

    List<int> data = List<int>.empty(growable: true);
    for (int y = 0; y < _elementsCount; y++) {
      List<int> row = List<int>.filled(lWidth, 0, growable: true);
      for (int x = 0; x < lWidth; x++) {
        row[x] = (_shuffleSeed(seed) * 2.3).floor();
      }

      List<int> r = row.sublist(0, rWidth).reversed.toList();
      row.addAll(r);
      for (int i = 0; i < row.length; i++) {
        data.add(row[i]);
      }
    }
    _rotateColorsMatrix(data);
    return data;
  }

  /// Shuffles the seed and returns a double value representing the seed as number
  double _shuffleSeed(List<int> seed) {
    int t = (seed[0] ^ (seed[0] << 11).toSigned(32)).toSigned(32);
    int third = seed[3].toSigned(32);

    seed[0] = seed[1];
    seed[1] = seed[2];
    seed[2] = seed[3];
    seed[3] = ((third ^ (third >> 19)) ^ t ^ (t >> 8)).toInt();

    return (seed[3] >>> 0).toSigned(32) / ((1 << 31) >>> 0);
  }

  /// Rotates the colors matrix by 270 degrees
  void _rotateColorsMatrix(List<int> colorsMatrix) {
    int n = _elementsCount;
    for (int x = 0; x < n / 2; x++) {
      for (int y = x; y < n - x - 1; y++) {
        int temp = colorsMatrix[x * n + y];
        colorsMatrix[x * n + y] = colorsMatrix[y * n + n - 1 - x];
        colorsMatrix[y * n + n - 1 - x] = colorsMatrix[(n - 1 - x) * n + n - 1 - y];
        colorsMatrix[(n - 1 - x) * n + n - 1 - y] = colorsMatrix[(n - 1 - y) * n + x];
        colorsMatrix[(n - 1 - y) * n + x] = temp;
      }
    }
  }
}
