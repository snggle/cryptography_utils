import 'package:decimal/decimal.dart';

class SolanaUtils {
  static const String solSymbol = 'SOL';

  static Decimal parseTokenAmount(BigInt tokenAmount, int tokenDecimalPrecision) {
    if (tokenAmount == BigInt.zero) {
      return Decimal.zero;
    }
    Decimal tokenAmountDecimal = Decimal.parse(tokenAmount.toString());
    Decimal baseUnitsInToken = Decimal.parse('1${'0' * tokenDecimalPrecision}');
    return (tokenAmountDecimal / baseUnitsInToken).toDecimal();
  }
}
