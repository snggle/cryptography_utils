import 'package:cryptography_utils/src/utils/map_utils.dart';
import 'package:test/test.dart';

void main() {
  Map<String, dynamic> actualMap = <String, dynamic>{
    'a': 'b',
    'c': <String, dynamic>{
      'd': 'e',
      'f': <String, dynamic>{
        'g': 'h',
        'i': 'j',
      },
    },
  };

  group('Tests of MapUtils.flattenMap()', () {
    test('Should [return flattened map] constructed from given map', () {
      // Act
      Map<String, dynamic> actualFlattenedMap = MapUtils.flattenMap(actualMap);

      // Assert
      Map<String, dynamic> expectedFlattenedMap = <String, dynamic>{
        'a': 'b',
        'c/d': 'e',
        'c/f/g': 'h',
        'c/f/i': 'j',
      };

      expect(actualFlattenedMap, expectedFlattenedMap);
    });
  });

  group('Tests of MapUtils.parseJsonToString()', () {
    test('Should [return String] representing given map (with indent)', () {
      // Act
      String actualString = MapUtils.parseJsonToString(actualMap, prettyPrintBool: true);

      // Assert
      String expectedString = '''
{
    "a": "b",
    "c": {
        "d": "e",
        "f": {
            "g": "h",
            "i": "j"
        }
    }
}''';

      expect(actualString, expectedString);
    });

    test('Should [return String] representing given map (without indent)', () {
      // Act
      String actualString = MapUtils.parseJsonToString(actualMap, prettyPrintBool: false);

      // Assert
      String expectedString = '{"a":"b","c":{"d":"e","f":{"g":"h","i":"j"}}}';

      expect(actualString, expectedString);
    });
  });
}
