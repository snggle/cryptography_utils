import 'package:cryptography_utils/src/utils/string_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of StringUtils.areASCIIBytes()', () {
    test('Should [return TRUE] if bytes are ASCII encoded String', () {
      // Arrange
      List<int> actualBytes = <int>[72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33];

      // Act
      bool actualResult = StringUtils.areASCIIBytes(actualBytes);

      // Assert
      expect(actualResult, true);
    });

    test('Should [return FALSE] if bytes are NOT ASCII encoded String', () {
      // Arrange
      List<int> actualBytes = <int>[1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000];

      // Act
      bool actualResult = StringUtils.areASCIIBytes(actualBytes);

      // Assert
      expect(actualResult, false);
    });
  });
}
