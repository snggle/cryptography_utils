import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/solana_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaUtils.parseTokenAmount()', () {
    test('Should [shift amount] by given precision number (amount = 0, precision = 9)', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.zero, ASolanaInstructionDecoded.solDecimalPrecision);

      // Assert
      Decimal expectedSOLAmount = Decimal.zero;

      expect(actualSOLAmount, expectedSOLAmount);
    });

    test('Should [shift amount] by given precision number (amount = 12345, precision = 4)', () {
      // Act
      Decimal actualTokenAmount = SolanaUtils.parseTokenAmount(BigInt.from(12345), 4);

      // Assert
      Decimal expectedTokenAmount = Decimal.parse('1.2345');

      expect(actualTokenAmount, expectedTokenAmount);
    });

    test('Should [shift amount] by given precision number (amount = 1234567890, precision = 6)', () {
      // Act
      Decimal actualTokenAmount = SolanaUtils.parseTokenAmount(BigInt.parse('1234567890'), 6);

      // Assert
      Decimal expectedTokenAmount = Decimal.parse('1234.567890');

      expect(actualTokenAmount, expectedTokenAmount);
    });

    test('Should [shift amount] by given precision number (amount = 1000000000, precision = 9)', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.from(1000000000), ASolanaInstructionDecoded.solDecimalPrecision);

      // Assert
      Decimal expectedSOLAmount = Decimal.fromInt(1);

      expect(actualSOLAmount, expectedSOLAmount);
    });
  });
}
