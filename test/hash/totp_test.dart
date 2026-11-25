import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of TOTP.generate()', () {
    // Based on test vectors from RFC 6238: https://www.rfc-editor.org/rfc/rfc6238.html#appendix-B
    const String actualSecret = 'GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ';

    group('Tests of TOTP.generate() with valid Base32 secrets', () {
      test('Should [generate the previous window code] if [timestamp is one millisecond before the next window]', () {
        // Arrange
        DateTime actualTimestamp = DateTime.fromMillisecondsSinceEpoch(1111111109999, isUtc: true);

        // Act
        String actualTOTP = TOTP.generate(actualSecret, timestamp: actualTimestamp);

        // Assert
        const String expectedTOTP = '081804';

        expect(actualTOTP, expectedTOTP);
      });

      test('Should [generate the new window code] if [timestamp is the first millisecond into the next window]', () {
        // Arrange
        DateTime actualTimestamp = DateTime.fromMillisecondsSinceEpoch(1111111111000, isUtc: true);

        // Act
        String actualTOTP = TOTP.generate(actualSecret, timestamp: actualTimestamp);

        // Assert
        const String expectedTOTP = '050471';

        expect(actualTOTP, expectedTOTP);
      });

      test('Should [pad the code to six digits] if [the numeric code has five digits]', () {
        // Arrange
        DateTime actualTimestamp = DateTime.fromMillisecondsSinceEpoch(1111111109000, isUtc: true);

        // Act
        String actualTOTP = TOTP.generate(actualSecret, timestamp: actualTimestamp);

        // Assert
        const String expectedTOTP = '081804';

        expect(actualTOTP, expectedTOTP);
      });
    });

    group('Tests of TOTP.generate() with malformed Base32 secrets', () {
      late DateTime actualTimestamp;

      setUp(() {
        actualTimestamp = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
      });

      test('Should [throw FormatException] if [secret contains a character outside the Base32 alphabet]', () {
        // Arrange
        const String actualInvalidSecret = 'JBSWY3D0';

        // Act
        String actualGenerateTOTP() => TOTP.generate(actualInvalidSecret, timestamp: actualTimestamp);

        // Assert
        expect(actualGenerateTOTP, throwsA(isA<FormatException>()));
      });

      test('Should [throw FormatException] if [padded secret length is not a multiple of eight]', () {
        // Arrange
        const String actualInvalidSecret = 'MY=====';

        // Act
        String actualGenerateTOTP() => TOTP.generate(actualInvalidSecret, timestamp: actualTimestamp);

        // Assert
        expect(actualGenerateTOTP, throwsA(isA<FormatException>()));
      });

      test('Should [throw FormatException] if [a Base32 character follows the first padding character]', () {
        // Arrange
        const String actualInvalidSecret = 'MY=AAAAA';

        // Act
        String actualGenerateTOTP() => TOTP.generate(actualInvalidSecret, timestamp: actualTimestamp);

        // Assert
        expect(actualGenerateTOTP, throwsA(isA<FormatException>()));
      });

      test('Should [throw FormatException] if [padding starts after an incomplete Base32 symbol group]', () {
        // Arrange
        const String actualInvalidSecret = 'M=======';

        // Act
        String actualGenerateTOTP() => TOTP.generate(actualInvalidSecret, timestamp: actualTimestamp);

        // Assert
        expect(actualGenerateTOTP, throwsA(isA<FormatException>()));
      });
    });
  });
}
