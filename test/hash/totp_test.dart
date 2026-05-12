import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of TOTP.generate()', () {
    const String actualSecret = 'QEFHQDOKBGI6SQ367VVIXO4YS2WYMSWZ';

    test('Should [generate TOTP code] for a provided Base32 secret and timestamp', () {
      // Arrange
      DateTime actualTimestamp = DateTime.fromMicrosecondsSinceEpoch(1779174562796584);

      // Act
      String actualTOTP = TOTP.generate(actualSecret, timestamp: actualTimestamp);

      // Assert
      expect(actualTOTP, '907187');
    });
  });
}
