typedef LightnessFunction = double Function(double);

class JdenticonTheme {
  final double colorSaturation;
  final double grayscaleSaturation;
  final LightnessFunction colorLightness;
  final LightnessFunction grayscaleLightness;
  final String backColor;

  JdenticonTheme({
    required double colorSaturation,
    required double grayscaleSaturation,
    required this.colorLightness,
    required this.grayscaleLightness,
    required this.backColor,
  })  : colorSaturation = colorSaturation.clamp(0.0, 1.0),
        grayscaleSaturation = grayscaleSaturation.clamp(0.0, 1.0);

  JdenticonTheme.withDefaults()
      : this(
          colorSaturation: 0.5,
          grayscaleSaturation: 0.0,
          colorLightness: _calcLightness(0.4, 0.8),
          grayscaleLightness: _calcLightness(0.3, 0.9),
          backColor: 'transparent',
        );

  List<String> getAvailableColors(double hue) {
    return <String>[
      // Dark gray
      _correctHsl(hue, grayscaleSaturation, grayscaleLightness(0.0)),
      // Mid color
      _correctHsl(hue, colorSaturation, colorLightness(0.5)),
      // Light gray
      _correctHsl(hue, grayscaleSaturation, grayscaleLightness(1.0)),
      // Light color
      _correctHsl(hue, colorSaturation, colorLightness(1.0)),
      // Dark color
      _correctHsl(hue, colorSaturation, colorLightness(0.0)),
    ];
  }

  static double Function(double) _calcLightness(double defaultMin, double defaultMax) {
    List<double> range = <double>[defaultMin, defaultMax];

    return (double value) {
      final double value2 = range[0] + value * (range[1] - range[0]);
      return value2 < 0.0 ? 0.0 : (value2 > 1.0 ? 1.0 : value2);
    };
  }

  String _correctHsl(double hue, double saturation, double lightness) {
    List<double> correctors = <double>[0.55, 0.5, 0.5, 0.46, 0.6, 0.55, 0.55];
    double corrector = correctors[(hue * 6 + 0.5).floor()];
    double correctedHue = hue * 360;
    double correctedSaturation = saturation * 100;
    double correctedLightness = (lightness < 0.5 ? lightness * corrector * 2 : corrector + (lightness - 0.5) * (1 - corrector) * 2) * 100;

    return 'hsl(${correctedHue}, ${correctedSaturation}%, ${correctedLightness}%)';
  }
}
