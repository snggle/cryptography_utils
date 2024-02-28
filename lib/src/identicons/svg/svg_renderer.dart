import 'package:cryptography_utils/cryptography_utils.dart';

class SvgRenderer {
  final Map<String, SvgPath> _pathsByColor = <String, SvgPath>{};
  final double _size;

  SvgRenderer({
    required double size,
  }) : _size = size;

  String renderShapes(List<ASvgShape> shapes) {
    StringBuffer result = StringBuffer();
    _beginSvg(result);
    for (ASvgShape shape in shapes) {
      SvgPath path = _beginShape(shape.fill);
      shape.draw(path);
    }

    _pathsByColor.forEach((String color, SvgPath value) {
      result.write('<path fill="$color" d="${value.dataString}" />');
    });

    _endSvg(result);
    return result.toString();
  }

  void _beginSvg(StringBuffer result) {
    result.write('<svg xmlns="http://www.w3.org/2000/svg" width="$_size" height="$_size" viewBox="0 0 $_size $_size" preserveAspectRatio="xMidYMid meet">');
  }

  void _endSvg(StringBuffer result) {
    result.write('</svg>');
  }

  SvgPath _beginShape(String color) {
    final SvgPath? p = _pathsByColor[color];
    if (p != null) {
      return p;
    } else {
      return _pathsByColor[color] = SvgPath();
    }
  }
}
