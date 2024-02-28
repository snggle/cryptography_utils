import 'package:cryptography_utils/cryptography_utils.dart';

abstract class AIdenticon {
  final double iconSize;

  AIdenticon({
    this.iconSize = 64,
  });

  String render(String data) {
    List<ASvgShape> shapes = getShapes(data);
    return SvgRenderer(size: iconSize).renderShapes(shapes);
  }

  List<ASvgShape> getShapes(String data);
}
