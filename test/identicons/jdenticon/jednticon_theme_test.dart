import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of JdenticonTheme.getAvailableColors()', () {
    test('Should [return List of HSL colors] basing on given settings', () {
      // Arrange
      JdenticonTheme actualJdenticonTheme = JdenticonTheme.withDefaults();

      // Act
      List<String> actualResult = actualJdenticonTheme.getAvailableColors(1);

      // Assert
      expect(actualResult, <String>[
        'hsl(360.0, 0.0%, 33.0%)',
        'hsl(360.0, 50.0%, 64.00000000000001%)',
        'hsl(360.0, 0.0%, 91.00000000000001%)',
        'hsl(360.0, 50.0%, 82.0%)',
        'hsl(360.0, 50.0%, 44.00000000000001%)'
      ]);
    });
  });
}
