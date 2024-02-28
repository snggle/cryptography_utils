import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

abstract class ASvgShape extends Equatable {
  final String fill;
  final bool invert;

  const ASvgShape({
    required this.fill,
    this.invert = false,
  });

  void draw(SvgPath svgPath);

  ASvgShape transform(SvgTransformation svgTransformation);
}
