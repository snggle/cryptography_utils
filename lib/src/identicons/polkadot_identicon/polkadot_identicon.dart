import 'dart:convert';
import 'dart:math' as math;
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/substrate/ss58_encoder.dart';
import 'package:cryptography_utils/src/hash/blake2b.dart';

/// The [PolkadotIdenticon] class is designed for creating identicons specifically
/// for representing Polkadot (and Substrate-based) addresses. These identicons
/// are a visual representation of the address, offering a unique pattern that
/// helps in easily distinguishing between different addresses.
class PolkadotIdenticon extends AIdenticon {
  static final Uint8List zeroHash = base64Decode('mrenOpehowMUBrbBaWNKnAbPuB3sMyO7TeXOb0t8oQfeU0RCp+rq+682bM/d4cuX18iE5DRM0KIwOd5xpW1jCg==');

  late final double center = iconSize / 2;
  late final double circleDiameter = 5;
  late final double drawingStart = iconSize / 2 - circleDiameter;

  PolkadotIdenticon({super.iconSize});

  /// Returns a list of [ASvgShape] objects that represent the Polkadot Identicon.
  @override
  List<SvgCircle> getShapes(String data, {bool isAlternative = false}) {
    List<Point<double>> coords = _getCircleCoords(isSixPoint: isAlternative);
    List<String> colors = _getColorPalette(data);

    List<SvgCircle> circles = <SvgCircle>[];
    for (int i = 0; i < coords.length; i++) {
      circles.add(SvgCircle(point: coords[i], fill: colors[i], diameter: circleDiameter * 2));
    }

    return <SvgCircle>[
      SvgCircle(point: const Point<double>(0, 0), fill: '#eee', diameter: iconSize),
      ...circles,
    ];
  }

  /// Returns a list of colors in HSL format that will be used to fill the circles in the identicon.
  List<String> _getColorPalette(String address) {
    Uint8List seed = _createSeed(address);
    int schemesTotal = PolkadotIdenticonScheme.schemes.map((PolkadotIdenticonScheme s) => s.frequency).reduce((int a, int b) => a + b);
    int d = ((seed[30] + seed[31] * 256) % schemesTotal).floor();
    int rot = (seed[28] % 6) * 3;
    PolkadotIdenticonScheme scheme = _findScheme(d, address);
    List<String> tmpPalette = <String>[];
    for (int i = 0; i < seed.length; i++) {
      int x = seed[i];
      int b = (x + i % 28 * 58) % 256;

      if (b == 0) {
        tmpPalette.add('#444');
      } else if (b == 255) {
        tmpPalette.add('transparent');
      } else {
        int hue = (b % 64 * 360 / 64).floor();
        int saturation = ((seed[29] * 70 / 256 + 26).floor() % 80) + 30;
        int lightness = <int>[53, 15, 35, 75][(b / 64).floor()];

        tmpPalette.add('hsl(${hue}, ${saturation}%, ${lightness}%)');
      }
    }

    List<String> palette = <String>[];
    for (int i = 0; i < scheme.colors.length; i++) {
      palette.add(tmpPalette[scheme.colors[i < 18 ? (i + rot) % 18 : 18]]);
    }

    return palette;
  }

  /// Returns the [PolkadotIdenticonScheme] that will be used to fill the circles in the identicon.
  PolkadotIdenticonScheme _findScheme(int d, String address) {
    int schemeRange = 0;
    PolkadotIdenticonScheme? scheme = PolkadotIdenticonScheme.schemes.where((PolkadotIdenticonScheme scheme) {
      schemeRange += scheme.frequency;
      return d < schemeRange;
    }).firstOrNull;

    if (scheme == null) {
      throw Exception('Unable to find schema');
    } else {
      return scheme;
    }
  }

  /// Calculates the seed that will be used to generate the identicon.
  Uint8List _createSeed(String address) {
    Uint8List hash = Blake2d().process(SS58Encoder.decode(address));
    Uint8List result = Uint8List(32);
    for (int i = 0; i < 32; i++) {
      int x = hash[i];
      result[i] = (x + 256 - zeroHash[i]) % 256;
    }
    return result;
  }

  /// Returns a list of [Point] objects that represent the coordinates of the circles in the identicon.
  List<Point<double>> _getCircleCoords({bool isSixPoint = false}) {
    double r = isSixPoint ? (center / 8 * 5) : (center / 4 * 3);
    double rroot3o2 = r * math.sqrt(3) / 2;
    double ro2 = r / 2;
    double rroot3o4 = r * math.sqrt(3) / 4;
    double ro4 = r / 4;
    double r3o4 = r * 3 / 4;

    return <Point<double>>[
      Point<double>(drawingStart, drawingStart - r),
      Point<double>(drawingStart, drawingStart - ro2),
      Point<double>(drawingStart - rroot3o4, drawingStart - r3o4),
      Point<double>(drawingStart - rroot3o2, drawingStart - ro2),
      Point<double>(drawingStart - rroot3o4, drawingStart - ro4),
      Point<double>(drawingStart - rroot3o2, drawingStart),
      Point<double>(drawingStart - rroot3o2, drawingStart + ro2),
      Point<double>(drawingStart - rroot3o4, drawingStart + ro4),
      Point<double>(drawingStart - rroot3o4, drawingStart + r3o4),
      Point<double>(drawingStart, drawingStart + r),
      Point<double>(drawingStart, drawingStart + ro2),
      Point<double>(drawingStart + rroot3o4, drawingStart + r3o4),
      Point<double>(drawingStart + rroot3o2, drawingStart + ro2),
      Point<double>(drawingStart + rroot3o4, drawingStart + ro4),
      Point<double>(drawingStart + rroot3o2, drawingStart),
      Point<double>(drawingStart + rroot3o2, drawingStart - ro2),
      Point<double>(drawingStart + rroot3o4, drawingStart - ro4),
      Point<double>(drawingStart + rroot3o4, drawingStart - r3o4),
      Point<double>(drawingStart, drawingStart),
    ];
  }
}
