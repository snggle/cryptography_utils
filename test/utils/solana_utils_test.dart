import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/solana_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaUtils.parseTokenAmount()', () {
    test('Should [convert (0) token base units] to the correct human-readable token amount (0)', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.zero, ASolanaInstructionDecoded.solDecimalPrecision);

      // Assert
      Decimal expectedSOLAmount = Decimal.zero;

      expect(actualSOLAmount, expectedSOLAmount);
    });

    test('Should [convert (12345) token base units with decimal precision (4)] to the correct human-readable token amount (1)', () {
      // Act
      Decimal actualTokenAmount = SolanaUtils.parseTokenAmount(BigInt.from(12345), 4);

      // Assert
      Decimal expectedTokenAmount = Decimal.parse('1.2345');

      expect(actualTokenAmount, expectedTokenAmount);
    });

    test('Should [convert (1234567890) token base units with decimal precision (6)] to the correct human-readable token amount (1234.567890)', () {
      // Act
      Decimal actualTokenAmount = SolanaUtils.parseTokenAmount(BigInt.parse('1234567890'), 6);

      // Assert
      Decimal expectedTokenAmount = Decimal.parse('1234.567890');

      expect(actualTokenAmount, expectedTokenAmount);
    });

    test('Should [convert (1) token base units with SOL decimal precision (9)] to the correct human-readable token amount (0.000000001)', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.from(1000000000), ASolanaInstructionDecoded.solDecimalPrecision);

      // Assert
      Decimal expectedSOLAmount = Decimal.fromInt(1);

      expect(actualSOLAmount, expectedSOLAmount);
    });
  });
}
