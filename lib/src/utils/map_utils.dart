import 'dart:convert';

class MapUtils {
  static Map<String, dynamic> flattenMap(Map<String, dynamic> map, [String prefix = '']) {
    Map<String, dynamic> result = <String, dynamic>{};

    map.forEach((String key, dynamic value) {
      String newKey = prefix.isEmpty ? key : '$prefix/$key';

      if (value is Map<String, dynamic>) {
        result.addAll(flattenMap(value, newKey));
      } else {
        result[newKey] = value;
      }
    });

    return result;
  }

  static String parseJsonToString(dynamic json, {required bool prettyPrintBool}) {
    if (prettyPrintBool) {
      String spaces = ' ' * 4;
      JsonEncoder encoder = JsonEncoder.withIndent(spaces);
      return encoder.convert(json);
    } else {
      JsonEncoder encoder = const JsonEncoder();
      return encoder.convert(json);
    }
  }
}
