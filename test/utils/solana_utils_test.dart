import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/solana_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaUtils.parseTokenAmount()', () {
    test('Should [convert 0 lamports] to 0 SOL', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.zero, ASolanaInstructionDecoded.solDecimalPrecision);

      // Assert
      Decimal expectedSOLAmount = Decimal.zero;

      expect(actualSOLAmount, expectedSOLAmount);
    });

    test('Should [convert 1 lamport] to the correct SOL amount', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.one, ASolanaInstructionDecoded.solDecimalPrecision);

      // Assert
      Decimal expectedSOLAmount = Decimal.parse('0.000000001');

      expect(actualSOLAmount, expectedSOLAmount);
    });

    test('Should [convert arbitrary lamport amount] to the correct SOL amount', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.from(1234567890), ASolanaInstructionDecoded.solDecimalPrecision);

      // Assert
      Decimal expectedSOLAmount = Decimal.parse('1.23456789');

      expect(actualSOLAmount, expectedSOLAmount);
    });

    test('Should [convert large lamport amount] to the correct SOL amount', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.parse('12345678901234567890'), ASolanaInstructionDecoded.solDecimalPrecision);

      // Assert
      Decimal expectedSOLAmount = Decimal.parse('12345678901.23456789');

      expect(actualSOLAmount, expectedSOLAmount);
    });

    test('Should [convert 1 lamport] to the correct SOL amount', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.one, ASolanaInstructionDecoded.solDecimalPrecision);

      // Assert
      Decimal expectedSOLAmount = Decimal.parse('0.000000001');

      expect(actualSOLAmount, expectedSOLAmount);
    });

    test('Should [convert 1 token base unit] to the correct human-readable decimal token amount', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.one, 6);

      // Assert
      Decimal expectedSOLAmount = Decimal.parse('0.000001');

      expect(actualSOLAmount, expectedSOLAmount);
    });

    test('Should [convert arbitrary token amount in base units] to the correct human-readable decimal token amount', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.parse('1234567890'), 6);

      // Assert
      Decimal expectedSOLAmount = Decimal.parse('1234.567890');

      expect(actualSOLAmount, expectedSOLAmount);
    });

    test('Should [convert large token amount in base units] to the correct human-readable decimal token amount', () {
      // Act
      Decimal actualSOLAmount = SolanaUtils.parseTokenAmount(BigInt.parse('12345678901234567890'), 6);

      // Assert
      Decimal expectedSOLAmount = Decimal.parse('12345678901234.567890');

      expect(actualSOLAmount, expectedSOLAmount);
    });
  });
}
